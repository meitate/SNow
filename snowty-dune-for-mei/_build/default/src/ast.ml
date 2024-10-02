type vtyp =
  | IntTy
  | BoolTy
  | StrTy
  | UnitTy

type styp =
  | Continues of string
  | Sends of vtyp * styp
  | Receives of vtyp * styp
  | Selects of (string * styp) list
  | Handles of (string * styp) list
  | Stops

type info = { tag : int; line : int; column : int } 

type expn =
  | Name of string
  | Number of int
  | Text of string
  | True
  | False
  | LessEq of expn * expn
  | Equals of expn * expn
  | Plus of expn * expn
  | Minus of expn * expn
  | Times of expn * expn
  | AndAlso of expn * expn
  | OrElse of expn * expn
  | Not of expn
  | If of expn * expn * expn
  | Call of string * (expn list)

type stmt = 
  | Assign of {tag:info; nme:string; vlu:expn; cnt:stmt}
  | When of {tag:info; cnd:expn; tru:stmt; fls:stmt}
  | Send of {tag:info; vlu:expn; chn:string; cnt:stmt}
  | Receive of {tag:info; nme:string; typ:vtyp; chn:string; cnt:stmt}
  | Select of {tag:info; lbl:string; chn:string; cnt:stmt}
  | Handle of {tag:info; chn:string; css:(hcas list)}
  | Open of {tag:info; ch1:string; ch2:string; cnt:stmt}
  | Start of {tag:info; hfs:(string list); hnd:string; vls:(expn list); cnt:stmt}
  | Close of {tag:info; chn:string; cnt:stmt}
  | Await of {tag:info; chn:string; cnt:stmt}
  | Stop of {tag:info}
(*
*** Handoff will be how we send a channel over a channel.
  | Handoff of {tag:info; hff:string; chn:string; cnt:stmt}

*** Accept will be how we receive a channel over a channel.
  | Accept of {tag:info; acc:string; chn:string; cnt:stmt}

*** Now is deprectated and replaced with Open(s) and Start 
  | Now of {tag:info; hfs:(string list); hnd:string; vls:(expn list)}
*)

and hcas = Case of { lbl:string; cnt:stmt }

type hndc = { bundle: string list; 
              name: string; 
              params: (string * vtyp) list; 
              body: stmt }

type fndc = { name: string; 
              params: (string * vtyp) list;
              returns: vtyp;
              defn: expn }

type decl = 
  | Handler of hndc
  | Function of fndc

type prgm = 
     | Program of decl list
