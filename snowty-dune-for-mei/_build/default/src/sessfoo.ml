open Ast

type sessId = int

let sessIdCounter = ref 0
let generateSessId () = (sessIdCounter := (!sessIdCounter) + 1;
                    !sessIdCounter)


let sessIdTable = ref []
let lookupSessId ((h, c, t):string*string*Ast.info) ssidtabl =
  (match ssidtabl with
   | [] = None
   | ((id,(h',c',t'))::_) when h=h' && c=c' && t=t' -> Some id
   | (_::st') -> lookupSessId (h,c,t) st'

let getSessId ((h, c, t):string*string*Ast.info) =
  ( let ido = lookupSessId (h,c,t) (!sessIdTable)
    in (match ido with 
        | None -> (let id = generateSessId()
                   in (sessIdTable := (id,(h,c,t))::(!sessIdTable);
                       id))
        | Some id -> id))
   



let 

type traceTrans =
| Waiter
| Closer
| Linker
| Releaser
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
       H;G |- e:a  A=!a.B  H;D,c:B;G |= t ok
    ----------------------------------------
     H;D,c:A;G |= { send e -> c; t } ok 
 *)
| Send { tag=i; vlu=e; chn=c; cnt=t } ->
       let a = typeOf decs idtb e
    in let A = chtbLookup c
    in let B = getSessId (h,c,infoOf t)
    in let chtb' = chtbUpdate (c,B)
    in sntb |> sntbAdd (A, Sender { data=a; cont=B }) 
            |> checkStmt (decs,h) t (chtb',idtb)
(*  
       H;G |- e : a  A=?a.B  H;D,c:B;G,x:a |= t ok
    ---------------------------------------------
     H;D,c:A;G |= { receive x:a <- c; t } ok 
 *)
| Receive { tag=i; nme=x; typ=a; chn=c; cnt=t } ->
       let A = chtbLookup c
    in let B = getSessId (h,c,infoOf t)
    in let chtb' = chtb |> chtbUpdate (c,B)
    in sntb |> sntbAdd (A, Receiver { data=a; cont=B }) 
            |> checkStmt (decs,h) t (chtb',idtb)
(*  
            H;D;G |= t ok
    ---------------------------------
     H;D,c:!;G |= { close c; t } ok 
 *)
| Close { tag=i; chn=c; cnt=t } -> 
       let A = chtbLookup c
    in let chtb' = chtb |> chtbDelete c
    in sntb |> sntbAdd (A, Closer)
            |> checkStmt (decs,h) t (chtb',idtb)
(*  
            H;D;G |= t ok
    ---------------------------------
     H;D,c::?;G |= { await c; t } ok 
 *)
| Await { tag=i; chn=c; cnt=t } -> 
       let A = chtbLookup c
    in let chtb' = chtb |> chtbDelete c
    in sntb |> sntbAdd (A, Waiter)
            |> checkStmt (decs,h) t (chtb',idtb)
(*  
       H;G |- e:a  A=!C.B  H;D,c:B;G |= t ok
    ----------------------------------------
     H;D,c:A,d:C;G |= { handoff d -> c; t } ok 
 *)
| Handoff { tag=i; hff=d; chn=c; cnt=t } ->
       let a = typeOf decs idtb e
    in let A = chtbLookup c
    in let B = getSessId (h,c,infoOf t)
    in let C = chtbLookup d
    in let chtb' = chtb |> chtbUpdate (c,B)
                        |> chtbDelete d
    in sntb |> sntbAdd (A, Handoffer { hdff=C; cont=B }) 
            |> sntbAdd (C, Releaser)
            |> checkStmt (decs,h) t (chtb',idtb)
(*  
        A=?C.B  H;D,c:B,d:C;G |= t ok
    --------------------------------------
     H;D,c:A;G |= { accept d <- c; t } ok 
 *)
| Accept { tag=i; acc=d; chn=c; cnt=t } ->
       let A = chtbLookup c
    in let B = getSessId (h,c,infoOf t)
    in let C = getSessId (h,d,infoOf t)
    in let chtb' = chtb |> chtbUpdate (c,B)
                        |> chtbAdd (d,C)
    in sntb |> sntbAdd (A, Acceptor { hdff=C; cont=B }) 
            |> sntbInit C
            |> checkStmt (decs,h) t (chtb',idtb)
(*  
         A=+l.B  H;D,c:B;G |= t ok
    ----------------------------------------
     H;D,c:A;G |= { select l -> c; t } ok 
 *)
| Select { tag=i; lbl=l; chn=c; cnt=t } ->
       let A = chtbLookup c
    in let B = getSessId (h,c,infoOf t)
    in let chtb' = chtbUpdate (c,B)
    in sntb |> sntbAdd (A, Selector { labl=l; cont=B }) 
            |> checkStmt (decs,h) t (chtb',idtb)
(*  
      A=~B  H;D,c:A;d:B;G |= t ok
    -----------------------------------
     H;D;G |= { open c <-> d; t } ok 
 *)
| Open { tag=i; ch1=c; ch2=d; cnt=t } ->
    in let A = getSessId (h,c,infoOf t)
    in let B = getSessId (h,d,infoOf t)
    in let chtb' = chtb |> chtbAdd (c,A)
                        |> chtbAdd (d,B)
    in sntb |> sntbInit A
            |> sntbInit B
            |> sntbDual (A,B)
            |> checkStmt (decs,h) t (chtb',idtb)
(*  
      A=~B  H;D;G |= t ok
    -----------------------------------
     H;D,c:A,d:B;G |= { link c <-> d; t } ok 
 *)
| Link { tag=i; ch1=c; ch2=d; cnt=t) ->
       let A = chtbLookup c
    in let B = chtbLookup d
    in let chtb' = chtb |> chtbDelete c
                        |> chtbDelete d
    in sntb |> sntbAdd (A, Linker)
            |> sntbAdd (B, Linker)
            |> sntbDual (A,B)
            |> checkStmt (decs,h) t (chtb',idtb)  
(*
                G |- ei:ai   H;D;G |= t ok
    ------------------------------------------------------
     H,h:(a1,...) -> <d1::B1,...>;
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
    in let fldh (ci,di) = 
             let Ai = chtbLookup ci chtb
          in let Bi = getSessId (h',di,hdr)
          in sntbAdd (Ai,Takeover {cont=Bi})
    in sntb |> List.fold_right fldh cs_ds
            |> checkStmt (decs,h) t (chtb',idtb)
(*
    -----------------------
     H;.;G |= { stop; } ok 
  *)
| Stop _ -> if chtbIsEmpty chtb then sntb else raise LinearError
(*
     G |- e : bool   H;D;G |= si ok
    -----------------------------------------------
     H;D;G |= when e do { t1 } otherwise { t2 } ok 
  *)
| When { tag=i; cnd=e; tru=t1; fls=t2 } ->
    sntb |> checkStmt (decs,h) t1 (chns,idns)
         |> checkStmt (decs,h) t2 (chns,idns)
(*
          A = {... & li.Bi & ...}   H;D,c:Bi;G |= i ok
    --------------------------------------------------------
     H;D,c:A;G |= handle c of {... | li -> { ti } | ...} ok
  *)
| Handle { tag=i; chn=c; css=hs } ->
       let A = chtbLookup c
    in let lBs = map (fun (Case {lbl=li;cnt=ti}) -> 
                     {labl=li; cont=getSessId (h,c,infoOf ti)}) hs
    in let checkCases sessions handles sntbi = 
             begin 
             match ((sessions,handles) with
             | ([],[]) -> sntbi
             | ({labl=li,cont=Bi}::lBs',(Case{lbl=li;cnt=ti})::hs') -> 
                  let chtbi = chtb |> chtbUpdate (c,Bi)
                  in sntbi |> checkStmt (decs,h) ti (chtbi,idtb)
                           |> checkCases lBs' hs'
             end
    in sntb |> checkCases lBs hs
            |> sntbAdd (A,(Handler lBs))


let checkHandler decs 
                 ({ bundle=cs; 
                    name=h; 
                    params=ps; 
                    body=s })
                 sntb
      let chtb = map (fun ci -> (ci,getSessId (h,ci,s)) cs
   in sntb |> List.fold_right (fun (_,Ai) -> sntbInit Ai) chtb
           |> checkStmt (decs,h) s (chtb,ps)

let checkFunction decs {name=_; params=idns; returns=t; defn=e} = 
      checkType decs t idns e

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

   
type sessionEntry = { id:sessionId; set:(stateId list); kind:session }

type sessionKind = 
| Wait
| Close
| Send of {data:vtypId; cont:sessionId} 
| Receive of {data:vtypId; cont:sessionId} 
| Handle of ({label:string; cont:sessionId} list)
| Select of ({label:string; cont:sessionId} list)
| Open

type sessionTable = sessionEntry list



let rec delta (traces:traceTransTable)
              (s:stateId) 
              (txs:traceTrans list) 
              (toVisit:stateId list) (visited:stateId list)
              (sstb:sessionTable) =
begin match txs with
      | [] -> (toVisit,sssu)
      | ((xn,qs)::rxns') -> 
          let (_,(t,sssu1)) = getSess qs sssu
          in let sssu2 = addSessTrans (s,xn,t) sssu1
          in if List.mem t visited
             then searchTrans s rxns' toVisit visited sssu2
             else searchTrans s rxns' (t::toVisit) visited sssu2
end


let rec searchTracesFrom (toVisit:stateId list) (visited:stateId list)
                         (sstb:sessionTable) =
begin match toVisit with
| [] -> sstb
| (s::ss) -> 
    if List.mem s visited 
    then searchFrom ss visited sstb
    else let qs = statesWithCode s sssu.sessions
      in let rxns = allReactionsFrom qs hstb
      in let (ss',sssu') = searchTrans s rxns ss visited sssu
      in searchFrom ss' (s::visited) sssu'
end

let sessionFrom (qs:stateId list) (traces:traceTable) = 
  let rec searchFrom (toVisit:stateId list) (visited:stateId list) 
                     (sstb:sessionTable) =

    
      in
    begin match toVisit with
      | [] -> sssu
      | (s::ss) -> 
         if List.mem s visited 
         then searchFrom ss visited sssu
         else let qs = statesWithCode s sssu.sessions
           in let rxns = allReactionsFrom qs hstb
           in let (ss',sssu') = searchTrans s rxns ss visited sssu
           in searchFrom ss' (s::visited) sssu'
    end
  in let sssu0 = makeSessSuite id qs
  in let sssu1 = searchFrom [sssu0.start] [] sssu0
  in sssu1



sessionStepFrom p step tx =
begin match tx of
| [] -> step
| (tx::txs') 
| ((p,Sender(a,q)),None) => Sends(a,[q])
| (


let incorporateLabelTrans (l',q') lqss =
begin match lqss with
| [] => [(l',q')]
| ((l,qs)::lqss') when l = l' => ((l',q'::qs)::lqss')
| (lqs::lqss') => lqs::(incorporateSelection (l',q') lqss')
end

let traceTransToSessionStep tx step =
begin match (tx,step) with
(* first transition *)
| (Sender (a,q), None) => Sends (a,[q])
| (Receiver (a,q), None) => Receives (a,[q])
| (Selector (l,q), None) => Selects ([(l,[q])])
| (Handler lqs, None) => let singleton (l,q) = (l,[q])
                         in Handles (List.map singleton lqs)
| (Closer,None) => Closes
| (Awaiter,None) => Awaits
(* incorporate transition *)
| (Sender (a,q), Sends(b,qs)) when a == b => 
     Sends (a,q::qs)          (* should unify a with b someday *)
| (Receiver (a,q), Receives(a,[q])) => 
     Receieves (a,q::qs)      (* should unify a with b someday *)
| (Selector (l,q), Selects lqss) => Selects (incorporateLabelTrans (l,q) lqss)
| (Handler lqs, Handles lqss) => 
    Handles (List.fold_right incorporateLabelTrans lqs lqss)
| (Closer,Closes) => Closes
| (Awaiter,Awaits) => Awaits
| _ => raise Error

let sessionStepFrom qs traces = 
     let txs  = filterTraceWithLeftFrom traces qs
  in let step = List.fold_right traceTransToSessionStep txs None
  in begin match step with
   
  
  
  





let rec allTransFrom txs step =
begin txs of
| [] -> step
| (tx::txs') -> allTransFrom txs' (transFrom tx step)
end



