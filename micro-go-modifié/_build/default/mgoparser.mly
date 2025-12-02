/* Analyse syntaxique Micro Go (Menhir) */

%{
open Mgoast
%}

/* ----- TOKENS ----- */

/* mots-clés */
%token PACKAGE IMPORT TYPE STRUCT FUNC VAR IF ELSE FOR RETURN
%token TRUE FALSE NIL

/* ponctuation / séparateurs */
%token LPAR RPAR      /* ( ) */
%token BEGIN END      /* { } */
%token SEMI COMMA DOT /* ; , . */

/* opérateurs */
%token PLUS MINUS STAR SLASH PERCENT      /* + - * / % */
%token NOT                                /* ! */
%token EQEQ NOTEQ LT LE GT GE             /* == != < <= > >= */
%token AND OR                             /* && || */
%token ASSIGN                     /* = */
%token PLUSPLUS MINUSMINUS                /* ++ -- */
/* ampersand token removed (unused) */

/* constantes et identifiants */
%token <Int64.t> INT
%token <string> IDENT
%token <string list> IDS_DECL
%token <string> STRING

%token EOF

/* ----- PRIORITÉS (de la plus faible à la plus forte) ----- */

%left OR
%left AND
%nonassoc EQEQ NOTEQ LT LE GT GE
%left PLUS MINUS
%left STAR SLASH PERCENT
%right UMINUS NOT

/* ----- TYPE DE L'AXIOME ----- */

%start prog
%type <Mgoast.program> prog

%%

/* ========================================================= */
/*   Conversion token IDENT (string) -> ident (record AST)   */
/* ========================================================= */

ident:
  x=IDENT { { loc = ($startpos, $endpos); id = x } }
;

/* ========================================================= */
/*                      FICHIER GLOBAL                      */
/* ========================================================= */

prog:
  | PACKAGE _main=IDENT SEMI ds=decls EOF
      { (false, List.rev ds) }
  | PACKAGE _main=IDENT SEMI IMPORT _s=STRING SEMI ds=decls EOF
      { (true, List.rev ds) }
;

/* ========================================================= */
/*                  DÉCLARATIONS TOP-LEVEL                   */
/* ========================================================= */

decls:
  | /* vide */           { [] }
  | d=decl ds=decls      { d :: ds }
;

decl:
  | structure             { Struct $1 }
  | fonction              { Fun $1 }
;

/* --------------------------------------------------------- */
/*                      STRUCTURES                           */
/* --------------------------------------------------------- */
/*  structure ::= type ident struct { (vars ;)* vars ? } ;   */

structure:
  | TYPE id=ident STRUCT BEGIN fs=opt_field_decls END SEMI
      {
        {
          sname  = id;
          fields = fs;
        }
      }
;

/* liste possiblement vide de déclarations de champs */
opt_field_decls:
  | /* vide */      { [] }
  | l=field_decls   { l }
;

/* (vars ;)* vars?   codé comme :  fd ';' fd ';' ... fd [';']  */
field_decls:
  | fd=field_decl SEMI               { fd }
  | fd=field_decl                    { fd }
  | fd=field_decl SEMI fds=field_decls
      { fd @ fds }
;

/* vars ::= ident+ type */
field_decl:
  | ids=ident_list ty=typ
      { List.map (fun id -> (id, ty)) ids }
;

/* ident+ séparés par des virgules */
ident_list:
  | i=ident                      { [i] }
  | il=ident_list COMMA i=ident  { il @ [i] }
;

/* --------------------------------------------------------- */
/*                        TYPES                              */
/* --------------------------------------------------------- */
/*  type ::= int | bool | string | * ident                   */

typ:
  | s=IDENT
      {
        match s with
        | "int"    -> TInt
        | "bool"   -> TBool
        | "string" -> TString
        | _        -> failwith "unknown base type"
      }
  | STAR s=IDENT
      { TStruct s }
;

/* ========================================================= */
/*                       FONCTIONS                           */
/* ========================================================= */
/* fonction ::= func ident ( (vars ,)* vars? ) type_retour? bloc ; */

fonction:
  | FUNC f=ident LPAR params=opt_params RPAR ret=opt_type_ret body=bloc SEMI
      {
        {
          fname  = f;
          params = params;        (* (ident * typ) list *)
          return = ret;           (* typ list *)
          body   = body;          (* seq = instr list *)
        }
      }
;

/* (vars ,)* vars?  -> liste de (ident * typ)  */
opt_params:
  | /* vide */              { [] }
  | ps=param_list           { ps }
;

param_list:
  | v=vars_decl                      { v }
  | v=vars_decl COMMA rest=param_list { v @ rest }
;

/* vars ::= ident+ type */
vars_decl:
  | ids=ident_list ty=typ
      { List.map (fun id -> (id, ty)) ids }
;

/* type_retour ::= vide | type | ( type+ , ,? )   -> typ list */

opt_type_ret:
  | /* vide */             { [] }
  | t=typ                  { [t] }
  | LPAR ts=ret_type_list RPAR { ts }
;

ret_type_list:
  | t=typ                        { [t] }
  | t=typ COMMA rest=ret_type_list { t :: rest }
  | t=typ COMMA                  { [t] }    /* virgule finale optionnelle */
;

/* ========================================================= */
/*                          BLOCS                            */
/* ========================================================= */
/* bloc ::= { (instr ;)* instr? }   (bloc possiblement vide) */

bloc:
  | BEGIN END
      { [] }
  | BEGIN is=instrs opt_semi END
      { is }
;

instrs:
  | i=instr                    { [i] }
  | is=instrs SEMI i=instr     { is @ [i] }
;

opt_semi:
  | SEMI { () }
  | /* vide */ { () }
;

/* ========================================================= */
/*                       INSTRUCTIONS                        */
/* ========================================================= */

instr:
  | d=instr_simple
      { let loc = ($startpos, $endpos) in { idesc = d; iloc = loc } }
  | IF e=expr b1=bloc
      {
        let loc = ($startpos, $endpos) in
        { idesc = If (e, b1, []); iloc = loc }
      }
  | IF e=expr b1=bloc ELSE b2=bloc
      {
        let loc = ($startpos, $endpos) in
        { idesc = If (e, b1, b2); iloc = loc }
      }
  | FOR b=bloc
      {
        (* for { b }  -> For(true, b) *)
        let loc = ($startpos, $endpos) in
        let cond = { edesc = Bool true; eloc = loc } in
        { idesc = For (cond, b); iloc = loc }
      }
  | FOR e=expr b=bloc
      {
        let loc = ($startpos, $endpos) in
        { idesc = For (e, b); iloc = loc }
      }
  | VAR ids=ident_list ty=opt_var_type init=opt_var_init
      {
        (* var x,y [ty] [= e1,...,en] *)
        let loc = ($startpos, $endpos) in
        let init_seq =
          match init with
          | [] -> []
          | es ->
              (* var x,y = e1,...,en  ≡ var x,y; x,y = e1,...,en *)
              let lhs =
                List.map (fun id ->
                    { edesc = Var id; eloc = id.loc }) ids
              in
              let set_instr =
                { idesc = Set (lhs, es); iloc = loc }
              in
              [ set_instr ]
        in
        { idesc = Vars (ids, ty, init_seq); iloc = loc }
      }
  | RETURN el=return_list
      {
        let loc = ($startpos, $endpos) in
        { idesc = Return el; iloc = loc }
      }
;

/* ----------------- retour -------------------------------- */

return_list:
  | /* vide */           { [] }
  | es=expr_list         { es }
;

/* ----------------- var ----------------------------------- */
/* opt_var_type ::= vide | type        */
/* opt_var_init ::= vide | = expr+ ,?  */

opt_var_type:
  | /* vide */        { None }
  | t=typ             { Some t }
;

opt_var_init:
  | /* vide */        { [] }
  | ASSIGN es=expr_list  { es }
;

/* ========================================================= */
/*                 INSTRUCTIONS SIMPLES                      */
/* ========================================================= */

instr_simple:
  | e=expr
      { Expr e }
  | e=expr PLUSPLUS
      { Inc e }
  | e=expr MINUSMINUS
      { Dec e }
  | lhs=expr_list ASSIGN rhs=expr_list
      { Set (List.rev lhs, List.rev rhs) }
  | ids_token=IDS_DECL es=expr_list
      {
        (* x,y := e1,...,en  ≡  var x,y = e1,...,en *)
        let loc = ($startpos, $endpos) in
        let ids = List.map (fun idstr -> { loc = ($startpos, $endpos); id = idstr }) ids_token in
        let lhs_exprs = List.map (fun id -> { edesc = Var id; eloc = id.loc }) ids in
        let set_instr = { idesc = Set (lhs_exprs, es); iloc = loc } in
        Vars (ids, None, [set_instr])
      }
;

expr_list:
  | e=expr                  { [e] }
  | el=expr_list COMMA e=expr  { el @ [e] }
;

/* ========================================================= */
/*                        EXPRESSIONS                        */
/* ========================================================= */

/* primary: atomic values and parenthesized expressions */
primary:
  | n=INT      { let loc = ($startpos, $endpos) in { edesc = Int n; eloc = loc } }
  | s=STRING   { let loc = ($startpos, $endpos) in { edesc = String s; eloc = loc } }
  | TRUE       { let loc = ($startpos, $endpos) in { edesc = Bool true; eloc = loc } }
  | FALSE      { let loc = ($startpos, $endpos) in { edesc = Bool false; eloc = loc } }
  | NIL        { let loc = ($startpos, $endpos) in { edesc = Nil; eloc = loc } }
  | LPAR e=expr RPAR { e }
  | id=ident   { { edesc = Var id; eloc = id.loc } }
;

/* postfix_suffix builds a chain of field accesses and calls in right-recursive fashion */
postfix_suffix:
  | /* empty */ { fun (p: Mgoast.expr) -> p }
  | DOT f=ident rest=postfix_suffix
      {
        fun (p: Mgoast.expr) ->
          let loc = ($startpos, $endpos) in
          let r = { edesc = Dot (p, f); eloc = loc } in
          rest r
      }
  | LPAR args=call_args RPAR rest=postfix_suffix
      {
        fun (p: Mgoast.expr) ->
          let loc = ($startpos, $endpos) in
          let r = match p.edesc with
            | Var id ->
                if id.id = "new" then
                  (match args with
                   | [ { edesc = Var sid; _ } ] -> { edesc = New sid.id; eloc = loc }
                   | _ -> failwith "new expects exactly one struct name argument")
                else { edesc = Call (id, args); eloc = loc }
            | Dot (e, pr) ->
                (match e.edesc with
                 | Var fmt when fmt.id = "fmt" && pr.id = "Print" -> { edesc = Print args; eloc = loc }
                 | _ -> failwith "only fmt.Print is supported as a dotted call")
            | _ -> failwith "invalid function call"
          in
          rest r
      }
;

postfix:
  | prim=primary suf=postfix_suffix { suf prim }
;

/* expression operators (left-recursive, precedence controlled by %left/%right declarations) */
expr:
  | e1=expr OR e2=expr
      { let loc = ($startpos, $endpos) in { edesc = Binop (Or, e1, e2); eloc = loc } }
  | e1=expr AND e2=expr
      { let loc = ($startpos, $endpos) in { edesc = Binop (And, e1, e2); eloc = loc } }
  | e1=expr EQEQ e2=expr
      { let loc = ($startpos, $endpos) in { edesc = Binop (Eq, e1, e2); eloc = loc } }
  | e1=expr NOTEQ e2=expr
      { let loc = ($startpos, $endpos) in { edesc = Binop (Neq, e1, e2); eloc = loc } }
  | e1=expr LT e2=expr
      { let loc = ($startpos, $endpos) in { edesc = Binop (Lt, e1, e2); eloc = loc } }
  | e1=expr LE e2=expr
      { let loc = ($startpos, $endpos) in { edesc = Binop (Le, e1, e2); eloc = loc } }
  | e1=expr GT e2=expr
      { let loc = ($startpos, $endpos) in { edesc = Binop (Gt, e1, e2); eloc = loc } }
  | e1=expr GE e2=expr
      { let loc = ($startpos, $endpos) in { edesc = Binop (Ge, e1, e2); eloc = loc } }
  | e1=expr PLUS e2=expr
      { let loc = ($startpos, $endpos) in { edesc = Binop (Add, e1, e2); eloc = loc } }
  | e1=expr MINUS e2=expr
      { let loc = ($startpos, $endpos) in { edesc = Binop (Sub, e1, e2); eloc = loc } }
  | e1=expr STAR e2=expr
      { let loc = ($startpos, $endpos) in { edesc = Binop (Mul, e1, e2); eloc = loc } }
  | e1=expr SLASH e2=expr
      { let loc = ($startpos, $endpos) in { edesc = Binop (Div, e1, e2); eloc = loc } }
  | e1=expr PERCENT e2=expr
      { let loc = ($startpos, $endpos) in { edesc = Binop (Rem, e1, e2); eloc = loc } }
  | NOT e=expr
      { let loc = ($startpos, $endpos) in { edesc = Unop (Not, e); eloc = loc } }
  | MINUS e=expr %prec UMINUS
      { let loc = ($startpos, $endpos) in { edesc = Unop (Opp, e); eloc = loc } }
  | p=postfix { p }
;

/* expr* ,  pour arguments de fonction, avec virgule finale optionnelle */
call_args:
  | /* vide */                        { [] }
  | e=expr                            { [e] }
  | es=call_args COMMA e=expr         { es @ [e] }
  | es=call_args COMMA                { es }   /* virgule finale optionnelle */
;

