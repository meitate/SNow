module MI = Parser.MenhirInterpreter

exception SyntaxError of ((int * int) option * string)

let get_lexing_position lexbuf =
  let p = Lexing.lexeme_start_p lexbuf in
  let line_number = p.Lexing.pos_lnum in
  let column = p.Lexing.pos_cnum - p.Lexing.pos_bol + 1 in
  (line_number, column)

let rec parseWithErrors lexbuf (checkpoint : Ast.prgm MI.checkpoint) =
begin match checkpoint with
  | MI.InputNeeded _env ->
         let token = Lexer.read lexbuf
      in let startp = lexbuf.Lexing.lex_start_p
      in let endp = lexbuf.Lexing.lex_curr_p
      in let checkpoint = MI.offer checkpoint (token, startp, endp)
      in parseWithErrors lexbuf checkpoint
  | MI.Shifting _
  | MI.AboutToReduce _ ->
      let checkpoint = MI.resume checkpoint in
      parseWithErrors lexbuf checkpoint
  | MI.HandlingError _env ->
      let line, pos = get_lexing_position lexbuf in
      raise (SyntaxError (Some (line, pos), "Syntax error."))
  | MI.Accepted v -> v
  | MI.Rejected ->
       raise (SyntaxError (None, "Invalid syntax."))
end

(*
let parseNoError (s : string) : Ast.prgm =
  let lexbuf = Lexing.from_string s in
(* let prg = Parser.prgm Lexer.read lexbuf in *)
  try (Parser.prgm Lexer.read lexbuf) with
  (* catch exception and turn into Error *)
  | SyntaxError (_,error_string) ->
            let position = lexbuf.lex_curr_p
         in let line = position.pos_lnum
         in let column = position.pos_cnum - position.pos_bol + 1
         in raise (SyntaxError (Some (line,column), error_string))
      (* raise (SyntaxError msg) *)
  | Parser.Error ->
         let position = lexbuf.lex_curr_p
      in let line = position.pos_lnum
      in let column = position.pos_cnum - position.pos_bol + 1
      in raise (SyntaxError (Some (line,column), "Syntax berror."))
*)

let parseNoError (s : string) : Ast.prgm =
     let lexbuf = Lexing.from_string s
  in let prg = parseWithErrors lexbuf (Parser.Incremental.prgm lexbuf.lex_curr_p)
  in prg

let rec readFile (f:Stdlib.in_channel) = 
   try 
        let line = Stdlib.input_line f
     in let lines = readFile f
     in line ^ "\n" ^ lines
   with 
   | Stdlib.End_of_file -> ""
   
let readFileNamed (fname: string) : string = 
     let f = Stdlib.open_in fname
  in let s = readFile f
  in let _ = Stdlib.close_in f
  in s

let parseFile (fname: string) : Ast.prgm =
   try parseNoError (readFileNamed fname) with
   | SyntaxError (None,msg) -> 
         let fs = fname ^ ": "
      in let _ = print_endline (fs ^ msg)
      in raise (SyntaxError (None,msg))
   | SyntaxError (Some (l,c),msg) -> 
         let ls = string_of_int l
      in let cs = string_of_int c
      in let fs = fname ^ "." ^ ls ^ "." ^ cs ^ ": "
      in let _ = print_endline (fs ^ msg )
      in (raise (SyntaxError (Some (l,c),msg)))

   
let filename = Sys.argv.(1)
let _ = print_endline ("Processing '"^filename^"'...")
let pgm = parseFile filename
let ssu = Checker.check pgm
let _ = print_endline ((string_of_int (List.length ssu)) ^ " sessions found.")
let _ = print_endline ("Done. Dumping session types...")
let _ = List.map Xntb.dumpSessSuite ssu
let _ = print_endline ("Done.")


(* ssu (a list of transition tables) 

*)