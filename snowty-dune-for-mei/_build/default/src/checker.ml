open Ast
open Xntb

exception UnknownName
exception TypeError
exception LinearError
exception InterfaceError

type sessionType =
| Waiter
| Closer
| Selector of (string * int) list
| Handler of (string * int) list
| Sender of (vtyp * int)
| Receiver of (vtyp * int)

and sessionState = { sessid: int; states: Xntb.hdlrState list; styp: sessionType }

let rec secondsOf xts = 
match xts with
| [] -> []
| (_,t)::xts' -> t::(secondsOf xts')

let argTypesOf (dec:decl) = 
begin match dec with 
| Handler {bundle=_; name=_; params=ps; body=_} -> secondsOf ps
| Function {name=_; params=ps; returns=_; defn=_} -> secondsOf ps
end

let rec getFunction (f:string) (decs:decl list) = 
match decs with
| [] -> raise InterfaceError
| ((Function ({name=f'; params=_; returns=_; defn=_} as fn))::decs') 
           -> if f' = f 
              then fn 
              else getFunction f decs' 
| _::decs' -> getFunction f decs'

let rec typeIn idns x =
match idns with
| [] -> raise UnknownName
| ((y,a)::_) when x=y -> a
| (_::idns') -> typeIn idns' x

let rec typeOf decs idns e =
match e with
| Name x -> typeIn idns x
| Number _ -> IntTy
| Text _ -> StrTy
| True -> BoolTy
| False -> BoolTy
| LessEq (e1,e2) -> 
     let a1 = typeOf decs idns e1
  in let a2 = typeOf decs idns e2
  in (match (a1,a2) with
      | (IntTy,IntTy) -> BoolTy
      | (_,_) -> raise TypeError)
| Equals (e1,e2) -> 
     let a1 = typeOf decs idns e1
  in let a2 = typeOf decs idns e2
  in (match (a1,a2) with
      | (IntTy,IntTy) -> BoolTy
      | (BoolTy,BoolTy) -> BoolTy
      | (StrTy,StrTy) -> BoolTy
      | (UnitTy,UnitTy) -> BoolTy
      | (_,_) -> raise TypeError)
| Plus (e1,e2) -> 
     let a1 = typeOf decs idns e1
  in let a2 = typeOf decs idns e2
  in (match (a1,a2) with
      | (IntTy,IntTy) -> IntTy
      | (_,_) -> raise TypeError)
| Minus (e1,e2) -> 
     let a1 = typeOf decs idns e1
  in let a2 = typeOf decs idns e2
  in (match (a1,a2) with
      | (IntTy,IntTy) -> IntTy
      | (_,_) -> raise TypeError)
| Times (e1,e2) -> 
     let a1 = typeOf decs idns e1
  in let a2 = typeOf decs idns e2
  in (match (a1,a2) with
      | (IntTy,IntTy) -> IntTy
      | (_,_) -> raise TypeError)
| AndAlso (e1,e2) -> 
     let a1 = typeOf decs idns e1
  in let a2 = typeOf decs idns e2
  in (match (a1,a2) with
      | (BoolTy,BoolTy) -> BoolTy
      | (_,_) -> raise TypeError)
| OrElse (e1,e2) -> 
     let a1 = typeOf decs idns e1
  in let a2 = typeOf decs idns e2
  in (match (a1,a2) with
      | (BoolTy,BoolTy) -> BoolTy
      | (_,_) -> raise TypeError)
| Not ep -> 
     let a = typeOf decs idns ep
  in (match a with
      | BoolTy -> BoolTy
      | _ -> raise TypeError)
| If (c,e1,e2) -> 
     let a = typeOf decs idns c
  in let a1 = typeOf decs idns e1
  in let a2 = typeOf decs idns e2
  in (match (a,a1,a2) with
     | (BoolTy,IntTy,IntTy) -> IntTy
     | (BoolTy,BoolTy,BoolTy) -> BoolTy
     | (BoolTy,StrTy,StrTy) -> StrTy
     | (BoolTy,UnitTy,UnitTy) -> UnitTy
     | (_,_,_) -> raise TypeError)
| Call(f,es) -> 
     let fn = getFunction f decs
  in let _ = checkTypes decs (argTypesOf (Function fn)) idns es
  in fn.returns  

and checkType decs b idns e =
   let a = typeOf decs idns e
   in (match (b,a) with
       | (IntTy,IntTy) -> ()
       | (BoolTy,BoolTy) -> ()
       | (StrTy,StrTy) -> ()
       | (UnitTy,UnitTy) -> ()
       | (_,_) -> raise TypeError)

and checkTypes decs bs idns es = 
match (bs,es) with
| ([],[]) -> ()
| (b::bs',e::es') -> 
     let _ = checkType decs b idns e
     in checkTypes decs bs' idns es'
| (_,_) -> raise TypeError

let infoOf (s:Ast.stmt) = 
match s with
| Assign  {tag=i; _} -> i
| When    {tag=i; _} -> i
| Send    {tag=i; _} -> i
| Receive {tag=i; _} -> i
| Open    {tag=i; _} -> i
| Select  {tag=i; _} -> i
| Handle  {tag=i; _} -> i
| Start   {tag=i; _} -> i
| Stop    {tag=i; _} -> i
| Close   {tag=i; _} -> i
| Await   {tag=i; _} -> i

let rec handoff c chns = 
match chns with
| [] -> []
| (d::ds) when c = d -> ds
| (d::ds) -> d::(handoff c ds)

let rec handoffAll cs chns = 
match cs with
| [] -> chns
| (c::cs') -> handoffAll cs' (handoff c chns)     


let bundleOf {bundle=cs; name=_; params=_; body=_} = cs
let headOf {bundle=_; name=_; params=_; body=s} = infoOf s

let rec getHandler (h:string) (decs:decl list) = 
match decs with
| [] -> raise InterfaceError
| ((Handler ({bundle=_; name=h'; params=_; body=_} as hn))::decs') 
           -> if h' = h 
              then hn 
              else getHandler h decs' 
| _::decs' -> getHandler h decs'

let rec checkStop chns xtbl =            
match chns with
| [] -> xtbl
| [c] -> let _ = print_endline c in raise LinearError
| (c::cs) -> let _ = print_endline c in checkStop cs xtbl

let rec checkStart ((h,cs,i):string*(string list)*info) 
                   ((h',ds,j):string*(string list)*info)
                   (xtbl:Xntb.hdlrSessTable) =
match (cs,ds) with
| ([],[]) -> xtbl
| (c::cs',d::ds') ->
     let p = Xntb.makeHdlrState (h,c,i)
  in let q = Xntb.makeHdlrState (h',d,j)
  in xtbl |> Xntb.transSess (p,Xntb.Null,q)
          |> checkStart (h,cs',i) (h',ds',j)
| (_,_) -> raise InterfaceError  

let rec checkHandle (decs,h) i c hcs (chns,idns) xtbl = 
begin match hcs with
| [] -> xtbl
| (Case {lbl=l; cnt=t}::hcs') -> 
       let p = Xntb.makeHdlrState (h,c,i)
    in let j = infoOf t
    in let q = Xntb.makeHdlrState (h,c,j)
    in xtbl |> Xntb.transSess (p,Xntb.Handles l,q)
            |> Xntb.allTransSessBut c h chns (i,Xntb.Null,j)
            |> checkStmt (decs,h) t (chns,idns)
            |> checkHandle (decs,h) i c hcs' (chns,idns)
end

    and checkStmt (decs,h) s (chns,idns) xtbl = 
match s with
| Assign {tag=i; nme=x; vlu=e; cnt=t} ->
       let a = typeOf decs idns e
    in let idns' = (x,a)::idns
    in xtbl |> Xntb.allTransSess h chns (i, Xntb. Null, infoOf t)
            |> checkStmt (decs,h) t (chns,idns')
| Send {tag=i; vlu=e; chn=c; cnt=t} ->
       let j = infoOf t
    in let a = typeOf decs idns e
    in let p = Xntb.makeHdlrState (h,c,i)
    in let q = Xntb.makeHdlrState (h,c,j)
    in xtbl |> Xntb.transSess (p,Xntb.Sends a,q)
            |> Xntb.allTransSessBut c h chns (i,Xntb.Null,j)
            |> checkStmt (decs,h) t (chns,idns)
| Select {tag=i; lbl=l; chn=c; cnt=t} ->
       let j = infoOf t
    in let p = Xntb.makeHdlrState (h,c,i)
    in let q = Xntb.makeHdlrState (h,c,j)
    in xtbl |> Xntb.transSess (p,Xntb.Selects l,q) 
            |> Xntb.allTransSessBut c h chns (i,Xntb.Null,j)
            |> checkStmt (decs,h) t (chns,idns)
| Receive {tag=i; nme=x; typ=a; chn=c; cnt=t} ->
       let j = infoOf t
    in let p = Xntb.makeHdlrState (h,c,i)
    in let q = Xntb.makeHdlrState (h,c,j)
    in xtbl |> Xntb.transSess (p,Xntb.Receives a,q)
            |> Xntb.allTransSessBut c h chns (i,Xntb.Null,j)
            |> checkStmt (decs,h) t (chns,(x,a)::idns)      
| Open {tag=i; ch1=c1; ch2=c2; cnt=t} ->
       let j = infoOf t
    in let q1 = Xntb.makeHdlrState (h,c1,j)
    in let q2 = Xntb.makeHdlrState (h,c2,j)
    in xtbl |> Xntb.allTransSess h chns (i,Xntb.Null,j)
            |> Xntb.beginSess q1
            |> Xntb.beginSess q2
            |> Xntb.dualityMark (q1,q2)
            |> checkStmt (decs,h) t (c1::c2::chns,idns)
| Start {tag=i; hfs=cs; hnd=h'; vls=es; cnt=t} -> 
       let hn = getHandler h' decs
    in let _ = checkTypes decs (argTypesOf (Handler hn)) idns es
    in let chns' = handoffAll cs chns
    in xtbl |> checkStart (h,cs,i) (h',bundleOf hn,headOf hn)
            |> Xntb.allTransSess h chns' (i,Xntb.Null,infoOf t)
            |> checkStmt (decs,h) t (chns',idns)
| Stop {tag=_} -> 
       xtbl |> checkStop chns
| Close {tag=i; chn=c; cnt=t} -> 
       let chns' = handoff c chns
    in let j = infoOf t
    in let p = Xntb.makeHdlrState (h,c,i)
    in let q = Xntb.makeHdlrState (h,c,j)
    in xtbl |> Xntb.transSess (p,Xntb.Closes,q)
            |> Xntb.endSess q
            |> Xntb.allTransSess h chns' (i,Xntb.Null,j)
            |> checkStmt (decs,h) t (chns',idns)
| Await {tag=i; chn=c; cnt=t} -> 
       let chns' = handoff c chns
    in let j = infoOf t
    in let p = Xntb.makeHdlrState (h,c,i)
    in let q = Xntb.makeHdlrState (h,c,j)
    in xtbl |> Xntb.transSess (p,Xntb.Awaits,q) 
            |> Xntb.endSess q 
            |> Xntb.allTransSess h chns' (i,Xntb.Null,j)
            |> checkStmt (decs,h) t (chns',idns)
| When {tag=i; cnd=e; tru=t1; fls=t2} ->
       let _ = checkType decs BoolTy idns e
    in xtbl |> Xntb.allTransSess h chns (i,Null,infoOf t1)
            |> checkStmt (decs,h) t1 (chns,idns)
            |> Xntb.allTransSess h chns (i,Null,infoOf t2) 
            |> checkStmt (decs,h) t2 (chns,idns)
| Handle {tag=i; chn=c; css=hs} ->
    checkHandle (decs,h) i c hs (chns,idns) xtbl

let checkFunction decs {name=_; params=idns; returns=t; defn=e} = 
      checkType decs t idns e

let checkHandler decs {bundle=chns; name=h; params=idns; body=s} xtbl =
       xtbl |> checkStmt (decs,h) s (chns,idns)
            |> List.fold_right (fun c -> Xntb.beginSess (Xntb.makeHdlrState (h,c,(infoOf s)))) chns

let rec checkPrgm decs0 decs xtbl = 
match decs with 
| [] -> 
       xtbl
| (Function fn)::decs' ->
       let _ = checkFunction decs0 fn
       in checkPrgm decs0 decs' xtbl
| (Handler hn)::decs' ->
       xtbl |> checkHandler decs0 hn
            |> checkPrgm decs0 decs'

let sessionName 
    {handler=h;channel=c;statement=_} =
  h^"#"^c

let transcribeSessions (xntb:Xntb.hdlrSessTable) = 
      let q0s = xntb.sessions
   in List.map 
      (fun q -> Xntb.sessSuiteOf (sessionName q) [q] xntb) q0s

let check (Program decs) =
       let xntb = (Xntb.makeHdlrSessTable ()) |> checkPrgm decs decs
    in let bhs = transcribeSessions xntb
    in bhs
