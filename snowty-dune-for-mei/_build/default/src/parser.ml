
(* This generated code requires the following version of MenhirLib: *)

let () =
  MenhirLib.StaticVersion.require_20240715

module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | WHEN
    | UNIT
    | TRUE
    | TIMES
    | THEN
    | TEXT of (
# 13 "src/parser.mly"
       (string)
# 25 "src/parser.ml"
  )
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
    | NUMBER of (
# 14 "src/parser.mly"
       (int)
# 46 "src/parser.ml"
  )
    | NOW
    | NOT
    | NAME of (
# 12 "src/parser.mly"
       (string)
# 53 "src/parser.ml"
  )
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
  
end

include MenhirBasics

# 1 "src/parser.mly"
  
open Ast

let infoCounter = ref 0
let genInfo (p:Lexing.position) = 
    begin 
      infoCounter := !infoCounter + 1; 
      {tag=(!infoCounter); line=p.pos_lnum; column=p.pos_cnum - p.pos_bol}
    end    

# 101 "src/parser.ml"

module Tables = struct
  
  include MenhirBasics
  
  let token2terminal : token -> int =
    fun _tok ->
      match _tok with
      | ACCEPT ->
          56
      | ANDALSO ->
          55
      | ASSIGN ->
          54
      | AT ->
          53
      | AWAIT ->
          52
      | BAR ->
          51
      | BOOL ->
          50
      | CHA_CHING ->
          49
      | CLOSE ->
          48
      | COLON ->
          47
      | COMMA ->
          46
      | DO ->
          45
      | ELSE ->
          44
      | EOF ->
          43
      | EQUALS ->
          42
      | FALSE ->
          41
      | FUN ->
          40
      | HAN ->
          39
      | HANDLE ->
          38
      | HANDOFF ->
          37
      | IF ->
          36
      | INT ->
          35
      | LANGLE ->
          34
      | LARROW ->
          33
      | LBRACE ->
          32
      | LESSEQ ->
          31
      | LET ->
          30
      | LPAREN ->
          29
      | LRARROW ->
          28
      | MINUS ->
          27
      | NAME _ ->
          26
      | NOT ->
          25
      | NOW ->
          24
      | NUMBER _ ->
          23
      | OF ->
          22
      | OPEN ->
          21
      | ORELSE ->
          20
      | OTHERWISE ->
          19
      | PLUS ->
          18
      | RANGLE ->
          17
      | RARROW ->
          16
      | RBRACE ->
          15
      | RECEIVE ->
          14
      | RPAREN ->
          13
      | SELECT ->
          12
      | SEMI ->
          11
      | SEND ->
          10
      | START ->
          9
      | STOP ->
          8
      | STRING ->
          7
      | TEXT _ ->
          6
      | THEN ->
          5
      | TIMES ->
          4
      | TRUE ->
          3
      | UNIT ->
          2
      | WHEN ->
          1
  
  and error_terminal =
    0
  
  and token2value : token -> Obj.t =
    fun _tok ->
      match _tok with
      | ACCEPT ->
          Obj.repr ()
      | ANDALSO ->
          Obj.repr ()
      | ASSIGN ->
          Obj.repr ()
      | AT ->
          Obj.repr ()
      | AWAIT ->
          Obj.repr ()
      | BAR ->
          Obj.repr ()
      | BOOL ->
          Obj.repr ()
      | CHA_CHING ->
          Obj.repr ()
      | CLOSE ->
          Obj.repr ()
      | COLON ->
          Obj.repr ()
      | COMMA ->
          Obj.repr ()
      | DO ->
          Obj.repr ()
      | ELSE ->
          Obj.repr ()
      | EOF ->
          Obj.repr ()
      | EQUALS ->
          Obj.repr ()
      | FALSE ->
          Obj.repr ()
      | FUN ->
          Obj.repr ()
      | HAN ->
          Obj.repr ()
      | HANDLE ->
          Obj.repr ()
      | HANDOFF ->
          Obj.repr ()
      | IF ->
          Obj.repr ()
      | INT ->
          Obj.repr ()
      | LANGLE ->
          Obj.repr ()
      | LARROW ->
          Obj.repr ()
      | LBRACE ->
          Obj.repr ()
      | LESSEQ ->
          Obj.repr ()
      | LET ->
          Obj.repr ()
      | LPAREN ->
          Obj.repr ()
      | LRARROW ->
          Obj.repr ()
      | MINUS ->
          Obj.repr ()
      | NAME _v ->
          Obj.repr _v
      | NOT ->
          Obj.repr ()
      | NOW ->
          Obj.repr ()
      | NUMBER _v ->
          Obj.repr _v
      | OF ->
          Obj.repr ()
      | OPEN ->
          Obj.repr ()
      | ORELSE ->
          Obj.repr ()
      | OTHERWISE ->
          Obj.repr ()
      | PLUS ->
          Obj.repr ()
      | RANGLE ->
          Obj.repr ()
      | RARROW ->
          Obj.repr ()
      | RBRACE ->
          Obj.repr ()
      | RECEIVE ->
          Obj.repr ()
      | RPAREN ->
          Obj.repr ()
      | SELECT ->
          Obj.repr ()
      | SEMI ->
          Obj.repr ()
      | SEND ->
          Obj.repr ()
      | START ->
          Obj.repr ()
      | STOP ->
          Obj.repr ()
      | STRING ->
          Obj.repr ()
      | TEXT _v ->
          Obj.repr _v
      | THEN ->
          Obj.repr ()
      | TIMES ->
          Obj.repr ()
      | TRUE ->
          Obj.repr ()
      | UNIT ->
          Obj.repr ()
      | WHEN ->
          Obj.repr ()
  
  and default_reduction =
    (8, "\000\000\000\000\000\000\005\000\003\000\000\000%\000\0006978\000\000\000\000\000(\000&\000\000\000\014\012\011\000\000\000\027\000\000\015\000\000\020\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\025\000\000\000\030\000\028\026\000\000\000\000\000\000*\000\0005\000\000\000\000\000\"\000\000#\000\031\000\000\000 \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0002\000\000\000\000\000\000\000\000\000\000\000\000\000\007\000\000/\000\000\000\000\000\00043)0,-\000\000\000\000.+1\002\000\000\000\000\000\000\000\000\b\t\001\000$")
  
  and error =
    (57, "\000\000\000\000\001\144\000\000\000\000\000\016\000\000\000\000\000\b\000\000\000\000\000\b\000\000\000@\000\000\000\002\000\000\000\000\000\002\000\000\000\016\000\000\000\000\000\000\000\000\000\000\128\000\000\000\000\000\000\000\000\000\000\000\000\000\000\016\000\000\000\000\000\000\001\000\000\000\000\000\128\004\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\b\000\132\000\000\000@\000\128\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\128\000\000\000@\000\000\000\002\000\000\000\000\000\000\000\000\000\b\000\132\000\000\000@\000\128\000\b\000\000\000\004\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\016\000\000\004\014\160H  \b\128\144\000\011 B\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\t\000\000\178\004 \000\003\005*\005@o\128B@\128,\129\b\000\000\000\000\000\000\000\000\000\144\000\011 B\000\000H\000\005\144!\000\000\000\000\000\000\000\000\000\012\000(\017\000 \001\t\000\000\178\004 \000\000\000\000\000\000\000\000\002@\000,\129\b\000\000\128\002\129\016\002\128\016\144\000\011 B\000\0000R\160D\006\248\004$\000\002\200\016\128\000\012\020\168\017\001\190\001\t\000\000\178\004 \000\003\005*\004@o\128B@\000,\129\b\000\000\193J\129\016\027\224\016\144\000\011 B\000\0000R\160D\006\248\004$\000\002\200\016\128\000\012\020\168\017\001\190\001\t\000\000\178\004 \000\003\005*\004@o\128A\000\133\002 \004\000 \000\000\000\000\000\000\000@!@\136\001\016\bH\000\005\144!\000\000\016\bP\"\000D\002\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\193J\129\016\027\224\016@\001@\136\001 \b\000\000\000\002\000\000\000\000\000 \000\000\000\000\000\000\000\000\128\000\000\000\000\128\000\000\000\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\016\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\128\000\000\000\000\000@\000\000\128\000\000@\000\000\002\000\000\000\000\016\000\000 \000\000\016\000\000\000\128\000\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\002\000\000\000\016\000\000\000\000\000\000\000\000\000\000\128\000\000\000\000\000\000\000\000\000\000\000\000\000\000\016\000\000\000\000\000\016\000\000\000\128\000\000\b\000\000\000\000\000\000\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\016\000\000\000\000 \000\000\000\000\000@\234\004\130\002\000\136\t\000\000\178\004 \000\002\000*\004@\b\000@\000\000\004\000\000\000\000\001\000\000\000\000\000\002\007P$\016\016\004@\000\000\000\128\000\000\000\000\001\000\b\000\000\000\000\000\000 \000\000\000\000\b\000\000\000\000\000\016:\129 \128\128\"\000\000\000\004\000\000\000\000\000\000\000\000\000\016\001\b\000\000\000\128\001\000\000\000\000\001\000\000\000\000\000\000@\000\000\000\000\016\000\000\000\000\000 u\002A\001\000D\000\000\000\b\000\000\000\000\000\000\001\000\000\000\000\000\000\002\000\000\000\000\000\128\000\000\000\000\001\003\168\018\b\b\002 \000\000\000\000@\000\000\000\000\000 \000\000\000\000\000\000\002\000\000\000\000\004\000\000\000\000\000\000\000 \000\000\000\000\000\000\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\000\000\000\b$\000\002\200\016\128\000\b\016(\017\000 \001 u\002A\001\000D\000\000\000\b\000\000\000\000\000\000@\000\000\000\000\000\000\000\b\000\000\000\000\b\000\000\000\000\128\000\000\000\128\000\000\000\000\001\000\000\000\000\000\000\000\000\000\128\000\000\000\000\128\000\000\000\b\000\000\000\000\000\000\000\000\000 \000\000\000\000\000\000\016\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\128\000\000\000\000 \000\000\000\000\000@\234\004\130\002\000\136\000\000\000\016\000\000\000\000\004\000\000\000\000\000\b\029@\144@@\017\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000 \000\000\000\000\000\000\000\004\000\000\000\000\001\000\000\000\000\000\002\007P$\016\016\004@\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000d\000\000\000\000\004\000\000\000\000\000\000\000@\000\000\000\000\000\000\000\000\b\000\132\000\000\000@\000\128\000\000\000\000\000@\000\018\000\001d\b@\000\004\000\020\b\128\216\000\128\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\128\000\000\000\000\000\000\000\000")
  
  and start =
    1
  
  and action =
    ((16, "\000K\000=\000\027\000\002\000\023\000\002\000\000\000\026\000\000\000<\000:\000\011\000\000\000 \0006\000\000\000\000\000\000\000\000\000\014\000L\000,\0006\000\014\000\000\000t\000\000\000P\002\248\003\012\000\000\000\000\000\000\003\012\000\t\003\012\000\000\003\012\003\012\000\000\000\012\003\012\000\000\003\012\003\020\003\012\000N\003\012\000\164\003\012\000\250\003\012\001P\003\012\001\166\003\012\001\252\003\012\002R\000\012\000\000\003\020\003\012\003\020\000\000\000x\000\000\000\000\002\168\003\020\000P\000n\000P\000x\000\000\000\130\000\130\000\000\000n\000+\000\028\000N\000\028\000\000\000\128\000\028\000\000\000\148\000\000\000\132\000\028\000\158\000\000\000\142\000\t\000\176\002\248\003\012\000\012\000\150\000\184\002\248\000\156\000L\000\158\000\190\002\248\000\162\000z\0006\000\154\000\170\000\202\002\248\000\176\000\174\000\180\000\212\002\248\000=\000\184\000\t\000\216\000\210\000\000\000\194\000\154\003\012\000\012\002\248\000\212\000\222\000\204\000\"\000\218\000\246\000P\000\"\000\000\000\250\000\254\000\000\000\236\001\014\002\248\000\242\001\018\002\248\000\000\000\000\000\000\000\000\000\000\000\000\001\n\000\248\001\024\002\248\000\000\000\000\000\000\000\000\000K\000\254\000:\000\214\0006\000\226\003\012\000\012\000\000\000\000\000\000\000\228\000\000"), (16, "\0001\0001\000\006\002\142\000\n\001B\000%\0001\0002\0001\000\166\000\174\0001\000\014\0001\000\022\0001\002\006\000\r\000\242\000\153\0006\001\142\0001\000\182\000\142\000\190\0001\001f\000>\000\"\000\129\000\021\000\198\000B\0001\0001\000\206\0001\0001\0001\0001\0001\000\166\000E\000\006\002\142\000\018\000\214\000%\000E\0001\000E\000R\001\162\000E\000*\000E\000.\000E\001F\000\222\000F\000:\000V\001J\000E\000\142\002\026\000Z\000E\000j\000r\001\n\001\"\001*\0012\000J\000E\000E\0016\000E\000E\000E\000E\000E\000\166\000U\001R\001>\001V\001b\001j\000U\000E\000U\001r\001z\000U\001\130\000\182\001\146\000U\001\150\001\158\001\166\001\170\001\178\001\182\000\198\001\190\001\194\001\198\000\206\001\206\001\210\001\214\001\218\001\230\001\238\001\242\000U\000U\001\250\000\214\000U\000U\000U\000U\000\166\000I\001\254\002\014\002\018\002\022\002\030\000I\000\222\000I\002\"\0022\000I\0026\000I\002>\000I\002B\002J\002N\002n\002r\002v\000I\002\146\002\154\002\162\000I\002\187\000\000\000\000\000\000\000\000\000\000\000\000\000I\000I\000\000\000I\000I\000I\000I\000I\000\166\000=\000\000\000\000\000\000\000\000\000\000\000=\000I\000=\000\000\000\000\000=\000\000\000\182\000\000\000=\000\000\000\000\000\000\000\000\000\000\000\000\000\198\000\000\000\000\000\000\000=\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000=\000=\000\000\000=\000=\000=\000=\000=\000\166\000A\000\000\000\000\000\000\000\000\000\000\000A\000=\000A\000\000\000\000\000A\000\000\000\182\000\000\000A\000\000\000\000\000\000\000\000\000\000\000\000\000\198\000\000\000\000\000\000\000A\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000A\000A\000\000\000A\000A\000A\000A\000A\000\166\000Q\000\000\000\000\000\000\000\000\000\000\000Q\000A\000Q\000\000\000\000\000Q\000\000\000\182\000\000\000Q\000\000\000\000\000\000\000\000\000\000\000\000\000\198\000\000\000\000\000\000\000\206\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000Q\000Q\000\000\000\214\000Q\000Q\000Q\000Q\000\166\000]\000\000\000\000\000\000\000\000\000\000\000]\000Q\000]\000\000\000\000\000]\000\000\000\182\000\000\000\190\000\000\000\000\000\000\000\000\000\000\000\000\000\198\000\000\000\000\000\000\000\206\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000]\000]\000\000\000\214\000]\000]\000]\000]\000\166\000Y\000\000\000\000\000\000\000\000\000\000\000Y\000\222\000Y\000\000\000\000\000Y\000\000\000\182\000\000\000Y\000\000\000\000\000\000\000\000\000\000\000\000\000\198\000\000\000\000\000\000\000\206\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000Y\000Y\000v\000\214\000Y\000Y\000Y\000Y\000\000\001.\001:\001\134\000\000\001\154\000z\001\174\000Y\000~\000\000\000\166\000\000\000\000\001\202\000\000\000\146\001\222\000\000\000\000\000q\000\000\000\000\001\246\000\000\000\182\000\130\000\190\000\134\000\138\000\000\002\n\000\150\000\000\000\198\000\000\000\000\000\000\000\206\000\154\000\000\002:\000\000\000\000\000\158\002F\000\000\000\000\000\000\000\214\000\000\000\230\001\026\000\250\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\222"))
  
  and lhs =
    (4, "\015\237\220\203\187\170\170\170\170\170\170\170\170\153\136wfeD3\"\"\"\"\"\"!\017\016")
  
  and goto =
    ((8, "\011\027\000\023\000\021\000\000\000\000\000\000\000\000\b\000\000\000\000\b\000\000\014\012\000\000\000\011\018\004\000\000\000\006\n\n\000\012\014\000\000\016\000\018\000\020\000\022\000\024\000\026\000\028\000\030\000 \000\000\000&$*\000\000\000\000\000\000\030\000 \000\000\000\000\0002\0006\0008\000\000:\000\000\000\000<\000\000\0008\000H:\000\000\000L\000@\000\000P\000\000T\000\000\000T\000\000\000\000V@\000L\000\000\000\000\000L\000^\000\000\000L\000\000HP\000\000\000\000\000\000f\000\000h\000\000\000\000\000\000\000\000\000j\000\000\000\000Z\000j\000r\000bb\000\000\000\000\000"), (8, "\173\n\b\007\028\020\174\026\024\025\163\162FED><)+-/13579;B@AHJ^XTW\\`\161c\160\155\154o\153\152y{\129\151\140\138\139\150\149\159\172\166\168\170\171"))
  
  and semantic_action =
    [|
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = s;
          MenhirLib.EngineTypes.startp = _startpos_s_;
          MenhirLib.EngineTypes.endp = _endpos_s_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = _1;
            MenhirLib.EngineTypes.startp = _startpos__1_;
            MenhirLib.EngineTypes.endp = _endpos__1_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let s : (Ast.stmt) = Obj.magic s in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_s_ in
        let _v : (Ast.stmt) = 
# 96 "src/parser.mly"
                       ( s )
# 385 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _4;
          MenhirLib.EngineTypes.startp = _startpos__4_;
          MenhirLib.EngineTypes.endp = _endpos__4_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = cs;
            MenhirLib.EngineTypes.startp = _startpos_cs_;
            MenhirLib.EngineTypes.endp = _endpos_cs_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = c;
              MenhirLib.EngineTypes.startp = _startpos_c_;
              MenhirLib.EngineTypes.endp = _endpos_c_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = _1;
                MenhirLib.EngineTypes.startp = _startpos__1_;
                MenhirLib.EngineTypes.endp = _endpos__1_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let _4 : unit = Obj.magic _4 in
        let cs : (string list) = Obj.magic cs in
        let c : (
# 12 "src/parser.mly"
       (string)
# 426 "src/parser.ml"
        ) = Obj.magic c in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__4_ in
        let _v : (string list) = 
# 100 "src/parser.mly"
                                           ( c::cs )
# 435 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let _menhir_s = _menhir_env.MenhirLib.EngineTypes.current in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _endpos = _startpos in
        let _v : (string list) = 
# 104 "src/parser.mly"
      ( [] )
# 453 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = cs;
          MenhirLib.EngineTypes.startp = _startpos_cs_;
          MenhirLib.EngineTypes.endp = _endpos_cs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = c;
            MenhirLib.EngineTypes.startp = _startpos_c_;
            MenhirLib.EngineTypes.endp = _endpos_c_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = _1;
              MenhirLib.EngineTypes.startp = _startpos__1_;
              MenhirLib.EngineTypes.endp = _endpos__1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let cs : (string list) = Obj.magic cs in
        let c : (
# 12 "src/parser.mly"
       (string)
# 487 "src/parser.ml"
        ) = Obj.magic c in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_cs_ in
        let _v : (string list) = 
# 105 "src/parser.mly"
                                  ( c::cs )
# 496 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let _menhir_s = _menhir_env.MenhirLib.EngineTypes.current in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _endpos = _startpos in
        let _v : (Ast.hcas list) = 
# 254 "src/parser.mly"
      ( [] )
# 514 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = cs;
          MenhirLib.EngineTypes.startp = _startpos_cs_;
          MenhirLib.EngineTypes.endp = _endpos_cs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = s;
            MenhirLib.EngineTypes.startp = _startpos_s_;
            MenhirLib.EngineTypes.endp = _endpos_s_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = _3;
              MenhirLib.EngineTypes.startp = _startpos__3_;
              MenhirLib.EngineTypes.endp = _endpos__3_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = l;
                MenhirLib.EngineTypes.startp = _startpos_l_;
                MenhirLib.EngineTypes.endp = _endpos_l_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _menhir_s;
                  MenhirLib.EngineTypes.semv = _1;
                  MenhirLib.EngineTypes.startp = _startpos__1_;
                  MenhirLib.EngineTypes.endp = _endpos__1_;
                  MenhirLib.EngineTypes.next = _menhir_stack;
                };
              };
            };
          };
        } = _menhir_stack in
        let cs : (Ast.hcas list) = Obj.magic cs in
        let s : (Ast.stmt) = Obj.magic s in
        let _3 : unit = Obj.magic _3 in
        let l : (
# 12 "src/parser.mly"
       (string)
# 562 "src/parser.ml"
        ) = Obj.magic l in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_cs_ in
        let _v : (Ast.hcas list) = 
# 255 "src/parser.mly"
                                              ( (Case {lbl=l;cnt=s})::cs )
# 571 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = p;
          MenhirLib.EngineTypes.startp = _startpos_p_;
          MenhirLib.EngineTypes.endp = _endpos_p_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = e;
            MenhirLib.EngineTypes.startp = _startpos_e_;
            MenhirLib.EngineTypes.endp = _endpos_e_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = _6;
              MenhirLib.EngineTypes.startp = _startpos__6_;
              MenhirLib.EngineTypes.endp = _endpos__6_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = t;
                MenhirLib.EngineTypes.startp = _startpos_t_;
                MenhirLib.EngineTypes.endp = _endpos_t_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _;
                  MenhirLib.EngineTypes.semv = _4;
                  MenhirLib.EngineTypes.startp = _startpos__4_;
                  MenhirLib.EngineTypes.endp = _endpos__4_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _;
                    MenhirLib.EngineTypes.semv = xts;
                    MenhirLib.EngineTypes.startp = _startpos_xts_;
                    MenhirLib.EngineTypes.endp = _endpos_xts_;
                    MenhirLib.EngineTypes.next = {
                      MenhirLib.EngineTypes.state = _;
                      MenhirLib.EngineTypes.semv = f;
                      MenhirLib.EngineTypes.startp = _startpos_f_;
                      MenhirLib.EngineTypes.endp = _endpos_f_;
                      MenhirLib.EngineTypes.next = {
                        MenhirLib.EngineTypes.state = _menhir_s;
                        MenhirLib.EngineTypes.semv = _1;
                        MenhirLib.EngineTypes.startp = _startpos__1_;
                        MenhirLib.EngineTypes.endp = _endpos__1_;
                        MenhirLib.EngineTypes.next = _menhir_stack;
                      };
                    };
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let p : (Ast.decl list) = Obj.magic p in
        let e : (Ast.expn) = Obj.magic e in
        let _6 : unit = Obj.magic _6 in
        let t : (Ast.vtyp) = Obj.magic t in
        let _4 : unit = Obj.magic _4 in
        let xts : ((string * Ast.vtyp) list) = Obj.magic xts in
        let f : (
# 12 "src/parser.mly"
       (string)
# 640 "src/parser.ml"
        ) = Obj.magic f in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_p_ in
        let _v : (Ast.decl list) = 
# 88 "src/parser.mly"
        ( (Function {name=f; params=xts; returns=t; defn=e}) :: p )
# 649 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = p;
          MenhirLib.EngineTypes.startp = _startpos_p_;
          MenhirLib.EngineTypes.endp = _endpos_p_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = s;
            MenhirLib.EngineTypes.startp = _startpos_s_;
            MenhirLib.EngineTypes.endp = _endpos_s_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = xts;
              MenhirLib.EngineTypes.startp = _startpos_xts_;
              MenhirLib.EngineTypes.endp = _endpos_xts_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = h;
                MenhirLib.EngineTypes.startp = _startpos_h_;
                MenhirLib.EngineTypes.endp = _endpos_h_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _;
                  MenhirLib.EngineTypes.semv = cs;
                  MenhirLib.EngineTypes.startp = _startpos_cs_;
                  MenhirLib.EngineTypes.endp = _endpos_cs_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _menhir_s;
                    MenhirLib.EngineTypes.semv = _1;
                    MenhirLib.EngineTypes.startp = _startpos__1_;
                    MenhirLib.EngineTypes.endp = _endpos__1_;
                    MenhirLib.EngineTypes.next = _menhir_stack;
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let p : (Ast.decl list) = Obj.magic p in
        let s : (Ast.stmt) = Obj.magic s in
        let xts : ((string * Ast.vtyp) list) = Obj.magic xts in
        let h : (
# 12 "src/parser.mly"
       (string)
# 703 "src/parser.ml"
        ) = Obj.magic h in
        let cs : (string list) = Obj.magic cs in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_p_ in
        let _v : (Ast.decl list) = 
# 90 "src/parser.mly"
        ( (Handler {bundle=cs; name=h; params=xts; body=s}) :: p )
# 713 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let _menhir_s = _menhir_env.MenhirLib.EngineTypes.current in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _endpos = _startpos in
        let _v : (Ast.decl list) = 
# 92 "src/parser.mly"
        ( [] )
# 731 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = n;
          MenhirLib.EngineTypes.startp = _startpos_n_;
          MenhirLib.EngineTypes.endp = _endpos_n_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let n : (
# 14 "src/parser.mly"
       (int)
# 752 "src/parser.ml"
        ) = Obj.magic n in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_n_ in
        let _endpos = _endpos_n_ in
        let _v : (Ast.expn) = 
# 145 "src/parser.mly"
              ( Number n )
# 760 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = s;
          MenhirLib.EngineTypes.startp = _startpos_s_;
          MenhirLib.EngineTypes.endp = _endpos_s_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let s : (
# 13 "src/parser.mly"
       (string)
# 781 "src/parser.ml"
        ) = Obj.magic s in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_s_ in
        let _endpos = _endpos_s_ in
        let _v : (Ast.expn) = 
# 146 "src/parser.mly"
               ( Text s )
# 789 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = x;
          MenhirLib.EngineTypes.startp = _startpos_x_;
          MenhirLib.EngineTypes.endp = _endpos_x_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let x : (
# 12 "src/parser.mly"
       (string)
# 810 "src/parser.ml"
        ) = Obj.magic x in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_x_ in
        let _v : (Ast.expn) = 
# 147 "src/parser.mly"
            ( Name x )
# 818 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (Ast.expn) = 
# 148 "src/parser.mly"
        ( True )
# 843 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (Ast.expn) = 
# 149 "src/parser.mly"
         ( False )
# 868 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = e2;
          MenhirLib.EngineTypes.startp = _startpos_e2_;
          MenhirLib.EngineTypes.endp = _endpos_e2_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _2;
            MenhirLib.EngineTypes.startp = _startpos__2_;
            MenhirLib.EngineTypes.endp = _endpos__2_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = e1;
              MenhirLib.EngineTypes.startp = _startpos_e1_;
              MenhirLib.EngineTypes.endp = _endpos_e1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let e2 : (Ast.expn) = Obj.magic e2 in
        let _2 : unit = Obj.magic _2 in
        let e1 : (Ast.expn) = Obj.magic e1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_e1_ in
        let _endpos = _endpos_e2_ in
        let _v : (Ast.expn) = 
# 150 "src/parser.mly"
                                ( LessEq (e1, e2) )
# 907 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = e2;
          MenhirLib.EngineTypes.startp = _startpos_e2_;
          MenhirLib.EngineTypes.endp = _endpos_e2_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _2;
            MenhirLib.EngineTypes.startp = _startpos__2_;
            MenhirLib.EngineTypes.endp = _endpos__2_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = e1;
              MenhirLib.EngineTypes.startp = _startpos_e1_;
              MenhirLib.EngineTypes.endp = _endpos_e1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let e2 : (Ast.expn) = Obj.magic e2 in
        let _2 : unit = Obj.magic _2 in
        let e1 : (Ast.expn) = Obj.magic e1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_e1_ in
        let _endpos = _endpos_e2_ in
        let _v : (Ast.expn) = 
# 151 "src/parser.mly"
                                   ( Equals (e1, e2) )
# 946 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = e2;
          MenhirLib.EngineTypes.startp = _startpos_e2_;
          MenhirLib.EngineTypes.endp = _endpos_e2_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _2;
            MenhirLib.EngineTypes.startp = _startpos__2_;
            MenhirLib.EngineTypes.endp = _endpos__2_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = e1;
              MenhirLib.EngineTypes.startp = _startpos_e1_;
              MenhirLib.EngineTypes.endp = _endpos_e1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let e2 : (Ast.expn) = Obj.magic e2 in
        let _2 : unit = Obj.magic _2 in
        let e1 : (Ast.expn) = Obj.magic e1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_e1_ in
        let _endpos = _endpos_e2_ in
        let _v : (Ast.expn) = 
# 152 "src/parser.mly"
                              ( Plus (e1, e2) )
# 985 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = e2;
          MenhirLib.EngineTypes.startp = _startpos_e2_;
          MenhirLib.EngineTypes.endp = _endpos_e2_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _2;
            MenhirLib.EngineTypes.startp = _startpos__2_;
            MenhirLib.EngineTypes.endp = _endpos__2_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = e1;
              MenhirLib.EngineTypes.startp = _startpos_e1_;
              MenhirLib.EngineTypes.endp = _endpos_e1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let e2 : (Ast.expn) = Obj.magic e2 in
        let _2 : unit = Obj.magic _2 in
        let e1 : (Ast.expn) = Obj.magic e1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_e1_ in
        let _endpos = _endpos_e2_ in
        let _v : (Ast.expn) = 
# 153 "src/parser.mly"
                                  ( Minus (e1, e2) )
# 1024 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = e2;
          MenhirLib.EngineTypes.startp = _startpos_e2_;
          MenhirLib.EngineTypes.endp = _endpos_e2_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _2;
            MenhirLib.EngineTypes.startp = _startpos__2_;
            MenhirLib.EngineTypes.endp = _endpos__2_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = e1;
              MenhirLib.EngineTypes.startp = _startpos_e1_;
              MenhirLib.EngineTypes.endp = _endpos_e1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let e2 : (Ast.expn) = Obj.magic e2 in
        let _2 : unit = Obj.magic _2 in
        let e1 : (Ast.expn) = Obj.magic e1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_e1_ in
        let _endpos = _endpos_e2_ in
        let _v : (Ast.expn) = 
# 154 "src/parser.mly"
                               ( Times (e1, e2) )
# 1063 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = e2;
          MenhirLib.EngineTypes.startp = _startpos_e2_;
          MenhirLib.EngineTypes.endp = _endpos_e2_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _2;
            MenhirLib.EngineTypes.startp = _startpos__2_;
            MenhirLib.EngineTypes.endp = _endpos__2_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = e1;
              MenhirLib.EngineTypes.startp = _startpos_e1_;
              MenhirLib.EngineTypes.endp = _endpos_e1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let e2 : (Ast.expn) = Obj.magic e2 in
        let _2 : unit = Obj.magic _2 in
        let e1 : (Ast.expn) = Obj.magic e1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_e1_ in
        let _endpos = _endpos_e2_ in
        let _v : (Ast.expn) = 
# 155 "src/parser.mly"
                                 ( AndAlso (e1, e2) )
# 1102 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = e2;
          MenhirLib.EngineTypes.startp = _startpos_e2_;
          MenhirLib.EngineTypes.endp = _endpos_e2_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _2;
            MenhirLib.EngineTypes.startp = _startpos__2_;
            MenhirLib.EngineTypes.endp = _endpos__2_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = e1;
              MenhirLib.EngineTypes.startp = _startpos_e1_;
              MenhirLib.EngineTypes.endp = _endpos_e1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let e2 : (Ast.expn) = Obj.magic e2 in
        let _2 : unit = Obj.magic _2 in
        let e1 : (Ast.expn) = Obj.magic e1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_e1_ in
        let _endpos = _endpos_e2_ in
        let _v : (Ast.expn) = 
# 156 "src/parser.mly"
                                ( OrElse (e1, e2) )
# 1141 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = e;
          MenhirLib.EngineTypes.startp = _startpos_e_;
          MenhirLib.EngineTypes.endp = _endpos_e_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = _1;
            MenhirLib.EngineTypes.startp = _startpos__1_;
            MenhirLib.EngineTypes.endp = _endpos__1_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let e : (Ast.expn) = Obj.magic e in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_e_ in
        let _v : (Ast.expn) = 
# 157 "src/parser.mly"
                    ( Not e )
# 1173 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = e3;
          MenhirLib.EngineTypes.startp = _startpos_e3_;
          MenhirLib.EngineTypes.endp = _endpos_e3_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _5;
            MenhirLib.EngineTypes.startp = _startpos__5_;
            MenhirLib.EngineTypes.endp = _endpos__5_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = e2;
              MenhirLib.EngineTypes.startp = _startpos_e2_;
              MenhirLib.EngineTypes.endp = _endpos_e2_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = _3;
                MenhirLib.EngineTypes.startp = _startpos__3_;
                MenhirLib.EngineTypes.endp = _endpos__3_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _;
                  MenhirLib.EngineTypes.semv = e1;
                  MenhirLib.EngineTypes.startp = _startpos_e1_;
                  MenhirLib.EngineTypes.endp = _endpos_e1_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _menhir_s;
                    MenhirLib.EngineTypes.semv = _1;
                    MenhirLib.EngineTypes.startp = _startpos__1_;
                    MenhirLib.EngineTypes.endp = _endpos__1_;
                    MenhirLib.EngineTypes.next = _menhir_stack;
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let e3 : (Ast.expn) = Obj.magic e3 in
        let _5 : unit = Obj.magic _5 in
        let e2 : (Ast.expn) = Obj.magic e2 in
        let _3 : unit = Obj.magic _3 in
        let e1 : (Ast.expn) = Obj.magic e1 in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_e3_ in
        let _v : (Ast.expn) = 
# 158 "src/parser.mly"
                                                   ( If (e1, e2, e3) )
# 1233 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _3;
          MenhirLib.EngineTypes.startp = _startpos__3_;
          MenhirLib.EngineTypes.endp = _endpos__3_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = e;
            MenhirLib.EngineTypes.startp = _startpos_e_;
            MenhirLib.EngineTypes.endp = _endpos_e_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = _1;
              MenhirLib.EngineTypes.startp = _startpos__1_;
              MenhirLib.EngineTypes.endp = _endpos__1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let _3 : unit = Obj.magic _3 in
        let e : (Ast.expn) = Obj.magic e in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__3_ in
        let _v : (Ast.expn) = 
# 159 "src/parser.mly"
                          ( e )
# 1272 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = es;
          MenhirLib.EngineTypes.startp = _startpos_es_;
          MenhirLib.EngineTypes.endp = _endpos_es_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = f;
            MenhirLib.EngineTypes.startp = _startpos_f_;
            MenhirLib.EngineTypes.endp = _endpos_f_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let es : (Ast.expn list) = Obj.magic es in
        let f : (
# 12 "src/parser.mly"
       (string)
# 1300 "src/parser.ml"
        ) = Obj.magic f in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_f_ in
        let _endpos = _endpos_es_ in
        let _v : (Ast.expn) = 
# 160 "src/parser.mly"
                        ( Call (f,es) )
# 1308 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _2;
          MenhirLib.EngineTypes.startp = _startpos__2_;
          MenhirLib.EngineTypes.endp = _endpos__2_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = _1;
            MenhirLib.EngineTypes.startp = _startpos__1_;
            MenhirLib.EngineTypes.endp = _endpos__1_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__2_ in
        let _v : (Ast.expn list) = 
# 164 "src/parser.mly"
                    ( [] )
# 1340 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _4;
          MenhirLib.EngineTypes.startp = _startpos__4_;
          MenhirLib.EngineTypes.endp = _endpos__4_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = es;
            MenhirLib.EngineTypes.startp = _startpos_es_;
            MenhirLib.EngineTypes.endp = _endpos_es_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = e;
              MenhirLib.EngineTypes.startp = _startpos_e_;
              MenhirLib.EngineTypes.endp = _endpos_e_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = _1;
                MenhirLib.EngineTypes.startp = _startpos__1_;
                MenhirLib.EngineTypes.endp = _endpos__1_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let _4 : unit = Obj.magic _4 in
        let es : (Ast.expn list) = Obj.magic es in
        let e : (Ast.expn) = Obj.magic e in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__4_ in
        let _v : (Ast.expn list) = 
# 165 "src/parser.mly"
                                          ( e::es )
# 1386 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let _menhir_s = _menhir_env.MenhirLib.EngineTypes.current in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _endpos = _startpos in
        let _v : (Ast.expn list) = 
# 169 "src/parser.mly"
      ( [] )
# 1404 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = es;
          MenhirLib.EngineTypes.startp = _startpos_es_;
          MenhirLib.EngineTypes.endp = _endpos_es_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = e;
            MenhirLib.EngineTypes.startp = _startpos_e_;
            MenhirLib.EngineTypes.endp = _endpos_e_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = _1;
              MenhirLib.EngineTypes.startp = _startpos__1_;
              MenhirLib.EngineTypes.endp = _endpos__1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let es : (Ast.expn list) = Obj.magic es in
        let e : (Ast.expn) = Obj.magic e in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_es_ in
        let _v : (Ast.expn list) = 
# 170 "src/parser.mly"
                                   ( e::es )
# 1443 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _4;
          MenhirLib.EngineTypes.startp = _startpos__4_;
          MenhirLib.EngineTypes.endp = _endpos__4_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = hs_cs;
            MenhirLib.EngineTypes.startp = _startpos_hs_cs_;
            MenhirLib.EngineTypes.endp = _endpos_hs_cs_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = c;
              MenhirLib.EngineTypes.startp = _startpos_c_;
              MenhirLib.EngineTypes.endp = _endpos_c_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = _1;
                MenhirLib.EngineTypes.startp = _startpos__1_;
                MenhirLib.EngineTypes.endp = _endpos__1_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let _4 : unit = Obj.magic _4 in
        let hs_cs : ((string * string) list * string list) = Obj.magic hs_cs in
        let c : (
# 12 "src/parser.mly"
       (string)
# 1484 "src/parser.ml"
        ) = Obj.magic c in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__4_ in
        let _v : ((string * string) list * string list) = 
# 109 "src/parser.mly"
                                               (
        let (hs,cs) = hs_cs in (hs, c::cs) 
    )
# 1495 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _5;
          MenhirLib.EngineTypes.startp = _startpos__5_;
          MenhirLib.EngineTypes.endp = _endpos__5_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = hs_cs;
            MenhirLib.EngineTypes.startp = _startpos_hs_cs_;
            MenhirLib.EngineTypes.endp = _endpos_hs_cs_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = c;
              MenhirLib.EngineTypes.startp = _startpos_c_;
              MenhirLib.EngineTypes.endp = _endpos_c_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = _2;
                MenhirLib.EngineTypes.startp = _startpos__2_;
                MenhirLib.EngineTypes.endp = _endpos__2_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _menhir_s;
                  MenhirLib.EngineTypes.semv = _1;
                  MenhirLib.EngineTypes.startp = _startpos__1_;
                  MenhirLib.EngineTypes.endp = _endpos__1_;
                  MenhirLib.EngineTypes.next = _menhir_stack;
                };
              };
            };
          };
        } = _menhir_stack in
        let _5 : unit = Obj.magic _5 in
        let hs_cs : ((string * string) list * string list) = Obj.magic hs_cs in
        let c : (
# 12 "src/parser.mly"
       (string)
# 1542 "src/parser.ml"
        ) = Obj.magic c in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__5_ in
        let _v : ((string * string) list * string list) = 
# 112 "src/parser.mly"
                                                          ( 
        let (hs,cs) = hs_cs in ((c,"_"^c)::hs, ("_"^c)::cs) 
    )
# 1554 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let _menhir_s = _menhir_env.MenhirLib.EngineTypes.current in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _endpos = _startpos in
        let _v : ((string * string) list * string list) = 
# 118 "src/parser.mly"
      ( ([],[]) )
# 1572 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = hs_cs;
          MenhirLib.EngineTypes.startp = _startpos_hs_cs_;
          MenhirLib.EngineTypes.endp = _endpos_hs_cs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = c;
            MenhirLib.EngineTypes.startp = _startpos_c_;
            MenhirLib.EngineTypes.endp = _endpos_c_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = _1;
              MenhirLib.EngineTypes.startp = _startpos__1_;
              MenhirLib.EngineTypes.endp = _endpos__1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let hs_cs : ((string * string) list * string list) = Obj.magic hs_cs in
        let c : (
# 12 "src/parser.mly"
       (string)
# 1606 "src/parser.ml"
        ) = Obj.magic c in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_hs_cs_ in
        let _v : ((string * string) list * string list) = 
# 119 "src/parser.mly"
                                      (
        let (hs,cs) = hs_cs in (hs, c::cs) 
    )
# 1617 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = hs_cs;
          MenhirLib.EngineTypes.startp = _startpos_hs_cs_;
          MenhirLib.EngineTypes.endp = _endpos_hs_cs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = c;
            MenhirLib.EngineTypes.startp = _startpos_c_;
            MenhirLib.EngineTypes.endp = _endpos_c_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = _2;
              MenhirLib.EngineTypes.startp = _startpos__2_;
              MenhirLib.EngineTypes.endp = _endpos__2_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = _1;
                MenhirLib.EngineTypes.startp = _startpos__1_;
                MenhirLib.EngineTypes.endp = _endpos__1_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let hs_cs : ((string * string) list * string list) = Obj.magic hs_cs in
        let c : (
# 12 "src/parser.mly"
       (string)
# 1657 "src/parser.ml"
        ) = Obj.magic c in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_hs_cs_ in
        let _v : ((string * string) list * string list) = 
# 122 "src/parser.mly"
                                                 ( 
        let (hs,cs) = hs_cs in ((c,"_"^c)::hs, ("_"^c)::cs) 
    )
# 1669 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _2;
          MenhirLib.EngineTypes.startp = _startpos__2_;
          MenhirLib.EngineTypes.endp = _endpos__2_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = ds;
            MenhirLib.EngineTypes.startp = _startpos_ds_;
            MenhirLib.EngineTypes.endp = _endpos_ds_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let _2 : unit = Obj.magic _2 in
        let ds : (Ast.decl list) = Obj.magic ds in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_ds_ in
        let _endpos = _endpos__2_ in
        let _v : (Ast.prgm) = 
# 83 "src/parser.mly"
                      ( Program ds )
# 1701 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _2;
          MenhirLib.EngineTypes.startp = _startpos__2_;
          MenhirLib.EngineTypes.endp = _endpos__2_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = _1;
            MenhirLib.EngineTypes.startp = _startpos__1_;
            MenhirLib.EngineTypes.endp = _endpos__1_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__2_ in
        let _v : ((string * Ast.vtyp) list) = 
# 128 "src/parser.mly"
                     ( [] )
# 1733 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _6;
          MenhirLib.EngineTypes.startp = _startpos__6_;
          MenhirLib.EngineTypes.endp = _endpos__6_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = xts;
            MenhirLib.EngineTypes.startp = _startpos_xts_;
            MenhirLib.EngineTypes.endp = _endpos_xts_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = t;
              MenhirLib.EngineTypes.startp = _startpos_t_;
              MenhirLib.EngineTypes.endp = _endpos_t_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = _3;
                MenhirLib.EngineTypes.startp = _startpos__3_;
                MenhirLib.EngineTypes.endp = _endpos__3_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _;
                  MenhirLib.EngineTypes.semv = x;
                  MenhirLib.EngineTypes.startp = _startpos_x_;
                  MenhirLib.EngineTypes.endp = _endpos_x_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _menhir_s;
                    MenhirLib.EngineTypes.semv = _1;
                    MenhirLib.EngineTypes.startp = _startpos__1_;
                    MenhirLib.EngineTypes.endp = _endpos__1_;
                    MenhirLib.EngineTypes.next = _menhir_stack;
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let _6 : unit = Obj.magic _6 in
        let xts : ((string * Ast.vtyp) list) = Obj.magic xts in
        let t : (Ast.vtyp) = Obj.magic t in
        let _3 : unit = Obj.magic _3 in
        let x : (
# 12 "src/parser.mly"
       (string)
# 1788 "src/parser.ml"
        ) = Obj.magic x in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__6_ in
        let _v : ((string * Ast.vtyp) list) = 
# 129 "src/parser.mly"
                                                             ( (x,t)::xts )
# 1797 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let _menhir_s = _menhir_env.MenhirLib.EngineTypes.current in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _endpos = _startpos in
        let _v : ((string * Ast.vtyp) list) = 
# 133 "src/parser.mly"
      ( [] )
# 1815 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = xts;
          MenhirLib.EngineTypes.startp = _startpos_xts_;
          MenhirLib.EngineTypes.endp = _endpos_xts_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = t;
            MenhirLib.EngineTypes.startp = _startpos_t_;
            MenhirLib.EngineTypes.endp = _endpos_t_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = _3;
              MenhirLib.EngineTypes.startp = _startpos__3_;
              MenhirLib.EngineTypes.endp = _endpos__3_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = x;
                MenhirLib.EngineTypes.startp = _startpos_x_;
                MenhirLib.EngineTypes.endp = _endpos_x_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _menhir_s;
                  MenhirLib.EngineTypes.semv = _1;
                  MenhirLib.EngineTypes.startp = _startpos__1_;
                  MenhirLib.EngineTypes.endp = _endpos__1_;
                  MenhirLib.EngineTypes.next = _menhir_stack;
                };
              };
            };
          };
        } = _menhir_stack in
        let xts : ((string * Ast.vtyp) list) = Obj.magic xts in
        let t : (Ast.vtyp) = Obj.magic t in
        let _3 : unit = Obj.magic _3 in
        let x : (
# 12 "src/parser.mly"
       (string)
# 1863 "src/parser.ml"
        ) = Obj.magic x in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_xts_ in
        let _v : ((string * Ast.vtyp) list) = 
# 134 "src/parser.mly"
                                                     ( (x,t)::xts )
# 1872 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = s;
          MenhirLib.EngineTypes.startp = _startpos_s_;
          MenhirLib.EngineTypes.endp = _endpos_s_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _5;
            MenhirLib.EngineTypes.startp = _startpos__5_;
            MenhirLib.EngineTypes.endp = _endpos__5_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = e;
              MenhirLib.EngineTypes.startp = _startpos_e_;
              MenhirLib.EngineTypes.endp = _endpos_e_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = _3;
                MenhirLib.EngineTypes.startp = _startpos__3_;
                MenhirLib.EngineTypes.endp = _endpos__3_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _;
                  MenhirLib.EngineTypes.semv = x;
                  MenhirLib.EngineTypes.startp = _startpos_x_;
                  MenhirLib.EngineTypes.endp = _endpos_x_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _menhir_s;
                    MenhirLib.EngineTypes.semv = _1;
                    MenhirLib.EngineTypes.startp = _startpos__1_;
                    MenhirLib.EngineTypes.endp = _endpos__1_;
                    MenhirLib.EngineTypes.next = _menhir_stack;
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let s : (Ast.stmt) = Obj.magic s in
        let _5 : unit = Obj.magic _5 in
        let e : (Ast.expn) = Obj.magic e in
        let _3 : unit = Obj.magic _3 in
        let x : (
# 12 "src/parser.mly"
       (string)
# 1927 "src/parser.ml"
        ) = Obj.magic x in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_s_ in
        let _v =
          let _startpos = _startpos__1_ in
          (
# 174 "src/parser.mly"
                                                      (
        (* <stmt> ::= let <name x> := <expn e>; <stmt s> *)
        Assign { tag=genInfo(_startpos); nme=x; vlu=e; cnt=s }
      )
# 1941 "src/parser.ml"
           : (Ast.stmt))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _7;
          MenhirLib.EngineTypes.startp = _startpos__7_;
          MenhirLib.EngineTypes.endp = _endpos__7_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = s2;
            MenhirLib.EngineTypes.startp = _startpos_s2_;
            MenhirLib.EngineTypes.endp = _endpos_s2_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = _5;
              MenhirLib.EngineTypes.startp = _startpos__5_;
              MenhirLib.EngineTypes.endp = _endpos__5_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = s1;
                MenhirLib.EngineTypes.startp = _startpos_s1_;
                MenhirLib.EngineTypes.endp = _endpos_s1_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _;
                  MenhirLib.EngineTypes.semv = _3;
                  MenhirLib.EngineTypes.startp = _startpos__3_;
                  MenhirLib.EngineTypes.endp = _endpos__3_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _;
                    MenhirLib.EngineTypes.semv = e;
                    MenhirLib.EngineTypes.startp = _startpos_e_;
                    MenhirLib.EngineTypes.endp = _endpos_e_;
                    MenhirLib.EngineTypes.next = {
                      MenhirLib.EngineTypes.state = _menhir_s;
                      MenhirLib.EngineTypes.semv = _1;
                      MenhirLib.EngineTypes.startp = _startpos__1_;
                      MenhirLib.EngineTypes.endp = _endpos__1_;
                      MenhirLib.EngineTypes.next = _menhir_stack;
                    };
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let _7 : unit = Obj.magic _7 in
        let s2 : (Ast.stmt) = Obj.magic s2 in
        let _5 : unit = Obj.magic _5 in
        let s1 : (Ast.stmt) = Obj.magic s1 in
        let _3 : unit = Obj.magic _3 in
        let e : (Ast.expn) = Obj.magic e in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__7_ in
        let _v =
          let _startpos = _startpos__1_ in
          (
# 178 "src/parser.mly"
                                                                  ( 
        (* <stmt> ::= when <expn e> do { <stmt s1> } otherwise { <stmt s2> } *)
        When { tag=genInfo(_startpos); cnd=e; tru=s1; fls=s2 }
    )
# 2014 "src/parser.ml"
           : (Ast.stmt))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = s;
          MenhirLib.EngineTypes.startp = _startpos_s_;
          MenhirLib.EngineTypes.endp = _endpos_s_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _5;
            MenhirLib.EngineTypes.startp = _startpos__5_;
            MenhirLib.EngineTypes.endp = _endpos__5_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = c;
              MenhirLib.EngineTypes.startp = _startpos_c_;
              MenhirLib.EngineTypes.endp = _endpos_c_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = _3;
                MenhirLib.EngineTypes.startp = _startpos__3_;
                MenhirLib.EngineTypes.endp = _endpos__3_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _;
                  MenhirLib.EngineTypes.semv = e;
                  MenhirLib.EngineTypes.startp = _startpos_e_;
                  MenhirLib.EngineTypes.endp = _endpos_e_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _menhir_s;
                    MenhirLib.EngineTypes.semv = _1;
                    MenhirLib.EngineTypes.startp = _startpos__1_;
                    MenhirLib.EngineTypes.endp = _endpos__1_;
                    MenhirLib.EngineTypes.next = _menhir_stack;
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let s : (Ast.stmt) = Obj.magic s in
        let _5 : unit = Obj.magic _5 in
        let c : (
# 12 "src/parser.mly"
       (string)
# 2068 "src/parser.ml"
        ) = Obj.magic c in
        let _3 : unit = Obj.magic _3 in
        let e : (Ast.expn) = Obj.magic e in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_s_ in
        let _v =
          let _startpos = _startpos__1_ in
          (
# 182 "src/parser.mly"
                                                       ( 
        (* <stmt> ::= send <expn e> -> <name c>; <stmt s> *)
        Send { tag=genInfo(_startpos); vlu=e; chn=c; cnt=s } 
      )
# 2084 "src/parser.ml"
           : (Ast.stmt))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = s;
          MenhirLib.EngineTypes.startp = _startpos_s_;
          MenhirLib.EngineTypes.endp = _endpos_s_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _7;
            MenhirLib.EngineTypes.startp = _startpos__7_;
            MenhirLib.EngineTypes.endp = _endpos__7_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = c;
              MenhirLib.EngineTypes.startp = _startpos_c_;
              MenhirLib.EngineTypes.endp = _endpos_c_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = _5;
                MenhirLib.EngineTypes.startp = _startpos__5_;
                MenhirLib.EngineTypes.endp = _endpos__5_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _;
                  MenhirLib.EngineTypes.semv = a;
                  MenhirLib.EngineTypes.startp = _startpos_a_;
                  MenhirLib.EngineTypes.endp = _endpos_a_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _;
                    MenhirLib.EngineTypes.semv = _3;
                    MenhirLib.EngineTypes.startp = _startpos__3_;
                    MenhirLib.EngineTypes.endp = _endpos__3_;
                    MenhirLib.EngineTypes.next = {
                      MenhirLib.EngineTypes.state = _;
                      MenhirLib.EngineTypes.semv = x;
                      MenhirLib.EngineTypes.startp = _startpos_x_;
                      MenhirLib.EngineTypes.endp = _endpos_x_;
                      MenhirLib.EngineTypes.next = {
                        MenhirLib.EngineTypes.state = _menhir_s;
                        MenhirLib.EngineTypes.semv = _1;
                        MenhirLib.EngineTypes.startp = _startpos__1_;
                        MenhirLib.EngineTypes.endp = _endpos__1_;
                        MenhirLib.EngineTypes.next = _menhir_stack;
                      };
                    };
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let s : (Ast.stmt) = Obj.magic s in
        let _7 : unit = Obj.magic _7 in
        let c : (
# 12 "src/parser.mly"
       (string)
# 2150 "src/parser.ml"
        ) = Obj.magic c in
        let _5 : unit = Obj.magic _5 in
        let a : (Ast.vtyp) = Obj.magic a in
        let _3 : unit = Obj.magic _3 in
        let x : (
# 12 "src/parser.mly"
       (string)
# 2158 "src/parser.ml"
        ) = Obj.magic x in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_s_ in
        let _v =
          let _startpos = _startpos__1_ in
          (
# 186 "src/parser.mly"
                                                                           ( 
        (* <stmt> ::= receive <name x> : <vtyp a> <- <name c>; <stmt s> *)
        Receive { tag=genInfo(_startpos); nme=x; typ=a; chn=c; cnt=s } 
      )
# 2172 "src/parser.ml"
           : (Ast.stmt))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = s;
          MenhirLib.EngineTypes.startp = _startpos_s_;
          MenhirLib.EngineTypes.endp = _endpos_s_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _5;
            MenhirLib.EngineTypes.startp = _startpos__5_;
            MenhirLib.EngineTypes.endp = _endpos__5_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = c;
              MenhirLib.EngineTypes.startp = _startpos_c_;
              MenhirLib.EngineTypes.endp = _endpos_c_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = _3;
                MenhirLib.EngineTypes.startp = _startpos__3_;
                MenhirLib.EngineTypes.endp = _endpos__3_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _;
                  MenhirLib.EngineTypes.semv = l;
                  MenhirLib.EngineTypes.startp = _startpos_l_;
                  MenhirLib.EngineTypes.endp = _endpos_l_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _menhir_s;
                    MenhirLib.EngineTypes.semv = _1;
                    MenhirLib.EngineTypes.startp = _startpos__1_;
                    MenhirLib.EngineTypes.endp = _endpos__1_;
                    MenhirLib.EngineTypes.next = _menhir_stack;
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let s : (Ast.stmt) = Obj.magic s in
        let _5 : unit = Obj.magic _5 in
        let c : (
# 12 "src/parser.mly"
       (string)
# 2226 "src/parser.ml"
        ) = Obj.magic c in
        let _3 : unit = Obj.magic _3 in
        let l : (
# 12 "src/parser.mly"
       (string)
# 2232 "src/parser.ml"
        ) = Obj.magic l in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_s_ in
        let _v =
          let _startpos = _startpos__1_ in
          (
# 208 "src/parser.mly"
                                                         ( 
        (* <stmt> ::= select <name l> -> <name c>; <stmt s> *)
        Select { tag=genInfo(_startpos); lbl=l; chn=c; cnt=s } 
      )
# 2246 "src/parser.ml"
           : (Ast.stmt))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = s;
          MenhirLib.EngineTypes.startp = _startpos_s_;
          MenhirLib.EngineTypes.endp = _endpos_s_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _6;
            MenhirLib.EngineTypes.startp = _startpos__6_;
            MenhirLib.EngineTypes.endp = _endpos__6_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = c;
              MenhirLib.EngineTypes.startp = _startpos_c_;
              MenhirLib.EngineTypes.endp = _endpos_c_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = _4;
                MenhirLib.EngineTypes.startp = _startpos__4_;
                MenhirLib.EngineTypes.endp = _endpos__4_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _;
                  MenhirLib.EngineTypes.semv = es;
                  MenhirLib.EngineTypes.startp = _startpos_es_;
                  MenhirLib.EngineTypes.endp = _endpos_es_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _;
                    MenhirLib.EngineTypes.semv = l;
                    MenhirLib.EngineTypes.startp = _startpos_l_;
                    MenhirLib.EngineTypes.endp = _endpos_l_;
                    MenhirLib.EngineTypes.next = {
                      MenhirLib.EngineTypes.state = _menhir_s;
                      MenhirLib.EngineTypes.semv = _1;
                      MenhirLib.EngineTypes.startp = _startpos__1_;
                      MenhirLib.EngineTypes.endp = _endpos__1_;
                      MenhirLib.EngineTypes.next = _menhir_stack;
                    };
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let s : (Ast.stmt) = Obj.magic s in
        let _6 : unit = Obj.magic _6 in
        let c : (
# 12 "src/parser.mly"
       (string)
# 2306 "src/parser.ml"
        ) = Obj.magic c in
        let _4 : unit = Obj.magic _4 in
        let es : (Ast.expn list) = Obj.magic es in
        let l : (
# 12 "src/parser.mly"
       (string)
# 2313 "src/parser.ml"
        ) = Obj.magic l in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_s_ in
        let _v =
          let _startpos = _startpos__1_ in
          (
# 212 "src/parser.mly"
                                                                     ( 
        (* <stmt> ::= select <name l> ( ...<expn es>... ) -> <name c>; <stmt s> *)
           let flds e t = Send { tag=genInfo (_startpos); vlu=e; chn=c; cnt=t }
        in let snds = List.fold_right flds es s
        in Select { tag=genInfo(_startpos); lbl=l; chn=c; cnt=snds }
      )
# 2329 "src/parser.ml"
           : (Ast.stmt))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _7;
          MenhirLib.EngineTypes.startp = _startpos__7_;
          MenhirLib.EngineTypes.endp = _endpos__7_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _6;
            MenhirLib.EngineTypes.startp = _startpos__6_;
            MenhirLib.EngineTypes.endp = _endpos__6_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = cs;
              MenhirLib.EngineTypes.startp = _startpos_cs_;
              MenhirLib.EngineTypes.endp = _endpos_cs_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = _4;
                MenhirLib.EngineTypes.startp = _startpos__4_;
                MenhirLib.EngineTypes.endp = _endpos__4_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _;
                  MenhirLib.EngineTypes.semv = _3;
                  MenhirLib.EngineTypes.startp = _startpos__3_;
                  MenhirLib.EngineTypes.endp = _endpos__3_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _;
                    MenhirLib.EngineTypes.semv = c;
                    MenhirLib.EngineTypes.startp = _startpos_c_;
                    MenhirLib.EngineTypes.endp = _endpos_c_;
                    MenhirLib.EngineTypes.next = {
                      MenhirLib.EngineTypes.state = _menhir_s;
                      MenhirLib.EngineTypes.semv = _1;
                      MenhirLib.EngineTypes.startp = _startpos__1_;
                      MenhirLib.EngineTypes.endp = _endpos__1_;
                      MenhirLib.EngineTypes.next = _menhir_stack;
                    };
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let _7 : unit = Obj.magic _7 in
        let _6 : unit = Obj.magic _6 in
        let cs : (Ast.hcas list) = Obj.magic cs in
        let _4 : unit = Obj.magic _4 in
        let _3 : unit = Obj.magic _3 in
        let c : (
# 12 "src/parser.mly"
       (string)
# 2392 "src/parser.ml"
        ) = Obj.magic c in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__7_ in
        let _v =
          let _startpos = _startpos__1_ in
          (
# 218 "src/parser.mly"
                                                             ( 
        (* handle c of { ... cs ... } *)
        Handle { tag=genInfo(_startpos); chn=c; css=cs } 
      )
# 2406 "src/parser.ml"
           : (Ast.stmt))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = s;
          MenhirLib.EngineTypes.startp = _startpos_s_;
          MenhirLib.EngineTypes.endp = _endpos_s_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _5;
            MenhirLib.EngineTypes.startp = _startpos__5_;
            MenhirLib.EngineTypes.endp = _endpos__5_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = c2;
              MenhirLib.EngineTypes.startp = _startpos_c2_;
              MenhirLib.EngineTypes.endp = _endpos_c2_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = _3;
                MenhirLib.EngineTypes.startp = _startpos__3_;
                MenhirLib.EngineTypes.endp = _endpos__3_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _;
                  MenhirLib.EngineTypes.semv = c1;
                  MenhirLib.EngineTypes.startp = _startpos_c1_;
                  MenhirLib.EngineTypes.endp = _endpos_c1_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _menhir_s;
                    MenhirLib.EngineTypes.semv = _1;
                    MenhirLib.EngineTypes.startp = _startpos__1_;
                    MenhirLib.EngineTypes.endp = _endpos__1_;
                    MenhirLib.EngineTypes.next = _menhir_stack;
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let s : (Ast.stmt) = Obj.magic s in
        let _5 : unit = Obj.magic _5 in
        let c2 : (
# 12 "src/parser.mly"
       (string)
# 2460 "src/parser.ml"
        ) = Obj.magic c2 in
        let _3 : unit = Obj.magic _3 in
        let c1 : (
# 12 "src/parser.mly"
       (string)
# 2466 "src/parser.ml"
        ) = Obj.magic c1 in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_s_ in
        let _v =
          let _startpos = _startpos__1_ in
          (
# 222 "src/parser.mly"
                                                          ( 
        (* open c1 <-> c2; s *)
        Open { tag=genInfo(_startpos); ch1=c1; ch2=c2; cnt=s } 
      )
# 2480 "src/parser.ml"
           : (Ast.stmt))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = s;
          MenhirLib.EngineTypes.startp = _startpos_s_;
          MenhirLib.EngineTypes.endp = _endpos_s_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _5;
            MenhirLib.EngineTypes.startp = _startpos__5_;
            MenhirLib.EngineTypes.endp = _endpos__5_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = es;
              MenhirLib.EngineTypes.startp = _startpos_es_;
              MenhirLib.EngineTypes.endp = _endpos_es_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = h;
                MenhirLib.EngineTypes.startp = _startpos_h_;
                MenhirLib.EngineTypes.endp = _endpos_h_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _;
                  MenhirLib.EngineTypes.semv = ns_cs;
                  MenhirLib.EngineTypes.startp = _startpos_ns_cs_;
                  MenhirLib.EngineTypes.endp = _endpos_ns_cs_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _menhir_s;
                    MenhirLib.EngineTypes.semv = _1;
                    MenhirLib.EngineTypes.startp = _startpos__1_;
                    MenhirLib.EngineTypes.endp = _endpos__1_;
                    MenhirLib.EngineTypes.next = _menhir_stack;
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let s : (Ast.stmt) = Obj.magic s in
        let _5 : unit = Obj.magic _5 in
        let es : (Ast.expn list) = Obj.magic es in
        let h : (
# 12 "src/parser.mly"
       (string)
# 2535 "src/parser.ml"
        ) = Obj.magic h in
        let ns_cs : ((string * string) list * string list) = Obj.magic ns_cs in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_s_ in
        let _v =
          let _startpos = _startpos__1_ in
          (
# 226 "src/parser.mly"
                                                                 ( 
        (* start < ...cs... > h ( ...es... ); s *)
           let (new_channels,handoff_channels) = ns_cs 
        in let fldo (c1,c2) t = Open {tag=genInfo (_startpos); ch1=c1; ch2=c2; cnt=t} 
        in let strt = Start { tag=genInfo(_startpos); hfs=handoff_channels; hnd=h; vls=es; cnt=s }
        in List.fold_right fldo new_channels strt
      )
# 2553 "src/parser.ml"
           : (Ast.stmt))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _6;
          MenhirLib.EngineTypes.startp = _startpos__6_;
          MenhirLib.EngineTypes.endp = _endpos__6_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _5;
            MenhirLib.EngineTypes.startp = _startpos__5_;
            MenhirLib.EngineTypes.endp = _endpos__5_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = es;
              MenhirLib.EngineTypes.startp = _startpos_es_;
              MenhirLib.EngineTypes.endp = _endpos_es_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _;
                MenhirLib.EngineTypes.semv = h;
                MenhirLib.EngineTypes.startp = _startpos_h_;
                MenhirLib.EngineTypes.endp = _endpos_h_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _;
                  MenhirLib.EngineTypes.semv = cs;
                  MenhirLib.EngineTypes.startp = _startpos_cs_;
                  MenhirLib.EngineTypes.endp = _endpos_cs_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _menhir_s;
                    MenhirLib.EngineTypes.semv = _1;
                    MenhirLib.EngineTypes.startp = _startpos__1_;
                    MenhirLib.EngineTypes.endp = _endpos__1_;
                    MenhirLib.EngineTypes.next = _menhir_stack;
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let _6 : unit = Obj.magic _6 in
        let _5 : unit = Obj.magic _5 in
        let es : (Ast.expn list) = Obj.magic es in
        let h : (
# 12 "src/parser.mly"
       (string)
# 2608 "src/parser.ml"
        ) = Obj.magic h in
        let cs : (string list) = Obj.magic cs in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__6_ in
        let _v =
          let _startpos = _startpos__1_ in
          (
# 233 "src/parser.mly"
                                                         ( 
        (* <stmt> ::= now < ...<bndl cs>... > <name h> ( ...<expns es>... ); *)
        Start { tag=genInfo(_startpos); hfs=cs; hnd=h; vls=es; 
                cnt=Stop { tag=genInfo(_startpos) }
        }
      )
# 2625 "src/parser.ml"
           : (Ast.stmt))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = s;
          MenhirLib.EngineTypes.startp = _startpos_s_;
          MenhirLib.EngineTypes.endp = _endpos_s_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _3;
            MenhirLib.EngineTypes.startp = _startpos__3_;
            MenhirLib.EngineTypes.endp = _endpos__3_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = c;
              MenhirLib.EngineTypes.startp = _startpos_c_;
              MenhirLib.EngineTypes.endp = _endpos_c_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = _1;
                MenhirLib.EngineTypes.startp = _startpos__1_;
                MenhirLib.EngineTypes.endp = _endpos__1_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let s : (Ast.stmt) = Obj.magic s in
        let _3 : unit = Obj.magic _3 in
        let c : (
# 12 "src/parser.mly"
       (string)
# 2667 "src/parser.ml"
        ) = Obj.magic c in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_s_ in
        let _v =
          let _startpos = _startpos__1_ in
          (
# 239 "src/parser.mly"
                                       ( 
        (* close c; s *)
        Close { tag=genInfo(_startpos); chn=c; cnt=s } 
      )
# 2681 "src/parser.ml"
           : (Ast.stmt))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = s;
          MenhirLib.EngineTypes.startp = _startpos_s_;
          MenhirLib.EngineTypes.endp = _endpos_s_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _3;
            MenhirLib.EngineTypes.startp = _startpos__3_;
            MenhirLib.EngineTypes.endp = _endpos__3_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = c;
              MenhirLib.EngineTypes.startp = _startpos_c_;
              MenhirLib.EngineTypes.endp = _endpos_c_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = _1;
                MenhirLib.EngineTypes.startp = _startpos__1_;
                MenhirLib.EngineTypes.endp = _endpos__1_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let s : (Ast.stmt) = Obj.magic s in
        let _3 : unit = Obj.magic _3 in
        let c : (
# 12 "src/parser.mly"
       (string)
# 2723 "src/parser.ml"
        ) = Obj.magic c in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_s_ in
        let _v =
          let _startpos = _startpos__1_ in
          (
# 243 "src/parser.mly"
                                      ( 
        (* await c; s *)
        Await { tag=genInfo(_startpos); chn=c; cnt=s } 
      )
# 2737 "src/parser.ml"
           : (Ast.stmt))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _3;
          MenhirLib.EngineTypes.startp = _startpos__3_;
          MenhirLib.EngineTypes.endp = _endpos__3_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _2;
            MenhirLib.EngineTypes.startp = _startpos__2_;
            MenhirLib.EngineTypes.endp = _endpos__2_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = _1;
              MenhirLib.EngineTypes.startp = _startpos__1_;
              MenhirLib.EngineTypes.endp = _endpos__1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let _3 : unit = Obj.magic _3 in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__3_ in
        let _v =
          let _startpos = _startpos__1_ in
          (
# 247 "src/parser.mly"
                         ( 
        (* stop; *)
        Stop { tag=genInfo(_startpos) }
    )
# 2782 "src/parser.ml"
           : (Ast.stmt))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (Ast.vtyp) = 
# 138 "src/parser.mly"
           ( UnitTy )
# 2808 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (Ast.vtyp) = 
# 139 "src/parser.mly"
          ( IntTy )
# 2833 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (Ast.vtyp) = 
# 140 "src/parser.mly"
           ( BoolTy )
# 2858 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : (Ast.vtyp) = 
# 141 "src/parser.mly"
             ( StrTy )
# 2883 "src/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
    |]
  
  and trace =
    None
  
end

module MenhirInterpreter = struct
  
  module ET = MenhirLib.TableInterpreter.MakeEngineTable (Tables)
  
  module TI = MenhirLib.Engine.Make (ET)
  
  include TI
  
  module Symbols = struct
    
    type _ terminal = 
      | T_error : unit terminal
      | T_WHEN : unit terminal
      | T_UNIT : unit terminal
      | T_TRUE : unit terminal
      | T_TIMES : unit terminal
      | T_THEN : unit terminal
      | T_TEXT : (
# 13 "src/parser.mly"
       (string)
# 2919 "src/parser.ml"
    ) terminal
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
      | T_NUMBER : (
# 14 "src/parser.mly"
       (int)
# 2940 "src/parser.ml"
    ) terminal
      | T_NOW : unit terminal
      | T_NOT : unit terminal
      | T_NAME : (
# 12 "src/parser.mly"
       (string)
# 2947 "src/parser.ml"
    ) terminal
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
    
  end
  
  include Symbols
  
  include MenhirLib.InspectionTableInterpreter.Make (Tables) (struct
    
    include TI
    
    include Symbols
    
    include MenhirLib.InspectionTableInterpreter.Symbols (Symbols)
    
    let terminal =
      fun t ->
        match t with
        | 0 ->
            X (T T_error)
        | 1 ->
            X (T T_WHEN)
        | 2 ->
            X (T T_UNIT)
        | 3 ->
            X (T T_TRUE)
        | 4 ->
            X (T T_TIMES)
        | 5 ->
            X (T T_THEN)
        | 6 ->
            X (T T_TEXT)
        | 7 ->
            X (T T_STRING)
        | 8 ->
            X (T T_STOP)
        | 9 ->
            X (T T_START)
        | 10 ->
            X (T T_SEND)
        | 11 ->
            X (T T_SEMI)
        | 12 ->
            X (T T_SELECT)
        | 13 ->
            X (T T_RPAREN)
        | 14 ->
            X (T T_RECEIVE)
        | 15 ->
            X (T T_RBRACE)
        | 16 ->
            X (T T_RARROW)
        | 17 ->
            X (T T_RANGLE)
        | 18 ->
            X (T T_PLUS)
        | 19 ->
            X (T T_OTHERWISE)
        | 20 ->
            X (T T_ORELSE)
        | 21 ->
            X (T T_OPEN)
        | 22 ->
            X (T T_OF)
        | 23 ->
            X (T T_NUMBER)
        | 24 ->
            X (T T_NOW)
        | 25 ->
            X (T T_NOT)
        | 26 ->
            X (T T_NAME)
        | 27 ->
            X (T T_MINUS)
        | 28 ->
            X (T T_LRARROW)
        | 29 ->
            X (T T_LPAREN)
        | 30 ->
            X (T T_LET)
        | 31 ->
            X (T T_LESSEQ)
        | 32 ->
            X (T T_LBRACE)
        | 33 ->
            X (T T_LARROW)
        | 34 ->
            X (T T_LANGLE)
        | 35 ->
            X (T T_INT)
        | 36 ->
            X (T T_IF)
        | 37 ->
            X (T T_HANDOFF)
        | 38 ->
            X (T T_HANDLE)
        | 39 ->
            X (T T_HAN)
        | 40 ->
            X (T T_FUN)
        | 41 ->
            X (T T_FALSE)
        | 42 ->
            X (T T_EQUALS)
        | 43 ->
            X (T T_EOF)
        | 44 ->
            X (T T_ELSE)
        | 45 ->
            X (T T_DO)
        | 46 ->
            X (T T_COMMA)
        | 47 ->
            X (T T_COLON)
        | 48 ->
            X (T T_CLOSE)
        | 49 ->
            X (T T_CHA_CHING)
        | 50 ->
            X (T T_BOOL)
        | 51 ->
            X (T T_BAR)
        | 52 ->
            X (T T_AWAIT)
        | 53 ->
            X (T T_AT)
        | 54 ->
            X (T T_ASSIGN)
        | 55 ->
            X (T T_ANDALSO)
        | 56 ->
            X (T T_ACCEPT)
        | _ ->
            assert false
    
    and nonterminal =
      fun nt ->
        match nt with
        | 15 ->
            X (N N_blck)
        | 14 ->
            X (N N_bndl)
        | 13 ->
            X (N N_bndlc)
        | 12 ->
            X (N N_cases)
        | 11 ->
            X (N N_decls)
        | 10 ->
            X (N N_expn)
        | 9 ->
            X (N N_expns)
        | 8 ->
            X (N N_expnsc)
        | 7 ->
            X (N N_hbndl)
        | 6 ->
            X (N N_hbndlc)
        | 5 ->
            X (N N_prgm)
        | 4 ->
            X (N N_prms)
        | 3 ->
            X (N N_prmsc)
        | 2 ->
            X (N N_stmt)
        | 1 ->
            X (N N_vtyp)
        | _ ->
            assert false
    
    and lr0_incoming =
      (8, "\000PF6^6\027\027$\0296<\0286`\006\016Hf\003^6`\003\007\007\028\tB\004\b\014046<\028<JT\021\n\021&\021*\0218\021@\021V\021p\021\012\021Z\021\021\028\021^\021\017\017\028\019\021\021\\\031(\031 \018\024 \020F6^6\rd6\r\r$d6\r$\0156\019\024\022\021\"6\024\0266\"6\024\0306`\003D6\024,6:6\0242\0296\019\024 >6n\021\024N6.Bh6\"\031\025\025  b6\024j6\024\005\005\005\005\005\005\019\"6\024\005\005\005\005\031R6\t`\003V\021\023\023\011\023X")
    
    and rhs =
      ((8, "\011B\005F6\027$^6\027h6\"\031\025R6\t`\003V\021\023P\0296\t\031\0230\0146\bT\021@\021\021V\021\021&\021\0218\021\021\n\021\021p\021\021*\0214\021J\021\012\021Z\021<\021\0286\019<\028<\021\017\028^\021\017F6\r$Fd6\r$^6\r^d6\r\023X<\028<6`\003\007\028^6`\003\007>6n\021\024\005\004\021\\\031(\031 \022\021\"6\024\005\0306`\003D6\024\005\0266\"6\024\005\0266\019\"6\024\005N6.B\025  ,6:6\024\005\020\0156\019\024\0052\0296\019\024 b6\024\005j6\024\005\018\024 \006Hf\016"), (8, "\000\001\003\007\007\n\n\015\023\029\029\030\031 !\"%(+.1479?BDFJJMQVVY]_agglry\127\135\141\148\155\161\167\173\177\181\184\185\186\187\188"))
    
    and lr0_core =
      (8, "\000\001\002\003\004\005\006\007\b\t\n\011\012\r\014\015\016\017\018\019\020\021\022\023\024\025\026\027\028\029\030\031 !\"#$%&'()*78+,-./01234569:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\127\128\129\130\131\132\133\134\135\136\137\138\139\140\141\142\143\144\145\146\147\148\149\150\151\152\153\154\155\156\157\158\159\160\161\162\163\164\165\166\167\168\169\170\171\172\173\174")
    
    and lr0_items =
      ((16, "\000\000 \001\b\001\b\002\016\001\016\002\016\003\b\003\b\004 \002 \003\148\001\144\001\144\002\148\002\148\003\212\001\224\001\216\001\220\001\148\004\156\001\156\002\156\003\156\004\156\005\148\005\148\006 \004\004\001\164\0014\001,\001(\001X\001d\0010\001l\001h\001h\002`\001\\\0018\001\\\002T\001P\001L\001H\001D\001@\001<\001L\002T\001P\001L\003L\001H\001D\001@\001<\001D\002T\001P\001L\001H\001D\003D\001@\001<\001T\002T\003T\001P\001L\001H\001D\001@\001<\001H\002T\001P\001L\001H\003H\001D\001@\001<\001<\002T\001P\001L\001H\001D\001@\001<\003<\001@\002T\001P\001L\001H\001D\001@\003@\001<\001P\002T\001P\003P\001L\001H\001D\001@\001<\001\\\003\\\004T\001P\001L\001H\001D\001@\001<\001\\\005\\\006T\001P\001L\001H\001D\001@\001<\001`\002T\001P\001L\001H\001D\001@\001<\001`\003l\002T\001P\001L\001H\001D\001@\001<\001t\001t\002T\001P\001L\001H\001D\001@\001<\001t\003l\003l\004d\002X\002T\001P\001L\001H\001D\001@\001<\001\164\002T\001P\001L\001H\001D\001@\001<\001\164\003\164\004\164\005\164\006\164\007\208\001\208\002\208\003\192\001|\001x\001x\002\136\001\132\001\132\002\132\003\136\002\136\003\136\004x\003x\004|\002|\003|\004|\005\192\002\192\003\192\004\192\005\168\001\168\002T\001P\001L\001H\001D\001@\001<\001\168\003\168\004\168\005\180\001\176\001\180\002\176\002\176\003\176\004\176\005\172\001\172\002\172\003\172\004\172\005\172\006\172\007\188\001\188\002\188\003\188\004\188\005\196\001\196\002\196\003\196\004\196\005\196\006\160\001\160\002\160\003\160\004T\001P\001L\001H\001D\001@\001<\001\160\005\184\001\184\002\184\003\184\004\024\001\024\002\024\003\024\004\024\005\184\005\184\006\184\007\200\001\200\002\200\003\204\001\204\002\204\003\204\004\200\004\160\006\188\006\172\b\176\006\180\003\180\004\180\005\180\006\180\007\168\006\192\006\004\002 \005\028\001\028\002\028\003\028\004\028\005\028\006T\001P\001L\001H\001D\001@\001<\001\028\007\028\b \006\000\001\140\001\140\002"), (16, "\000\000\000\001\000\002\000\003\000\004\000\005\000\006\000\007\000\b\000\t\000\n\000\011\000\r\000\014\000\015\000\016\000\017\000\018\000\019\000\020\000\021\000\022\000\023\000\024\000\025\000\026\000\027\000\028\000\029\000\030\000\031\000 \000!\000\"\000#\000%\000'\000(\000)\000*\000+\0003\0004\000<\000=\000E\000F\000N\000O\000W\000X\000`\000a\000i\000j\000r\000s\000{\000|\000\132\000\140\000\141\000\149\000\150\000\158\000\159\000\160\000\161\000\162\000\170\000\178\000\179\000\180\000\181\000\182\000\183\000\184\000\185\000\186\000\187\000\189\000\190\000\192\000\193\000\194\000\195\000\196\000\197\000\198\000\199\000\200\000\201\000\202\000\203\000\204\000\205\000\206\000\207\000\208\000\216\000\217\000\218\000\219\000\221\000\223\000\224\000\225\000\226\000\227\000\228\000\229\000\230\000\231\000\232\000\233\000\234\000\235\000\236\000\237\000\238\000\239\000\240\000\241\000\242\000\243\000\244\000\245\000\246\000\247\000\255\001\000\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\b\001\t\001\n\001\011\001\012\001\r\001\014\001\015\001\016\001\017\001\018\001\019\001\020\001\021\001\022\001\023\001\024\001\025\001\026\001\027\001\028\001\029\001\030\001\031\001 \001!\001\"\001#\001$\001%\001&\001'\001/\0010\0011\0012\0013\0014"))
    
    and nullable =
      "\018\156"
    
    and first =
      (57, "\000\000\000\000\001\144\000\016\128\000\000\b\000\016\016:\129 \128\128\"\000\000\000\000\000\000@\000\000\000\000@\000\000\000\000\000\000\000\012\128\000\000\000\000\000\000\b\000\000\000\000\000@\000\000\000\000\000\000\000\002\000\000\000\000\002\000\000\000\004\128\000Y\002\016\000\000\000\000\000\0000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\016\000\000\000\000\000\128\000\000\000\000\000\001\000\000\000")
    
  end) (ET) (TI)
  
end

let prgm =
  fun lexer lexbuf : (Ast.prgm) ->
    Obj.magic (MenhirInterpreter.entry `Legacy 0 lexer lexbuf)

module Incremental = struct
  
  let prgm =
    fun initial_position : (Ast.prgm) MenhirInterpreter.checkpoint ->
      Obj.magic (MenhirInterpreter.start 0 initial_position)
  
end
