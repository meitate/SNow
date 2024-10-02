open Ast

type sessId = int

let sessIdCounter = ref 0
let genSessId () = (sessIdCounter := (!sessIdCounter) + 1;
                    !sessIdCounter)

let sessIdTable = ref []
let newSessId ((h, c, t):string*string*Ast.info) =
  (let id = genSessId()
    in (sessIdTable := (id,(h,c,t))::(!sessIdTable)))       

type sess =
| Waiter
| Closer
| Linker
| Sender of { data:vtyp; cont:sessId }
| Receiver of { data:vtyp; cont:sessId }
| Handoffer of { hdff:sessId; cont:sessId }
| Acceptor of { hdff:sessId; cont:sessId }
| Selector of { labl:string; cont:sessId }
| Handler of ({ labl:string; cont:sessId } list)
| Takeover of { cont:sessId }

type sessTabl = {
  entries: ((int * sessTablEntry) list);
  duals: ((int * int) list);
}

type vtypTabl = (string * vtyp) list
type chanSessTabl = (string * sessId) list

let checkStmt (decs,h)
              (s:stmt) 
              (chtb:chanSessTabl,idtb:vtypTabl)
              (sntb:sessTabl) =
match s with
(*  
     H;G|- e:a   H;D;G,x:a |= t ok
    ---------------------------------
     H;D;G |= { let x := e; t } ok 
 *)
| Assign { tag=i; nme=x; vlu=e; cnt=t } ->
       let a = typeOf decs idtb e
    in let idtb' = (x,a)::idtb
    in sntb |> checkStmt (decs,h) t (chtb,idtb') 
(*  
     H;G|- e:a   H;D;G,x:a |= t ok
    ---------------------------------
     H;D;G |= { let x := e; t } ok 
 *)
| Send { tag=i; vlu=e; chn=c; cnt=t } ->
       let a = typeOf decs idtb e
    in let A = chtbLookup c
    in let B = newSessId (h,c,infoOf t)
    in let chtb' = chtbUpdate (c,B)
    in sntb |> sntbAdd (A, Sender { data=a; cont=B }) 
            |> checkStmt (decs,h) t (chtb',idtb)
(*  
       H;G |- e : a  A=!a.B  H;D,c:B;G,x:a |= t ok
    ---------------------------------------------
     H;D,c:A;G |= { receive x:a <- c; t } ok 
 *)
| Receive { tag=i; nme=x; typ=a; chn=c; cnt=t } ->
       let A = chtbLookup c
    in let B = newSessId (h,c,infoOf t)
    in let chtb' = chtbUpdate (c,B)
    in sntb |> sntbAdd (A, Receiver { data=a; cont=B }) 
            |> checkStmt (decs,h) t (chtb',idtb)


let makeSessId (h,c,w) sntb =
  match sntb.entries with 
  | [] -> (let sessid = newSessId ()
        in let 
  



let checkStmt (decs,h) s 
              (chtb:chanSessTabl,idtb:varTypeTabl)
              (sntb:sessTypeTabl) = 
match s with

(*  
     H;G|- e:a   H;D;G,x:a |= t ok
    ---------------------------------
     H;D;G |= { let x := e; t } ok 
 *)
| Assign {tag=i;nme=x;vlu=e;cnt=t} ->
       let a = typeOf decs idtb e
    in let idtb' = (x,a)::idtb
    in sntb |> checkStmt (decs,h) t (chtb,idtb')

(*  
       H;G |- e:a  A=?a.B  H;D,c:B;G |= t ok
    ----------------------------------------
     H;D,c:A;G |= { send e -> c; t } ok 
 *)
| Send { tag=i; vlu=e; chn=c; cnt=t } ->
       let a = typeOf decs idtb e
    in let A = chtbLookup c
    in let B = makeSessId (h,c,infoOf t)
    in let chtb' = chtbUpdate (c,B)
    in sntb |> sntbAdd (A, Sender { data=a; cont=B }) 
            |> checkStmt (decs,h) t (chtb',idtb)

(*  
       H;G |- e : a  A=!a.B  H;D,c:B;G,x:a |= t ok
    ---------------------------------------------
     H;D,c:A;G |= { receive x:a <- c; t } ok 
 *)
| Receive { tag=i; nme=x; typ=a; chn=c; cnt=t } ->
       let A = chtbLookup c
    in let B = makeSessId (h,c,infoOf t)
    in let chtb' = chtbUpdate (c,B)
    in sntb |> sntbAdd (A, Receiver { data=a; cont=B }) 
            |> checkStmt (decs,h) t (chtb',idtb)
(*  
         A={&l.B...}  H;D,c:B;G |= t ok
    ----------------------------------------
     H;D,c:A;G |= { select l -> c; t } ok 
 *)

| Select { tag=i; lbl=l; chn=c; cnt=t } ->
       let A = chtbLookup c
    in let B = makeSessId (h,c,infoOf t)
    in let chtb' = chtbUpdate (c,B)
    in sntb |> sntbAdd (A, Selector { labl=l; cont=B }) 
            |> checkStmt (decs,h) t (chtb',idtb)
(*  
      H;G |- e:a A=!C.B H;D,c:B,d:C;G |= t ok
    --------------------------------------------
     H;D,c:A; G |= { accept d <- c; t } ok 
 *)

| Accept { tag=i; hnd=d; chn=c; cnt=t } ->
       let A = chtbLookup c
    in let C0 = makeSessId (h,d,i)
    in let B = makeSessId (h,c,infoOf t)
    in let C = makeSessId (h,d,infoOf t)
    in let chtb' = chtb |> chtbUpdate (c,B)
                        |> chtbAdd (d,C0)
                        |> chtbUpdate (d,C)
    in sntb |> sntbAdd (A, Acceptor { hdff=C0; cont=B })
            |> sntbAdd (C0, Takeover { cont=C })
            |> checkStmt (decs,h) t (chtb',idtb)

(*  
           A=?C.B  H;D,c:B;G,x:a |= t ok
    ---------------------------------------------
     H; D,d:C,c:A; G |= { handoff d -> c; t } ok 
 *)

| Handoff { tag=i; hnd=d; chn=c; cnt=t } ->
       let A = chtbLookup c
    in let C = chtbLookup d
    in let B = makeSessId (h,c,infoOf t)
    in let chtb' = chtb |> chtbUpdate (c,B)
                        |> chtbDelete d
    in sntb |> sntbAdd (A, Handoffer { hdff=C; cont=B })
            |> sntbAdd (C, Releaser)
            |> checkStmt (decs,h) t (chtb',idtb)

(*  
      A=~B  H;D,c:A;d:B;G |= t ok
    -----------------------------------
     H;D;G |= { open c <-> d; t } ok 
 *)

| Open { tag=i; chs=(c,d); cnt=t } ->
       let A0 = makeSessId (h,c,i)
    in let B0 = makeSessId (h,d,i)
    in let A = makeSessId (h,c,infoOf t)
    in let B = makeSessId (h,d,infoOf t)
    in let chtb' = chtb |> chtbAdd (c,A0)
                        |> chtbAdd (d,B0)
                        |> chtbUpdate (c,A)
                        |> chtbUpdate (d,B)
    in sntb |> sntbAdd (A0, Opener { cont=A })
            |> sntbAdd (B0, Opener { cont=B })
            |> sntbAddDual (A,B)
            |> checkStmt (decs,h) t (chtb4,idtb)

(*  
      A=~B  H;D;G |= t ok
    -----------------------------------
     H;D,c:A,d:B;G |= { link c <-> d; t } ok 
 *)

| Link { tag=i; chs=(c,d); cnt=t) ->
       let A = chtbLookup c
    in let B = chtbLookup d
    in let chtb' = chtb |> chtbDelete c
                        |> chtbDelete d
    in sntb |> sntbAdd (A, Linker)
            |> sntbAdd (B, Linker)
            |> sntbAddDual (A,B)
            |> checkStmt (decs,h) t (chtb',idtb)

(*  
            H;D;G |= t ok
    ---------------------------------
     H;D,c:?;G |= { close c; t } ok 
 *)

| Close { tag=i; chn=c; cnt=t } -> 
       let A = chtbLookup c
    in let chtb' = chtb |> chtbDelete c
    in sntb |> sntbAdd (A, Closer)
            |> checkStmt (decs,h) t (chtb',idtb)

(*  
            H;D;G |= t ok
    ---------------------------------
     H;D,c::!;G |= { await c; t } ok 
 *)

| Await { tag=i; chn=c; cnt=t } -> 
       let A = chtbLookup c
    in let chtb' = chtb |> chtbDelete c
    in sntb |> sntbAdd (A, Waiter)
            |> checkStmt (decs,h) t (chtb',idtb)

(*
                G |- ei:ai   H;D;G |= t ok
    ------------------------------------------------------
     H,h:(a1,...) -> <d1::A1,...>;
     D,c1::A1...;G |= { start <c1,...> h (e1,...); t } ok 
  *)

| Start { tag=i; hfs=cs; nme=h'; vls=es; cnt=t } -> 
       let hn = getHandler h' decs
    in let hdr = headerOf hn
    in let ifc = bundleOf hn
    in let _ = if List.length cs = List.length ifc 
               then () 
               else raise InterfaceError 
    in let _ = checkTypes decs (argTypesOf (Handler hn)) idtb es
    in let cs_ds = List.combine cs ifc 
    in let chtb' = chtb |> List.fold_right chtbDelete cs
    in let fldh (c,d) = 
             let A = chtbLookup c chtb
          in let B = makeSessId (h',d,hdr)
          in sntbAdd (A,Takeover {cont=B})
    in sntb |> List.fold_right fldh cs_ds
            |> checkStmt (decs,h) t (chtb',idtb)

| Stop _ -> if chtbIsEmpty chtb then sntb else raise LinearError

| When { tag=i; cnd=e; tru=t1; fls=t2 } ->
       let A = 
    in xtbl |> Xntb.allTransSess h chns (i,Null,infoOf t1)
            |> checkStmt (decs,h) t1 (chns,idns)
            |> Xntb.allTransSess h chns (i,Null,infoOf t2) 
            |> checkStmt (decs,h) t2 (chns,idns)

| Handle { tag=i; chn=c; css=hs } ->
    checkHandle (decs,h) (i,c,hs) (chtb,idtb) sntb

and checkHandle (decs,h) (i,c,hs) (chtb:chanSessTabl,idtb:varTypeTabl) (sntb:sessTypeTabl) = 


