
(* The type of tokens. *)

type token = 
  | WHEN
  | UNIT
  | TRUE
  | TIMES
  | THEN
  | TEXT of (string)
  | STRING
  | STOP
  | START
  | SEND
  | SEMI
  | SELECT
  | RPAREN
  | RECEIVE
  | RBRACE
  | RARROW
  | RANGLE
  | PLUS
  | OTHERWISE
  | ORELSE
  | OPEN
  | OF
  | NUMBER of (int)
  | NOW
  | NOT
  | NAME of (string)
  | MINUS
  | LRARROW
  | LPAREN
  | LET
  | LESSEQ
  | LBRACE
  | LARROW
  | LANGLE
  | INT
  | IF
  | HANDOFF
  | HANDLE
  | HAN
  | FUN
  | FALSE
  | EQUALS
  | EOF
  | ELSE
  | DO
  | COMMA
  | COLON
  | CLOSE
  | CHA_CHING
  | BOOL
  | BAR
  | AWAIT
  | AT
  | ASSIGN
  | ANDALSO
  | ACCEPT

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prgm: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.prgm)

module MenhirInterpreter : sig
  
  (* The incremental API. *)
  
  include MenhirLib.IncrementalEngine.INCREMENTAL_ENGINE
    with type token = token
  
  (* The indexed type of terminal symbols. *)
  
  type _ terminal = 
    | T_error : unit terminal
    | T_WHEN : unit terminal
    | T_UNIT : unit terminal
    | T_TRUE : unit terminal
    | T_TIMES : unit terminal
    | T_THEN : unit terminal
    | T_TEXT : (string) terminal
    | T_STRING : unit terminal
    | T_STOP : unit terminal
    | T_START : unit terminal
    | T_SEND : unit terminal
    | T_SEMI : unit terminal
    | T_SELECT : unit terminal
    | T_RPAREN : unit terminal
    | T_RECEIVE : unit terminal
    | T_RBRACE : unit terminal
    | T_RARROW : unit terminal
    | T_RANGLE : unit terminal
    | T_PLUS : unit terminal
    | T_OTHERWISE : unit terminal
    | T_ORELSE : unit terminal
    | T_OPEN : unit terminal
    | T_OF : unit terminal
    | T_NUMBER : (int) terminal
    | T_NOW : unit terminal
    | T_NOT : unit terminal
    | T_NAME : (string) terminal
    | T_MINUS : unit terminal
    | T_LRARROW : unit terminal
    | T_LPAREN : unit terminal
    | T_LET : unit terminal
    | T_LESSEQ : unit terminal
    | T_LBRACE : unit terminal
    | T_LARROW : unit terminal
    | T_LANGLE : unit terminal
    | T_INT : unit terminal
    | T_IF : unit terminal
    | T_HANDOFF : unit terminal
    | T_HANDLE : unit terminal
    | T_HAN : unit terminal
    | T_FUN : unit terminal
    | T_FALSE : unit terminal
    | T_EQUALS : unit terminal
    | T_EOF : unit terminal
    | T_ELSE : unit terminal
    | T_DO : unit terminal
    | T_COMMA : unit terminal
    | T_COLON : unit terminal
    | T_CLOSE : unit terminal
    | T_CHA_CHING : unit terminal
    | T_BOOL : unit terminal
    | T_BAR : unit terminal
    | T_AWAIT : unit terminal
    | T_AT : unit terminal
    | T_ASSIGN : unit terminal
    | T_ANDALSO : unit terminal
    | T_ACCEPT : unit terminal
  
  (* The indexed type of nonterminal symbols. *)
  
  type _ nonterminal = 
    | N_vtyp : (Ast.vtyp) nonterminal
    | N_stmt : (Ast.stmt) nonterminal
    | N_prmsc : ((string * Ast.vtyp) list) nonterminal
    | N_prms : ((string * Ast.vtyp) list) nonterminal
    | N_prgm : (Ast.prgm) nonterminal
    | N_hbndlc : ((string * string) list * string list) nonterminal
    | N_hbndl : ((string * string) list * string list) nonterminal
    | N_expnsc : (Ast.expn list) nonterminal
    | N_expns : (Ast.expn list) nonterminal
    | N_expn : (Ast.expn) nonterminal
    | N_decls : (Ast.decl list) nonterminal
    | N_cases : (Ast.hcas list) nonterminal
    | N_bndlc : (string list) nonterminal
    | N_bndl : (string list) nonterminal
    | N_blck : (Ast.stmt) nonterminal
  
  (* The inspection API. *)
  
  include MenhirLib.IncrementalEngine.INSPECTION
    with type 'a lr1state := 'a lr1state
    with type production := production
    with type 'a terminal := 'a terminal
    with type 'a nonterminal := 'a nonterminal
    with type 'a env := 'a env
  
end

(* The entry point(s) to the incremental API. *)

module Incremental : sig
  
  val prgm: Lexing.position -> (Ast.prgm) MenhirInterpreter.checkpoint
  
end
