%{
open Ast

let infoCounter = ref 0
let genInfo (p:Lexing.position) = 
    begin 
      infoCounter := !infoCounter + 1; 
      {tag=(!infoCounter); line=p.pos_lnum; column=p.pos_cnum - p.pos_bol}
    end    
%}

%token <string> NAME
%token <string> TEXT
%token <int> NUMBER
%token TRUE
%token FALSE
%token LESSEQ
%token EQUALS
%token PLUS
%token MINUS
%token TIMES  
%token AT
%token CHA_CHING
%token ANDALSO  
%token ORELSE  
%token NOT
%token IF
%token THEN
%token ELSE
%token LPAREN
%token RPAREN
%token LBRACE
%token RBRACE
%token LANGLE
%token RANGLE
%token ASSIGN
%token LARROW
%token RARROW
%token LRARROW
%token BAR
%token SEMI
%token COMMA
%token COLON
%token SEND
%token RECEIVE
%token HANDOFF
%token ACCEPT
%token WHEN
%token DO
%token OTHERWISE
%token SELECT
%token HANDLE
%token OF
%token HAN
%token FUN
%token LET
%token OPEN
%token CLOSE
%token AWAIT
%token START
%token NOW
%token STOP
%token UNIT
%token BOOL
%token INT
%token STRING
%token EOF

%nonassoc ELSE

%left ORELSE
%left ANDALSO
%nonassoc NOT
%left LESSEQ EQUALS
%left MINUS PLUS
%left TIMES 

%start <Ast.prgm> prgm

%%

prgm:
    | ds = decls; EOF { Program ds }
    ;

decls:
	| FUN; f = NAME; xts = prms; COLON; t=vtyp; EQUALS; e = expn; p = decls
        { (Function {name=f; params=xts; returns=t; defn=e}) :: p }
    | HAN; cs = bndl; h = NAME; xts=prms; s = blck; p = decls
        { (Handler {bundle=cs; name=h; params=xts; body=s}) :: p }
    | 
        { [] }
	;

blck:
    | LBRACE; s = stmt { s }
    ;

bndl:
    | LANGLE; c = NAME; cs = bndlc; RANGLE { c::cs }
    ;

bndlc:
    | { [] }
    | COMMA; c = NAME; cs = bndlc { c::cs }
    ;

hbndl:
    | LANGLE; c = NAME; hs_cs = hbndlc; RANGLE {
        let (hs,cs) = hs_cs in (hs, c::cs) 
    }
    | LANGLE; CHA_CHING; c = NAME; hs_cs = hbndlc; RANGLE { 
        let (hs,cs) = hs_cs in ((c,"_"^c)::hs, ("_"^c)::cs) 
    }
    ;

hbndlc:
    | { ([],[]) }
    | COMMA; c = NAME; hs_cs = hbndlc {
        let (hs,cs) = hs_cs in (hs, c::cs) 
    }
    | COMMA; CHA_CHING; c = NAME; hs_cs = hbndlc { 
        let (hs,cs) = hs_cs in ((c,"_"^c)::hs, ("_"^c)::cs) 
    }
    ;

prms:
    | LPAREN; RPAREN { [] }
    | LPAREN; x = NAME; COLON; t = vtyp; xts = prmsc; RPAREN { (x,t)::xts } 
    ;

prmsc:
    | { [] }
    | COMMA; x = NAME; COLON; t = vtyp; xts = prmsc; { (x,t)::xts }
    ;
        
vtyp:
    | UNIT { UnitTy }
    | INT { IntTy }
    | BOOL { BoolTy }
    | STRING { StrTy }
    ;

expn:
	| n = NUMBER { Number n } 
    | s = TEXT { Text s }
	| x = NAME { Name x }
	| TRUE { True }
	| FALSE { False }
	| e1 = expn; LESSEQ; e2 = expn { LessEq (e1, e2) }
    | e1 = expn; EQUALS; e2 = expn { Equals (e1, e2) }
	| e1 = expn; PLUS; e2 = expn { Plus (e1, e2) }
    | e1 = expn; MINUS; e2 = expn { Minus (e1, e2) } 
	| e1 = expn; TIMES; e2 = expn { Times (e1, e2) } 
	| e1 = expn; ANDALSO; e2 = expn { AndAlso (e1, e2) }
	| e1 = expn; ORELSE; e2 = expn { OrElse (e1, e2) }
    | NOT; e = expn { Not e }
	| IF; e1 = expn; THEN; e2 = expn; ELSE; e3 = expn { If (e1, e2, e3) }
	| LPAREN; e=expn; RPAREN { e } 
    | f=NAME; es=expns; { Call (f,es) }
	;

expns: 
    | LPAREN RPAREN { [] }
    | LPAREN e = expn; es = expnsc RPAREN { e::es }
    ;

expnsc:
    | { [] }
    | COMMA; e = expn; es = expnsc { e::es }
    ;

stmt:
    | LET; x = NAME; ASSIGN; e = expn; SEMI; s = stmt {
        (* <stmt> ::= let <name x> := <expn e>; <stmt s> *)
        Assign { tag=genInfo($startpos); nme=x; vlu=e; cnt=s }
      }
    | WHEN; e = expn; DO; s1 = blck; OTHERWISE; s2 = blck; RBRACE { 
        (* <stmt> ::= when <expn e> do { <stmt s1> } otherwise { <stmt s2> } *)
        When { tag=genInfo($startpos); cnd=e; tru=s1; fls=s2 }
    }
    | SEND; e = expn; RARROW; c = NAME; SEMI; s = stmt { 
        (* <stmt> ::= send <expn e> -> <name c>; <stmt s> *)
        Send { tag=genInfo($startpos); vlu=e; chn=c; cnt=s } 
      }
    | RECEIVE; x = NAME; COLON; a = vtyp; LARROW; c = NAME; SEMI; s = stmt { 
        (* <stmt> ::= receive <name x> : <vtyp a> <- <name c>; <stmt s> *)
        Receive { tag=genInfo($startpos); nme=x; typ=a; chn=c; cnt=s } 
      }
(*
    | HANDOFF; c1 = NAME; RARROW; c2 = NAME; SEMI; s = stmt { 
        (* <stmt> ::= handoff <name c1> -> <name c>; <stmt s> *)
        Handoff { tag=genInfo($startpos); hff=c1; chn=c2; cnt=s } 
      }
    | HANDOFF; CHA_CHING; c1 = NAME; RARROW; c2 = NAME; SEMI; s = stmt { 
        (* <stmt> ::= handoff $ <name c1> -> <name c>; <stmt s> *)
        Open { tag=genInfo($startpos); ch1=c1; ch2="_"^c1;
               cnt=Handoff { tag=genInfo($startpos); hff="_"^c1; chn=c2; cnt=s } 
        }
      }
 *)
(*
    | ACCEPT; c1 = NAME; LARROW; c2 = NAME; SEMI; s = stmt { 
        (* <stmt> ::= accept <name c1> <- <name c2>; <stmt s> *)
        Accept { tag=genInfo($startpos); acc=c1; chn=c2; cnt=s } 
      }
 *)
    | SELECT; l = NAME; RARROW; c = NAME; SEMI; s = stmt { 
        (* <stmt> ::= select <name l> -> <name c>; <stmt s> *)
        Select { tag=genInfo($startpos); lbl=l; chn=c; cnt=s } 
      } 
    | SELECT; l = NAME; es = expns; RARROW; c = NAME; SEMI; s = stmt { 
        (* <stmt> ::= select <name l> ( ...<expn es>... ) -> <name c>; <stmt s> *)
           let flds e t = Send { tag=genInfo ($startpos); vlu=e; chn=c; cnt=t }
        in let snds = List.fold_right flds es s
        in Select { tag=genInfo($startpos); lbl=l; chn=c; cnt=snds }
      }
    | HANDLE; c = NAME; OF; LBRACE; cs=cases; RBRACE; RBRACE { 
        (* handle c of { ... cs ... } *)
        Handle { tag=genInfo($startpos); chn=c; css=cs } 
      }
    | OPEN; c1 = NAME; LRARROW; c2 = NAME; SEMI; s = stmt { 
        (* open c1 <-> c2; s *)
        Open { tag=genInfo($startpos); ch1=c1; ch2=c2; cnt=s } 
      }
    | START; ns_cs = hbndl; h = NAME; es = expns; SEMI; s = stmt { 
        (* start < ...cs... > h ( ...es... ); s *)
           let (new_channels,handoff_channels) = ns_cs 
        in let fldo (c1,c2) t = Open {tag=genInfo ($startpos); ch1=c1; ch2=c2; cnt=t} 
        in let strt = Start { tag=genInfo($startpos); hfs=handoff_channels; hnd=h; vls=es; cnt=s }
        in List.fold_right fldo new_channels strt
      }
    | NOW; cs = bndl; h = NAME; es = expns; SEMI; RBRACE { 
        (* <stmt> ::= now < ...<bndl cs>... > <name h> ( ...<expns es>... ); *)
        Start { tag=genInfo($startpos); hfs=cs; hnd=h; vls=es; 
                cnt=Stop { tag=genInfo($startpos) }
        }
      }
    | CLOSE ; c = NAME; SEMI; s = stmt { 
        (* close c; s *)
        Close { tag=genInfo($startpos); chn=c; cnt=s } 
      }
    | AWAIT; c = NAME; SEMI; s = stmt { 
        (* await c; s *)
        Await { tag=genInfo($startpos); chn=c; cnt=s } 
      }
    | STOP; SEMI; RBRACE { 
        (* stop; *)
        Stop { tag=genInfo($startpos) }
    }
    ;

cases:
    | { [] }
    | BAR; l=NAME; RARROW; s = blck; cs=cases { (Case {lbl=l;cnt=s})::cs }
    ;