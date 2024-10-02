{
open Parser
}

let newline = '\r' | '\n' | "\r\n"
let string = "\"" ['a'-'z' 'A'-'Z' '0'-'9' ' ']* "\""
let white = [' ' '\t']+
let digit = ['0'-'9']
let int = '~'? digit+
let letter = ['a'-'z' 'A'-'Z']
let idchar = letter | digit | ['_' '\'']
let id = letter idchar*

rule read = 
  parse
  | newline {Lexing.new_line lexbuf; read lexbuf}
  | white { read lexbuf }
  | "true" { TRUE }
  | "false" { FALSE }
  | "<=" { LESSEQ }
  | "=" { EQUALS }
  | "+" { PLUS }
  | "-" { MINUS }
  | "*" { TIMES }
  | "@" { AT }
  | "$" { CHA_CHING }
  | "andalso" { ANDALSO }
  | "orelse" { ORELSE }
  | "not" { NOT }
  | "if" { IF }
  | "then" { THEN }
  | "else" { ELSE }
  | "(" { LPAREN }
  | ")" { RPAREN }
  | "{" { LBRACE }
  | "}" { RBRACE }
  | "<" { LANGLE }
  | ">" { RANGLE }
  | ":=" { ASSIGN }
  | "<-" { LARROW }
  | "->" { RARROW }
  | "<->" { LRARROW }
  | "|" { BAR }
  | ";" { SEMI }
  | "," { COMMA }
  | ":" { COLON }
  | "unit" { UNIT }
  | "int" { INT }
  | "bool" { BOOL }
  | "string" { STRING }
  | "send" { SEND }
  | "receive" { RECEIVE }
  | "handoff" { HANDOFF }
  | "accept" { ACCEPT }
  | "when" { WHEN }
  | "do" { DO }
  | "otherwise" { OTHERWISE }
  | "select" { SELECT }
  | "handle" { HANDLE }
  | "of" { OF }
  | "han" { HAN }
  | "fun" { FUN }
  | "let" { LET }
  | "open" { OPEN }
  | "close" { CLOSE }
  | "await" { AWAIT }
  | "start" { START }
  | "now" { NOW }
  | "stop" { STOP }
  | string { TEXT (Lexing.lexeme lexbuf) }
  | id { NAME (Lexing.lexeme lexbuf) }
  | int { NUMBER (int_of_string (Lexing.lexeme lexbuf)) }
  | eof { EOF }