open Ast

type trans =
| NullTrans
| SendTrans of vtyp
| ReceiveTrans of vtyp
| SelectTrans of string
| HandleTrans of string

type term = 
| AwaitState
| CloseState

type state = 
  { handler: string;
    channel: string;
    statement: info;
  }

type nullTransTable = 
  { 
    starts: state list;
    finals: (state * term) list; 
    transitions: (state * trans * state) list;
    dual: (state * state) list; 
  }

type superState = 
  { 
    tag: string;
    set: state list;
  }

type transTable = 
  { 
    start: superState;
    finals: (superState * term) list;
    transitions: (string * trans * string) list;
  }

(*
let rec nullsFrom p qs xns =
  match xns with 
  | [] -> qs
  | ((q1,NullTrans,q2)::xns') when q1=p -> 
                 nullsFrom p (q2::qs) xns'
  | (_::xns') -> nullsFrom p qs xns'
    
let rec gatherFrom toSee seen xntbl = 
match toSee with
| [] -> seen
| (p::ps) when isIn p seen -> gatherFrom ps seen xntbl
| (p::ps) -> let qs = nullsFrom p [] xntbl.transitions
             in gatherFrom (qs @ ps) (p::seen) xntbl

let rec filterTrans xn s xns =
match (xn,xns) with
| (_,[]) -> xn
| (_,(q,_,_)::xns') when (not (isIn q s)) -> filterTrans xn s xns'
| (_,(_,NullTrans,_)::xns') -> filterTrans xn s xns'
| (NullTrans, (_,xn',_)::xns') -> filterTrans xn' s xns'
| (SendTrans a, (_,SendTrans b,_)::xns') when a == b -> filterTrans xn s xns'
| (ReceiveTrqns a, (_,ReceiveTrans b,_)::xns') when a == b -> filterTrans xn s xns'
| (SelectTrans l, (_,SelectTrans m,_)::xns') -> filterTrans xn s xns'
| (HandleTrans l, (_,HandleTrans m,_)::xns') -> filterTrans xn s xns'
| _ -> raise SessionMismatchError


let makeSuperStateFrom s xntbl =
    let s' = gatherFrom s [] xntbl |> sortStates in
    let xn = filterTrans NullTrans s' xntbl.transitions


let recDfaFrom toDo xntbl dfa = 
match toDo with
| [] -> dfa
| (s::ss) -> let s' = gatherFrom s [] xntbl |> sortStates in
             let s2 = sortStates s1 in
             let 
*)
let newNTable () = { starts=[];
                     finals=[]; 
                     transitions=[];
                     dual=[]; 
                   }  

let setOpen ({ starts= qs; finals= fs; 
               transitions= xns;
               dual= dls }: nullTransTable) 
            (q0: state) = 
    { starts= q0::qs; finals= fs;
      transitions= xns;
      dual= dls }

let setClose ({ starts= qs; finals= fs; 
                transitions= xns;
                dual= dls }: nullTransTable) 
             (qf: state) = 
    { starts= qs; finals= (qf,CloseState)::fs;
      transitions= xns;
      dual= dls } 

let setAwait ({ starts= qs; finals= fs; 
                transitions= xns;
                dual= dls }: nullTransTable) 
             (qf: state) =
    { starts= qs; finals= (qf,AwaitState)::fs;
      transitions= xns;
      dual= dls } 

let setTrans ({ starts= qs; finals= fs; 
                transitions= xns;
                dual= dls }: nullTransTable) 
             (q1:state) (xn:trans) (q2:state) = 
    { starts= qs; finals= fs;
      transitions= (q1,xn,q2)::xns;
      dual= dls }

let dualityMark ({ starts= qs; finals= fs; 
                    transitions= xns;
                    dual= dls }: nullTransTable)
                (q1:state) (q2:state) = 
    { starts= qs; finals= fs;
      transitions= xns;
      dual= (q1,q2)::dls }           

(* pretty printing nullTransTable *)

let stateString {handler=h;channel=c;statement={tag=i}} = 
     h ^ "." ^ c ^ "." ^ (string_of_int i)

let printStates qs =
   let accum s q = s^";"^(stateString q) in
   let outs = "[" ^ List.fold_left accum "" qs ^ "]" in
       print_endline outs

let typeString a =
match a with
| IntTy -> "int"
| BoolTy -> "bool"
| UnitTy -> "unit"
| StrTy -> "string"

let transString xn =
match xn with 
| NullTrans -> ""
| SendTrans t -> "!"^(typeString t)^";"
| ReceiveTrans t -> "?"^(typeString t)^";"
| SelectTrans s -> "+!"^s^";"
| HandleTrans s -> "+?"^s^":"

let printTrans xns =
   let trans_string (p,xn,q) = 
       (stateString p) ^ " := " ^ (transString xn) ^ (stateString q) in
   let accum s xn = s^"\n"^(trans_string xn) in
   let outs = List.fold_left accum "" xns in
       print_endline outs

let dumpTransTable { starts=qs;
                     finals=fs; 
                     transitions=xns;
                     dual=_; 
                   } =
     let _ = printStates qs
  in let _ = printStates (List.map (fun (f,_) -> f) fs)
  in let _ = printTrans xns
  in ()