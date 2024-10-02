open Ast

exception CaseMismatchError
exception NoCodeError

(* 


*)

type action =
| Null
| Sends of vtyp
| Receives of vtyp
| Selects of string
| Handles of string
| Closes
| Awaits

type hdlrState = 
  { handler: string;
    channel: string;
    statement: info;
  }

type hdlrSessTable = 
  { 
    sessions: hdlrState list;
    (* Null state *)
    terminals: hdlrState list; 
    transitions: (hdlrState * action * hdlrState) list;
    duals: (hdlrState * hdlrState) list; 
  }

type sessCode = int

type sess = 
  { 
    code: sessCode; 
    states: hdlrState list
  }

type sessSuite = 
  { 
    name: string;
    start: sessCode;
    transitions: (sessCode * action * sessCode) list;
    sessions: sess list;
    size: int
  } 

let typeString a =
match a with
| IntTy -> "int"
| BoolTy -> "bool"
| UnitTy -> "unit"
| StrTy -> "string"

let transString xn =
match xn with 
| Null -> ""
| Sends t -> "!"^(typeString t)^";"
| Receives t -> "?"^(typeString t)^";"
| Selects s -> "+!"^s^";"
| Handles s -> "+?"^s^":"
| Closes -> "!;."
| Awaits -> "?;."

let positionString (ln,cn) =
  (string_of_int ln) ^ ":" ^ (string_of_int cn)

let actionString xn =
match xn with 
| Null -> "nothing"
| Sends t -> "sending "^(typeString t)
| Receives t -> "receiving "^(typeString t)
| Selects s -> "selecting "^s^";"
| Handles s -> "handling "^s^":"
| Closes -> "closing"
| Awaits -> "awaiting"

let rec coalesceReactions (xn:hdlrState*action*hdlrState) 
                     (rxns:(action*hdlrState list) list) = 
match (xn,rxns) with
| ((_,Null,_),_) -> 
         rxns
| ((_,Selects l,p),[]) ->
         [(Selects l,[p])]
| ((_,Selects l,p),(Selects m,qs)::rxns') -> 
         if l=m then (Selects l,p::qs)::rxns'
                else (Selects m,qs)::(coalesceReactions xn rxns')
| ((_,Handles l,p),[]) ->
         [(Handles l,[p])]
| ((_,Handles l,p),(Handles m,qs)::rxns') -> 
         if l=m then (Handles l,p::qs)::rxns'
                else (Handles m,qs)::(coalesceReactions xn rxns')
| ((_,Sends a,p),[]) -> 
         [(Sends a,[p])]
| ((_,Sends a,p),[(Sends b,qs)]) when a=b->
         [(Sends b,p::qs)]
| ((_,Receives a,p),[]) -> 
         [(Receives a,[p])]
| ((_,Receives a,p),[(Receives b,qs)]) when a=b->
         [(Receives b,p::qs)]
| ((_,Closes,p),[]) -> 
         [(Closes,[p])]
| ((_,Closes,p),[(Closes,_)]) -> 
         [(Closes,[p])]
| ((_,Awaits,p),[]) -> 
         [(Awaits,[p])]
| ((_,Awaits,p),[(Awaits,_)]) -> 
         [(Awaits,[p])]
| ((_,a1,{handler=_;channel=_;statement={tag=_;line=ln1;column=cn1}}),((a2,{handler=_;channel=_;statement={tag=_;line=ln2;column=cn2}}::_)::_)) -> begin
         print_endline ((actionString a1)^" at "^positionString(ln1,cn1)^" versus "^(actionString a2)^" at "^positionString(ln2,cn2));
         raise CaseMismatchError
           end
| (_,_) -> raise CaseMismatchError
    

let allReactionsFrom (qs:hdlrState list) (hstb:hdlrSessTable) =

     let rec nullClosure (toSee:hdlrState list) 
                    (seen:hdlrState list) =
             let rec nullsFrom (p:hdlrState) 
                               (qs:hdlrState list) 
                               (xns:(hdlrState * action * hdlrState) list) =
             begin match xns with 
             | [] -> qs
             | ((q1,Null,q2)::xns') when q1=p -> 
                     nullsFrom p (q2::qs) xns'
             | (_::xns') ->
                     nullsFrom p qs xns'
             end
             in
      begin match toSee with
      | [] -> seen
      | (p::ps) when List.mem p seen -> 
              nullClosure ps seen
      | (p::ps) -> 
              let qs = nullsFrom p [] hstb.transitions
              in nullClosure (qs @ ps) (p::seen)
      end

      in let rec allTransFrom (qs:hdlrState list)
                              (xns:(hdlrState*action*hdlrState) list) =
      begin match xns with
      | [] -> []
      | (p,_,_)::xns' when (not (List.mem p qs)) -> 
              allTransFrom qs xns'
      | xn::xns' -> 
              xn::(allTransFrom qs xns')
      end

      in
   let qs' = nullClosure qs []
in let xns = allTransFrom qs' hstb.transitions
in let rxns = List.fold_right coalesceReactions xns []
in rxns

let hdlrStateLeq {handler=h1; channel=c1; statement={ tag=i1; line=_; column=_ }}
             {handler=h2; channel=c2; statement={ tag=i2; line=_; column=_ }} =
     h1 < h2 || (h1 = h2 && (c1 < c2 || (c1 = c2 && i1 <= i2)))

let rec hdlrStateSetEq (sorted_ps:hdlrState list)
                       (sorted_qs:hdlrState list) = 
begin match (sorted_ps,sorted_qs) with
| ([],[]) -> true
| (p::sps',q::sqs') when p = q -> hdlrStateSetEq sps' sqs'
| (_,_) -> false
end

let rec hdlrStateSetLeq (sorted_ps:hdlrState list)
                        (sorted_qs:hdlrState list) = 
begin match (sorted_ps,sorted_qs) with
| ([],_) -> true
| (_,[]) -> false
| (p::sps',q::sqs') when p = q -> hdlrStateSetLeq sps' sqs'
| (p::_,q::_) -> hdlrStateLeq p q
end

let rec sortHdlrStateSet (sorted_ps:hdlrState list) 
                         (unsorted_ps:hdlrState list) =  
    let rec insert (q:hdlrState) 
                   (sorted_ps:hdlrState list) =
      begin match sorted_ps with 
      | [] -> [q]
      | (p::sps') when hdlrStateLeq p q -> p::(insert q sps')
      | _ -> q::sorted_ps
      end 
    in

  begin match unsorted_ps with
  | [] -> sorted_ps
  | (p::ups) -> sortHdlrStateSet (insert p sorted_ps) ups
  end

let makeSessSuite (nm:string)
                  (unsorted_qs:hdlrState list) = 
    let s0 = { code=0; states=sortHdlrStateSet [] unsorted_qs }
    in 
  { name=nm; start=0; transitions=[];sessions=[s0];size=1 }

let addSessTrans (xn:sessCode*action*sessCode) 
                 (sssu:sessSuite) = 
  { sssu with transitions=xn::sssu.transitions }

let addSess (qs:hdlrState list) 
            (sssu:sessSuite) = 
    let n = sssu.size in
    let s = { code=sssu.size; states=qs }
    in 
  (n, { sssu with sessions=s::sssu.sessions; size=n+1 })

let getSess (unsorted_qs:hdlrState list) 
            (sssu:sessSuite) =   
    let rec lookup qs ss =
      begin match ss with
      | [] -> None 
      | ({ code=sc; states=ps }::_) when hdlrStateSetEq ps qs -> Some sc
      | (_::ss') -> lookup qs ss'
      end
    in let sorted_qs = sortHdlrStateSet unsorted_qs []
    in let maybe_sc = lookup sorted_qs sssu.sessions
    in 
  begin match maybe_sc with
  | Some sc -> (true, (sc, sssu))
  | None -> (false, addSess sorted_qs sssu)
  end

let rec statesWithCode bc ss = 
   match ss with
   | [] -> raise NoCodeError
   | ({ code=bc'; states=ps }::_) when bc=bc' -> ps
   | (_::ss') -> statesWithCode bc ss' 

let sessSuiteOf id qs hstb = 
  let rec searchFrom (toVisit:sessCode list) (visited:sessCode list) 
                     (sssu:sessSuite) =

    let rec searchTrans (s:sessCode) 
                          (rxns:(action*(hdlrState list)) list) 
                          (toVisit:sessCode list) (visited:sessCode list)
                          (sssu:sessSuite) =
      begin match rxns with
      | [] -> (toVisit,sssu)
      | ((xn,qs)::rxns') -> 
          let (_,(t,sssu1)) = getSess qs sssu
          in let sssu2 = addSessTrans (s,xn,t) sssu1
          in if List.mem t visited
             then searchTrans s rxns' toVisit visited sssu2
             else searchTrans s rxns' (t::toVisit) visited sssu2
      end
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

let makeHdlrState (h,c,i) = 
  { handler=h; channel=c; statement=i}

let makeHdlrSessTable () = 
  { sessions=[];
    terminals=[]; 
    transitions=[];
    duals=[]; 
  }  

let beginSess (q0: hdlrState) 
             (hstb: hdlrSessTable) =
    { hstb with sessions=q0::hstb.sessions }

let endSess (qf: hdlrState)
            (hstb: hdlrSessTable) = 
    { hstb with terminals= qf::hstb.terminals; }

let transSess (xn:hdlrState*action*hdlrState) 
              (hstb: hdlrSessTable) = 
    { hstb with transitions= xn::hstb.transitions }

let rec allTransSess (h:string) 
                     (chns:string list)
                     ((i,xn,j):info*action*info)
                     (hstb: hdlrSessTable) = 
begin match chns with
| [] -> hstb
| (d::chns') ->
     let p = makeHdlrState (h,d,i)
  in let q = makeHdlrState (h,d,j)
  in hstb |> transSess (p,xn,q)
          |> allTransSess h chns' (i,xn,j)
end
  
let rec allTransSessBut (c:string) 
                        (h:string) 
                        (chns:string list)
                        ((i,xn,j):info*action*info)
                        (hstb: hdlrSessTable) = 
match chns with
| [] -> hstb
| (d::chns') when c=d -> 
     hstb |> allTransSess h chns' (i,xn,j)
| (d::chns') ->
     let p = makeHdlrState (h,d,i)
  in let q = makeHdlrState (h,d,j)
  in hstb |> transSess (p,xn,q)
          |> allTransSessBut c h chns' (i,xn,j)

let dualityMark ((q1,q2): hdlrState*hdlrState)
                (hstb: hdlrSessTable) =
    { hstb with duals = (q1,q2)::hstb.duals }           

(* pretty printing hdlrSessTable *)

let stateString {handler=h;channel=c;statement={tag=i;line=ln;column=cn}} = 
     h ^ "." ^ c ^ "." ^ (string_of_int i) ^ "@" ^ (string_of_int ln) ^ ":" ^ (string_of_int cn)

let sessString nm sc = nm ^ (string_of_int sc)

let printStates qs =
   let accum s q = s^";"^(stateString q) in
   let outs = "[" ^ List.fold_left accum "" qs ^ "]" in
       print_endline outs

let printTrans sp xns =
   let trans_string (p,xn,q) = 
       (sp p) ^ " := " ^ (transString xn) ^ (sp q) in
   let accum s xn = s^(trans_string xn)^"\n" in
   let outs = List.fold_left accum ">>\n" xns in
       print_endline outs

let dumpTransTable { sessions=qs;
                     terminals=fs; 
                     transitions=xns;
                     duals=_; 
                   } =
     let _ = printStates qs
  in let _ = printStates fs
  in let _ = printTrans stateString xns
  in ()

(* pretty printing bhav *)

let dumpSessSuite sssu = 
  let _ = printTrans (sessString sssu.name) sssu.transitions in ()


(* sess table A:= alpha B *)