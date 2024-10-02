let parse (s : string) : Ast.prgm =
  let lexbuf = Lexing.from_string s in
  let prg = Parser.prgm Lexer.read lexbuf in
  prg

let rec readFile (f:Stdlib.in_channel) = 
   try 
        let line = Stdlib.input_line f
     in let lines = readFile f
     in line ^ lines
   with 
   | Stdlib.End_of_file -> ""
   
let readFileNamed (fname: string) : string = 
     let f = Stdlib.open_in fname
  in let s = readFile f
  in let _ = Stdlib.close_in f
  in s

let parseFile (fname: string) : Ast.prgm =
   parse (readFileNamed fname)

(* 

let filename = Sys.argv.(0)

let filename = Sys.argv.(0)
let _ = print_endline filename
let pgm = parse "han <cout,cin> main args { stop; }"
let xtbl = Checker.check pgm 

*)