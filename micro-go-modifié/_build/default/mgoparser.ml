
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | VAR
    | TYPE
    | TRUE
    | STRUCT
    | STRING of (
# 30 "mgoparser.mly"
       (string)
# 19 "mgoparser.ml"
  )
    | STAR
    | SLASH
    | SEMI
    | RPAR
    | RETURN
    | PLUSPLUS
    | PLUS
    | PERCENT
    | PACKAGE
    | OR
    | NOTEQ
    | NOT
    | NIL
    | MINUSMINUS
    | MINUS
    | LT
    | LPAR
    | LE
    | INT of (
# 28 "mgoparser.mly"
       (Int64.t)
# 42 "mgoparser.ml"
  )
    | IMPORT
    | IF
    | IDENT of (
# 29 "mgoparser.mly"
       (string)
# 49 "mgoparser.ml"
  )
    | GT
    | GE
    | FUNC
    | FOR
    | FALSE
    | EQEQ
    | EOF
    | END
    | ELSE
    | DOT
    | DECLARE
    | COMMA
    | BEGIN
    | ASSIGN
    | AND
    | AMPERSAND
  
end

include MenhirBasics

# 3 "mgoparser.mly"
  
open Mgoast

# 76 "mgoparser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState003 : ('s _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 003.
        Stack shape : IDENT.
        Start symbol: prog. *)

  | MenhirState004 : (('s, _menhir_box_prog) _menhir_cell1_TYPE, _menhir_box_prog) _menhir_state
    (** State 004.
        Stack shape : TYPE.
        Start symbol: prog. *)

  | MenhirState008 : ((('s, _menhir_box_prog) _menhir_cell1_TYPE, _menhir_box_prog) _menhir_cell1_ident, _menhir_box_prog) _menhir_state
    (** State 008.
        Stack shape : TYPE ident.
        Start symbol: prog. *)

  | MenhirState012 : (('s, _menhir_box_prog) _menhir_cell1_ident_list, _menhir_box_prog) _menhir_state
    (** State 012.
        Stack shape : ident_list.
        Start symbol: prog. *)

  | MenhirState016 : ((('s, _menhir_box_prog) _menhir_cell1_ident_list, _menhir_box_prog) _menhir_cell1_COMMA, _menhir_box_prog) _menhir_state
    (** State 016.
        Stack shape : ident_list COMMA.
        Start symbol: prog. *)

  | MenhirState022 : (('s, _menhir_box_prog) _menhir_cell1_field_decl, _menhir_box_prog) _menhir_state
    (** State 022.
        Stack shape : field_decl.
        Start symbol: prog. *)

  | MenhirState026 : (('s _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_IMPORT _menhir_cell0_STRING, _menhir_box_prog) _menhir_state
    (** State 026.
        Stack shape : IDENT IMPORT STRING.
        Start symbol: prog. *)

  | MenhirState027 : (('s, _menhir_box_prog) _menhir_cell1_FUNC, _menhir_box_prog) _menhir_state
    (** State 027.
        Stack shape : FUNC.
        Start symbol: prog. *)

  | MenhirState029 : ((('s, _menhir_box_prog) _menhir_cell1_FUNC, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR, _menhir_box_prog) _menhir_state
    (** State 029.
        Stack shape : FUNC ident LPAR.
        Start symbol: prog. *)

  | MenhirState031 : (('s, _menhir_box_prog) _menhir_cell1_vars_decl, _menhir_box_prog) _menhir_state
    (** State 031.
        Stack shape : vars_decl.
        Start symbol: prog. *)

  | MenhirState033 : (('s, _menhir_box_prog) _menhir_cell1_ident_list, _menhir_box_prog) _menhir_state
    (** State 033.
        Stack shape : ident_list.
        Start symbol: prog. *)

  | MenhirState037 : (((('s, _menhir_box_prog) _menhir_cell1_FUNC, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR, _menhir_box_prog) _menhir_cell1_opt_params _menhir_cell0_RPAR, _menhir_box_prog) _menhir_state
    (** State 037.
        Stack shape : FUNC ident LPAR opt_params RPAR.
        Start symbol: prog. *)

  | MenhirState038 : ((((('s, _menhir_box_prog) _menhir_cell1_FUNC, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR, _menhir_box_prog) _menhir_cell1_opt_params _menhir_cell0_RPAR, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_state
    (** State 038.
        Stack shape : FUNC ident LPAR opt_params RPAR LPAR.
        Start symbol: prog. *)

  | MenhirState040 : (('s, _menhir_box_prog) _menhir_cell1_typ, _menhir_box_prog) _menhir_state
    (** State 040.
        Stack shape : typ.
        Start symbol: prog. *)

  | MenhirState045 : ((((('s, _menhir_box_prog) _menhir_cell1_FUNC, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR, _menhir_box_prog) _menhir_cell1_opt_params _menhir_cell0_RPAR, _menhir_box_prog) _menhir_cell1_opt_type_ret, _menhir_box_prog) _menhir_state
    (** State 045.
        Stack shape : FUNC ident LPAR opt_params RPAR opt_type_ret.
        Start symbol: prog. *)

  | MenhirState046 : (('s, _menhir_box_prog) _menhir_cell1_BEGIN, _menhir_box_prog) _menhir_state
    (** State 046.
        Stack shape : BEGIN.
        Start symbol: prog. *)

  | MenhirState047 : (('s, _menhir_box_prog) _menhir_cell1_VAR, _menhir_box_prog) _menhir_state
    (** State 047.
        Stack shape : VAR.
        Start symbol: prog. *)

  | MenhirState048 : ((('s, _menhir_box_prog) _menhir_cell1_VAR, _menhir_box_prog) _menhir_cell1_ident_list, _menhir_box_prog) _menhir_state
    (** State 048.
        Stack shape : VAR ident_list.
        Start symbol: prog. *)

  | MenhirState051 : (((('s, _menhir_box_prog) _menhir_cell1_VAR, _menhir_box_prog) _menhir_cell1_ident_list, _menhir_box_prog) _menhir_cell1_opt_var_type, _menhir_box_prog) _menhir_state
    (** State 051.
        Stack shape : VAR ident_list opt_var_type.
        Start symbol: prog. *)

  | MenhirState054 : (('s, _menhir_box_prog) _menhir_cell1_NOT, _menhir_box_prog) _menhir_state
    (** State 054.
        Stack shape : NOT.
        Start symbol: prog. *)

  | MenhirState056 : (('s, _menhir_box_prog) _menhir_cell1_MINUS, _menhir_box_prog) _menhir_state
    (** State 056.
        Stack shape : MINUS.
        Start symbol: prog. *)

  | MenhirState057 : (('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_state
    (** State 057.
        Stack shape : LPAR.
        Start symbol: prog. *)

  | MenhirState061 : (('s, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR, _menhir_box_prog) _menhir_state
    (** State 061.
        Stack shape : ident LPAR.
        Start symbol: prog. *)

  | MenhirState062 : ((('s, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 062.
        Stack shape : ident LPAR expr.
        Start symbol: prog. *)

  | MenhirState063 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_STAR, _menhir_box_prog) _menhir_state
    (** State 063.
        Stack shape : expr STAR.
        Start symbol: prog. *)

  | MenhirState064 : (((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_STAR, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 064.
        Stack shape : expr STAR expr.
        Start symbol: prog. *)

  | MenhirState065 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_DOT, _menhir_box_prog) _menhir_state
    (** State 065.
        Stack shape : expr DOT.
        Start symbol: prog. *)

  | MenhirState067 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_SLASH, _menhir_box_prog) _menhir_state
    (** State 067.
        Stack shape : expr SLASH.
        Start symbol: prog. *)

  | MenhirState068 : (((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_SLASH, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 068.
        Stack shape : expr SLASH expr.
        Start symbol: prog. *)

  | MenhirState069 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_PLUS, _menhir_box_prog) _menhir_state
    (** State 069.
        Stack shape : expr PLUS.
        Start symbol: prog. *)

  | MenhirState070 : (((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_PLUS, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 070.
        Stack shape : expr PLUS expr.
        Start symbol: prog. *)

  | MenhirState071 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_PERCENT, _menhir_box_prog) _menhir_state
    (** State 071.
        Stack shape : expr PERCENT.
        Start symbol: prog. *)

  | MenhirState072 : (((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_PERCENT, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 072.
        Stack shape : expr PERCENT expr.
        Start symbol: prog. *)

  | MenhirState073 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_OR, _menhir_box_prog) _menhir_state
    (** State 073.
        Stack shape : expr OR.
        Start symbol: prog. *)

  | MenhirState074 : (((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_OR, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 074.
        Stack shape : expr OR expr.
        Start symbol: prog. *)

  | MenhirState075 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_NOTEQ, _menhir_box_prog) _menhir_state
    (** State 075.
        Stack shape : expr NOTEQ.
        Start symbol: prog. *)

  | MenhirState076 : (((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_NOTEQ, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 076.
        Stack shape : expr NOTEQ expr.
        Start symbol: prog. *)

  | MenhirState077 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_MINUS, _menhir_box_prog) _menhir_state
    (** State 077.
        Stack shape : expr MINUS.
        Start symbol: prog. *)

  | MenhirState078 : (((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_MINUS, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 078.
        Stack shape : expr MINUS expr.
        Start symbol: prog. *)

  | MenhirState079 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_LT, _menhir_box_prog) _menhir_state
    (** State 079.
        Stack shape : expr LT.
        Start symbol: prog. *)

  | MenhirState080 : (((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_LT, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 080.
        Stack shape : expr LT expr.
        Start symbol: prog. *)

  | MenhirState081 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_LE, _menhir_box_prog) _menhir_state
    (** State 081.
        Stack shape : expr LE.
        Start symbol: prog. *)

  | MenhirState082 : (((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_LE, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 082.
        Stack shape : expr LE expr.
        Start symbol: prog. *)

  | MenhirState083 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_GT, _menhir_box_prog) _menhir_state
    (** State 083.
        Stack shape : expr GT.
        Start symbol: prog. *)

  | MenhirState084 : (((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_GT, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 084.
        Stack shape : expr GT expr.
        Start symbol: prog. *)

  | MenhirState085 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_GE, _menhir_box_prog) _menhir_state
    (** State 085.
        Stack shape : expr GE.
        Start symbol: prog. *)

  | MenhirState086 : (((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_GE, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 086.
        Stack shape : expr GE expr.
        Start symbol: prog. *)

  | MenhirState087 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_EQEQ, _menhir_box_prog) _menhir_state
    (** State 087.
        Stack shape : expr EQEQ.
        Start symbol: prog. *)

  | MenhirState088 : (((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_EQEQ, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 088.
        Stack shape : expr EQEQ expr.
        Start symbol: prog. *)

  | MenhirState089 : ((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_AND, _menhir_box_prog) _menhir_state
    (** State 089.
        Stack shape : expr AND.
        Start symbol: prog. *)

  | MenhirState090 : (((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_AND, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 090.
        Stack shape : expr AND expr.
        Start symbol: prog. *)

  | MenhirState093 : ((('s, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR, _menhir_box_prog) _menhir_cell1_call_args, _menhir_box_prog) _menhir_state
    (** State 093.
        Stack shape : ident LPAR call_args.
        Start symbol: prog. *)

  | MenhirState094 : (((('s, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR, _menhir_box_prog) _menhir_cell1_call_args, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 094.
        Stack shape : ident LPAR call_args expr.
        Start symbol: prog. *)

  | MenhirState095 : (('s, _menhir_box_prog) _menhir_cell1_ident, _menhir_box_prog) _menhir_state
    (** State 095.
        Stack shape : ident.
        Start symbol: prog. *)

  | MenhirState097 : ((('s, _menhir_box_prog) _menhir_cell1_ident, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR, _menhir_box_prog) _menhir_state
    (** State 097.
        Stack shape : ident ident LPAR.
        Start symbol: prog. *)

  | MenhirState100 : ((('s, _menhir_box_prog) _menhir_cell1_LPAR, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 100.
        Stack shape : LPAR expr.
        Start symbol: prog. *)

  | MenhirState102 : ((('s, _menhir_box_prog) _menhir_cell1_MINUS, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 102.
        Stack shape : MINUS expr.
        Start symbol: prog. *)

  | MenhirState103 : ((('s, _menhir_box_prog) _menhir_cell1_NOT, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 103.
        Stack shape : NOT expr.
        Start symbol: prog. *)

  | MenhirState105 : (('s, _menhir_box_prog) _menhir_cell1_expr_list, _menhir_box_prog) _menhir_state
    (** State 105.
        Stack shape : expr_list.
        Start symbol: prog. *)

  | MenhirState106 : ((('s, _menhir_box_prog) _menhir_cell1_expr_list, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 106.
        Stack shape : expr_list expr.
        Start symbol: prog. *)

  | MenhirState107 : (('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 107.
        Stack shape : expr.
        Start symbol: prog. *)

  | MenhirState109 : (('s, _menhir_box_prog) _menhir_cell1_RETURN, _menhir_box_prog) _menhir_state
    (** State 109.
        Stack shape : RETURN.
        Start symbol: prog. *)

  | MenhirState112 : (('s, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_state
    (** State 112.
        Stack shape : IF.
        Start symbol: prog. *)

  | MenhirState113 : ((('s, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 113.
        Stack shape : IF expr.
        Start symbol: prog. *)

  | MenhirState115 : (((('s, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_bloc, _menhir_box_prog) _menhir_state
    (** State 115.
        Stack shape : IF expr bloc.
        Start symbol: prog. *)

  | MenhirState117 : (('s, _menhir_box_prog) _menhir_cell1_FOR, _menhir_box_prog) _menhir_state
    (** State 117.
        Stack shape : FOR.
        Start symbol: prog. *)

  | MenhirState118 : ((('s, _menhir_box_prog) _menhir_cell1_FOR, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 118.
        Stack shape : FOR expr.
        Start symbol: prog. *)

  | MenhirState123 : ((('s, _menhir_box_prog) _menhir_cell1_BEGIN, _menhir_box_prog) _menhir_cell1_instrs, _menhir_box_prog) _menhir_state
    (** State 123.
        Stack shape : BEGIN instrs.
        Start symbol: prog. *)

  | MenhirState126 : (('s, _menhir_box_prog) _menhir_cell1_ident_list, _menhir_box_prog) _menhir_state
    (** State 126.
        Stack shape : ident_list.
        Start symbol: prog. *)

  | MenhirState127 : ((('s, _menhir_box_prog) _menhir_cell1_ident_list, _menhir_box_prog) _menhir_cell1_DECLARE, _menhir_box_prog) _menhir_state
    (** State 127.
        Stack shape : ident_list DECLARE.
        Start symbol: prog. *)

  | MenhirState131 : (('s, _menhir_box_prog) _menhir_cell1_expr_list, _menhir_box_prog) _menhir_state
    (** State 131.
        Stack shape : expr_list.
        Start symbol: prog. *)

  | MenhirState133 : (('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 133.
        Stack shape : expr.
        Start symbol: prog. *)

  | MenhirState143 : ((('s _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_IMPORT _menhir_cell0_STRING, _menhir_box_prog) _menhir_cell1_decls, _menhir_box_prog) _menhir_state
    (** State 143.
        Stack shape : IDENT IMPORT STRING decls.
        Start symbol: prog. *)

  | MenhirState147 : (('s _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_decls, _menhir_box_prog) _menhir_state
    (** State 147.
        Stack shape : IDENT decls.
        Start symbol: prog. *)


and ('s, 'r) _menhir_cell1_bloc = 
  | MenhirCell1_bloc of 's * ('s, 'r) _menhir_state * (Mgoast.seq) * Lexing.position

and ('s, 'r) _menhir_cell1_call_args = 
  | MenhirCell1_call_args of 's * ('s, 'r) _menhir_state * (Mgoast.expr list)

and ('s, 'r) _menhir_cell1_decls = 
  | MenhirCell1_decls of 's * ('s, 'r) _menhir_state * (Mgoast.decl list)

and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (Mgoast.expr) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_expr_list = 
  | MenhirCell1_expr_list of 's * ('s, 'r) _menhir_state * (Mgoast.expr list) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_field_decl = 
  | MenhirCell1_field_decl of 's * ('s, 'r) _menhir_state * ((Mgoast.ident * Mgoast.typ) list)

and ('s, 'r) _menhir_cell1_ident = 
  | MenhirCell1_ident of 's * ('s, 'r) _menhir_state * (Mgoast.ident) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_ident_list = 
  | MenhirCell1_ident_list of 's * ('s, 'r) _menhir_state * (Mgoast.ident list) * Lexing.position

and ('s, 'r) _menhir_cell1_instrs = 
  | MenhirCell1_instrs of 's * ('s, 'r) _menhir_state * (Mgoast.seq)

and ('s, 'r) _menhir_cell1_opt_params = 
  | MenhirCell1_opt_params of 's * ('s, 'r) _menhir_state * ((Mgoast.ident * Mgoast.typ) list)

and ('s, 'r) _menhir_cell1_opt_type_ret = 
  | MenhirCell1_opt_type_ret of 's * ('s, 'r) _menhir_state * (Mgoast.typ list)

and ('s, 'r) _menhir_cell1_opt_var_type = 
  | MenhirCell1_opt_var_type of 's * ('s, 'r) _menhir_state * (Mgoast.typ option)

and ('s, 'r) _menhir_cell1_typ = 
  | MenhirCell1_typ of 's * ('s, 'r) _menhir_state * (Mgoast.typ)

and ('s, 'r) _menhir_cell1_vars_decl = 
  | MenhirCell1_vars_decl of 's * ('s, 'r) _menhir_state * ((Mgoast.ident * Mgoast.typ) list)

and ('s, 'r) _menhir_cell1_AND = 
  | MenhirCell1_AND of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_BEGIN = 
  | MenhirCell1_BEGIN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_COMMA = 
  | MenhirCell1_COMMA of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_DECLARE = 
  | MenhirCell1_DECLARE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_DOT = 
  | MenhirCell1_DOT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_EQEQ = 
  | MenhirCell1_EQEQ of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_FOR = 
  | MenhirCell1_FOR of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_FUNC = 
  | MenhirCell1_FUNC of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_GE = 
  | MenhirCell1_GE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_GT = 
  | MenhirCell1_GT of 's * ('s, 'r) _menhir_state

and 's _menhir_cell0_IDENT = 
  | MenhirCell0_IDENT of 's * (
# 29 "mgoparser.mly"
       (string)
# 526 "mgoparser.ml"
) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_IF = 
  | MenhirCell1_IF of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_IMPORT = 
  | MenhirCell1_IMPORT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LE = 
  | MenhirCell1_LE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LPAR = 
  | MenhirCell1_LPAR of 's * ('s, 'r) _menhir_state * Lexing.position

and 's _menhir_cell0_LPAR = 
  | MenhirCell0_LPAR of 's * Lexing.position

and ('s, 'r) _menhir_cell1_LT = 
  | MenhirCell1_LT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_MINUS = 
  | MenhirCell1_MINUS of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_NOT = 
  | MenhirCell1_NOT of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_NOTEQ = 
  | MenhirCell1_NOTEQ of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_OR = 
  | MenhirCell1_OR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_PERCENT = 
  | MenhirCell1_PERCENT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_PLUS = 
  | MenhirCell1_PLUS of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_RETURN = 
  | MenhirCell1_RETURN of 's * ('s, 'r) _menhir_state * Lexing.position

and 's _menhir_cell0_RPAR = 
  | MenhirCell0_RPAR of 's * Lexing.position

and ('s, 'r) _menhir_cell1_SLASH = 
  | MenhirCell1_SLASH of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_STAR = 
  | MenhirCell1_STAR of 's * ('s, 'r) _menhir_state

and 's _menhir_cell0_STRING = 
  | MenhirCell0_STRING of 's * (
# 30 "mgoparser.mly"
       (string)
# 581 "mgoparser.ml"
) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_TYPE = 
  | MenhirCell1_TYPE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_VAR = 
  | MenhirCell1_VAR of 's * ('s, 'r) _menhir_state * Lexing.position

and _menhir_box_prog = 
  | MenhirBox_prog of (Mgoast.program) [@@unboxed]

let _menhir_action_01 =
  fun () ->
    (
# 199 "mgoparser.mly"
      ( [] )
# 598 "mgoparser.ml"
     : (Mgoast.seq))

let _menhir_action_02 =
  fun is ->
    (
# 201 "mgoparser.mly"
      ( is )
# 606 "mgoparser.ml"
     : (Mgoast.seq))

let _menhir_action_03 =
  fun () ->
    (
# 468 "mgoparser.mly"
                                      ( [] )
# 614 "mgoparser.ml"
     : (Mgoast.expr list))

let _menhir_action_04 =
  fun e ->
    (
# 469 "mgoparser.mly"
                                      ( [e] )
# 622 "mgoparser.ml"
     : (Mgoast.expr list))

let _menhir_action_05 =
  fun e es ->
    (
# 470 "mgoparser.mly"
                                      ( es @ [e] )
# 630 "mgoparser.ml"
     : (Mgoast.expr list))

let _menhir_action_06 =
  fun es ->
    (
# 471 "mgoparser.mly"
                                      ( es )
# 638 "mgoparser.ml"
     : (Mgoast.expr list))

let _menhir_action_07 =
  fun _1 ->
    (
# 81 "mgoparser.mly"
                          ( Struct _1 )
# 646 "mgoparser.ml"
     : (Mgoast.decl))

let _menhir_action_08 =
  fun _1 ->
    (
# 82 "mgoparser.mly"
                          ( Fun _1 )
# 654 "mgoparser.ml"
     : (Mgoast.decl))

let _menhir_action_09 =
  fun () ->
    (
# 75 "mgoparser.mly"
                         ( [] )
# 662 "mgoparser.ml"
     : (Mgoast.decl list))

let _menhir_action_10 =
  fun d ds ->
    (
# 76 "mgoparser.mly"
                         ( d :: ds )
# 670 "mgoparser.ml"
     : (Mgoast.decl list))

let _menhir_action_11 =
  fun d ->
    (
# 77 "mgoparser.mly"
                         ( [d] )
# 678 "mgoparser.ml"
     : (Mgoast.decl list))

let _menhir_action_12 =
  fun _endpos_n_ _startpos_n_ n ->
    let _endpos = _endpos_n_ in
    let _startpos = _startpos_n_ in
    (
# 330 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Int n; eloc = loc }
      )
# 691 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_13 =
  fun _endpos_s_ _startpos_s_ s ->
    let _endpos = _endpos_s_ in
    let _startpos = _startpos_s_ in
    (
# 335 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = String s; eloc = loc }
      )
# 704 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_14 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 340 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Bool true; eloc = loc }
      )
# 717 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_15 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 345 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Bool false; eloc = loc }
      )
# 730 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_16 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    (
# 350 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Nil; eloc = loc }
      )
# 743 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_17 =
  fun e ->
    (
# 355 "mgoparser.mly"
      ( e )
# 751 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_18 =
  fun x ->
    (
# 357 "mgoparser.mly"
      (
        { edesc = Var x; eloc = x.loc }
      )
# 761 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_19 =
  fun _endpos_f_ _startpos_e_ e f ->
    let _endpos = _endpos_f_ in
    let _startpos = _startpos_e_ in
    (
# 361 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Dot (e, f); eloc = loc }
      )
# 774 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_20 =
  fun _endpos__6_ _startpos_fmt_ args fmt pr ->
    let _endpos = _endpos__6_ in
    let _startpos = _startpos_fmt_ in
    (
# 367 "mgoparser.mly"
      (
        if fmt.id = "fmt" && pr.id = "Print" then
          let loc = (_startpos, _endpos) in
          { edesc = Print args; eloc = loc }
        else
          failwith "only fmt.Print is supported as a dotted call"
      )
# 790 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_21 =
  fun _endpos__4_ _startpos_f_ args f ->
    let _endpos = _endpos__4_ in
    let _startpos = _startpos_f_ in
    (
# 376 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        if f.id = "new" then
          match args with
          | [ { edesc = Var sid; _ } ] ->
              { edesc = New sid.id; eloc = loc }
          | _ ->
              failwith "new expects exactly one struct name argument"
        else
          { edesc = Call (f, args); eloc = loc }
      )
# 810 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_22 =
  fun _endpos_e_ _startpos__1_ e ->
    let _endpos = _endpos_e_ in
    let _startpos = _startpos__1_ in
    (
# 389 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Unop (Not, e); eloc = loc }
      )
# 823 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_23 =
  fun _endpos_e_ _startpos__1_ e ->
    let _endpos = _endpos_e_ in
    let _startpos = _startpos__1_ in
    (
# 394 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Unop (Opp, e); eloc = loc }
      )
# 836 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_24 =
  fun _endpos_e2_ _startpos_e1_ e1 e2 ->
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    (
# 400 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Binop (Add, e1, e2); eloc = loc }
      )
# 849 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_25 =
  fun _endpos_e2_ _startpos_e1_ e1 e2 ->
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    (
# 405 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Binop (Sub, e1, e2); eloc = loc }
      )
# 862 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_26 =
  fun _endpos_e2_ _startpos_e1_ e1 e2 ->
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    (
# 410 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Binop (Mul, e1, e2); eloc = loc }
      )
# 875 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_27 =
  fun _endpos_e2_ _startpos_e1_ e1 e2 ->
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    (
# 415 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Binop (Div, e1, e2); eloc = loc }
      )
# 888 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_28 =
  fun _endpos_e2_ _startpos_e1_ e1 e2 ->
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    (
# 420 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Binop (Rem, e1, e2); eloc = loc }
      )
# 901 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_29 =
  fun _endpos_e2_ _startpos_e1_ e1 e2 ->
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    (
# 425 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Binop (Eq, e1, e2); eloc = loc }
      )
# 914 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_30 =
  fun _endpos_e2_ _startpos_e1_ e1 e2 ->
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    (
# 430 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Binop (Neq, e1, e2); eloc = loc }
      )
# 927 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_31 =
  fun _endpos_e2_ _startpos_e1_ e1 e2 ->
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    (
# 435 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Binop (Lt, e1, e2); eloc = loc }
      )
# 940 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_32 =
  fun _endpos_e2_ _startpos_e1_ e1 e2 ->
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    (
# 440 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Binop (Le, e1, e2); eloc = loc }
      )
# 953 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_33 =
  fun _endpos_e2_ _startpos_e1_ e1 e2 ->
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    (
# 445 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Binop (Gt, e1, e2); eloc = loc }
      )
# 966 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_34 =
  fun _endpos_e2_ _startpos_e1_ e1 e2 ->
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    (
# 450 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Binop (Ge, e1, e2); eloc = loc }
      )
# 979 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_35 =
  fun _endpos_e2_ _startpos_e1_ e1 e2 ->
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    (
# 455 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Binop (And, e1, e2); eloc = loc }
      )
# 992 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_36 =
  fun _endpos_e2_ _startpos_e1_ e1 e2 ->
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    (
# 460 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { edesc = Binop (Or, e1, e2); eloc = loc }
      )
# 1005 "mgoparser.ml"
     : (Mgoast.expr))

let _menhir_action_37 =
  fun e ->
    (
# 320 "mgoparser.mly"
                            ( [e] )
# 1013 "mgoparser.ml"
     : (Mgoast.expr list))

let _menhir_action_38 =
  fun e el ->
    (
# 321 "mgoparser.mly"
                               ( el @ [e] )
# 1021 "mgoparser.ml"
     : (Mgoast.expr list))

let _menhir_action_39 =
  fun ids ty ->
    (
# 117 "mgoparser.mly"
      ( List.map (fun id -> (id, ty)) ids )
# 1029 "mgoparser.ml"
     : ((Mgoast.ident * Mgoast.typ) list))

let _menhir_action_40 =
  fun fd ->
    (
# 108 "mgoparser.mly"
                                     ( fd )
# 1037 "mgoparser.ml"
     : ((Mgoast.ident * Mgoast.typ) list))

let _menhir_action_41 =
  fun fd ->
    (
# 109 "mgoparser.mly"
                                     ( fd )
# 1045 "mgoparser.ml"
     : ((Mgoast.ident * Mgoast.typ) list))

let _menhir_action_42 =
  fun fd fds ->
    (
# 111 "mgoparser.mly"
      ( fd @ fds )
# 1053 "mgoparser.ml"
     : ((Mgoast.ident * Mgoast.typ) list))

let _menhir_action_43 =
  fun body f params ret ->
    (
# 151 "mgoparser.mly"
      (
        {
          fname  = f;
          params = params;        (* (ident * typ) list *)
          return = ret;           (* typ list *)
          body   = body;          (* seq = instr list *)
        }
      )
# 1068 "mgoparser.ml"
     : (Mgoast.func_def))

let _menhir_action_44 =
  fun _endpos_x_ _startpos_x_ x ->
    let _endpos = _endpos_x_ in
    let _startpos = _startpos_x_ in
    (
# 56 "mgoparser.mly"
          ( { loc = (_startpos, _endpos); id = x } )
# 1078 "mgoparser.ml"
     : (Mgoast.ident))

let _menhir_action_45 =
  fun i ->
    (
# 122 "mgoparser.mly"
                                 ( [i] )
# 1086 "mgoparser.ml"
     : (Mgoast.ident list))

let _menhir_action_46 =
  fun i il ->
    (
# 123 "mgoparser.mly"
                                 ( il @ [i] )
# 1094 "mgoparser.ml"
     : (Mgoast.ident list))

let _menhir_action_47 =
  fun _endpos_d_ _startpos_d_ d ->
    let _endpos = _endpos_d_ in
    let _startpos = _startpos_d_ in
    (
# 220 "mgoparser.mly"
      ( let loc = (_startpos, _endpos) in { idesc = d; iloc = loc } )
# 1104 "mgoparser.ml"
     : (Mgoast.instr))

let _menhir_action_48 =
  fun _endpos_b1_ _startpos__1_ b1 e ->
    let _endpos = _endpos_b1_ in
    let _startpos = _startpos__1_ in
    (
# 222 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { idesc = If (e, b1, []); iloc = loc }
      )
# 1117 "mgoparser.ml"
     : (Mgoast.instr))

let _menhir_action_49 =
  fun _endpos_b2_ _startpos__1_ b1 b2 e ->
    let _endpos = _endpos_b2_ in
    let _startpos = _startpos__1_ in
    (
# 227 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { idesc = If (e, b1, b2); iloc = loc }
      )
# 1130 "mgoparser.ml"
     : (Mgoast.instr))

let _menhir_action_50 =
  fun _endpos_b_ _startpos__1_ b ->
    let _endpos = _endpos_b_ in
    let _startpos = _startpos__1_ in
    (
# 232 "mgoparser.mly"
      (
        (* for { b }  -> For(true, b) *)
        let loc = (_startpos, _endpos) in
        let cond = { edesc = Bool true; eloc = loc } in
        { idesc = For (cond, b); iloc = loc }
      )
# 1145 "mgoparser.ml"
     : (Mgoast.instr))

let _menhir_action_51 =
  fun _endpos_b_ _startpos__1_ b e ->
    let _endpos = _endpos_b_ in
    let _startpos = _startpos__1_ in
    (
# 239 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { idesc = For (e, b); iloc = loc }
      )
# 1158 "mgoparser.ml"
     : (Mgoast.instr))

let _menhir_action_52 =
  fun _endpos_init_ _startpos__1_ ids init ty ->
    let _endpos = _endpos_init_ in
    let _startpos = _startpos__1_ in
    (
# 244 "mgoparser.mly"
      (
        (* var x,y [ty] [= e1,...,en] *)
        let loc = (_startpos, _endpos) in
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
      )
# 1186 "mgoparser.ml"
     : (Mgoast.instr))

let _menhir_action_53 =
  fun _endpos_el_ _startpos__1_ el ->
    let _endpos = _endpos_el_ in
    let _startpos = _startpos__1_ in
    (
# 264 "mgoparser.mly"
      (
        let loc = (_startpos, _endpos) in
        { idesc = Return el; iloc = loc }
      )
# 1199 "mgoparser.ml"
     : (Mgoast.instr))

let _menhir_action_54 =
  fun e ->
    (
# 297 "mgoparser.mly"
      ( Expr e )
# 1207 "mgoparser.ml"
     : (Mgoast.instr_desc))

let _menhir_action_55 =
  fun e ->
    (
# 299 "mgoparser.mly"
      ( Inc e )
# 1215 "mgoparser.ml"
     : (Mgoast.instr_desc))

let _menhir_action_56 =
  fun e ->
    (
# 301 "mgoparser.mly"
      ( Dec e )
# 1223 "mgoparser.ml"
     : (Mgoast.instr_desc))

let _menhir_action_57 =
  fun lhs rhs ->
    (
# 303 "mgoparser.mly"
      ( Set (List.rev lhs, List.rev rhs) )
# 1231 "mgoparser.ml"
     : (Mgoast.instr_desc))

let _menhir_action_58 =
  fun _endpos_es_ _startpos_ids_ es ids ->
    let _endpos = _endpos_es_ in
    let _startpos = _startpos_ids_ in
    (
# 305 "mgoparser.mly"
      (
        (* x,y := e1,...,en  ≡  var x,y = e1,...,en *)
        let loc = (_startpos, _endpos) in
        let lhs =
          List.map (fun id ->
              { edesc = Var id; eloc = id.loc }) ids
        in
        let set_instr =
          { idesc = Set (lhs, es); iloc = loc }
        in
        Vars (ids, None, [set_instr])
      )
# 1252 "mgoparser.ml"
     : (Mgoast.instr_desc))

let _menhir_action_59 =
  fun i ->
    (
# 205 "mgoparser.mly"
                               ( [i] )
# 1260 "mgoparser.ml"
     : (Mgoast.seq))

let _menhir_action_60 =
  fun i is ->
    (
# 206 "mgoparser.mly"
                               ( is @ [i] )
# 1268 "mgoparser.ml"
     : (Mgoast.seq))

let _menhir_action_61 =
  fun () ->
    (
# 102 "mgoparser.mly"
                    ( [] )
# 1276 "mgoparser.ml"
     : ((Mgoast.ident * Mgoast.typ) list))

let _menhir_action_62 =
  fun l ->
    (
# 103 "mgoparser.mly"
                    ( l )
# 1284 "mgoparser.ml"
     : ((Mgoast.ident * Mgoast.typ) list))

let _menhir_action_63 =
  fun () ->
    (
# 163 "mgoparser.mly"
                            ( [] )
# 1292 "mgoparser.ml"
     : ((Mgoast.ident * Mgoast.typ) list))

let _menhir_action_64 =
  fun ps ->
    (
# 164 "mgoparser.mly"
                            ( ps )
# 1300 "mgoparser.ml"
     : ((Mgoast.ident * Mgoast.typ) list))

let _menhir_action_65 =
  fun () ->
    (
# 210 "mgoparser.mly"
         ( () )
# 1308 "mgoparser.ml"
     : (unit))

let _menhir_action_66 =
  fun () ->
    (
# 211 "mgoparser.mly"
               ( () )
# 1316 "mgoparser.ml"
     : (unit))

let _menhir_action_67 =
  fun () ->
    (
# 181 "mgoparser.mly"
                           ( [] )
# 1324 "mgoparser.ml"
     : (Mgoast.typ list))

let _menhir_action_68 =
  fun t ->
    (
# 182 "mgoparser.mly"
                           ( [t] )
# 1332 "mgoparser.ml"
     : (Mgoast.typ list))

let _menhir_action_69 =
  fun ts ->
    (
# 183 "mgoparser.mly"
                               ( ts )
# 1340 "mgoparser.ml"
     : (Mgoast.typ list))

let _menhir_action_70 =
  fun () ->
    (
# 287 "mgoparser.mly"
                      ( [] )
# 1348 "mgoparser.ml"
     : (Mgoast.expr list))

let _menhir_action_71 =
  fun es ->
    (
# 288 "mgoparser.mly"
                         ( es )
# 1356 "mgoparser.ml"
     : (Mgoast.expr list))

let _menhir_action_72 =
  fun () ->
    (
# 282 "mgoparser.mly"
                      ( None )
# 1364 "mgoparser.ml"
     : (Mgoast.typ option))

let _menhir_action_73 =
  fun t ->
    (
# 283 "mgoparser.mly"
                      ( Some t )
# 1372 "mgoparser.ml"
     : (Mgoast.typ option))

let _menhir_action_74 =
  fun v ->
    (
# 168 "mgoparser.mly"
                                     ( v )
# 1380 "mgoparser.ml"
     : ((Mgoast.ident * Mgoast.typ) list))

let _menhir_action_75 =
  fun rest v ->
    (
# 169 "mgoparser.mly"
                                      ( v @ rest )
# 1388 "mgoparser.ml"
     : ((Mgoast.ident * Mgoast.typ) list))

let _menhir_action_76 =
  fun _main ds ->
    (
# 65 "mgoparser.mly"
      ( (false, List.rev ds) )
# 1396 "mgoparser.ml"
     : (Mgoast.program))

let _menhir_action_77 =
  fun _main _s ds ->
    (
# 67 "mgoparser.mly"
      ( (true, List.rev ds) )
# 1404 "mgoparser.ml"
     : (Mgoast.program))

let _menhir_action_78 =
  fun t ->
    (
# 187 "mgoparser.mly"
                                 ( [t] )
# 1412 "mgoparser.ml"
     : (Mgoast.typ list))

let _menhir_action_79 =
  fun rest t ->
    (
# 188 "mgoparser.mly"
                                   ( t :: rest )
# 1420 "mgoparser.ml"
     : (Mgoast.typ list))

let _menhir_action_80 =
  fun t ->
    (
# 189 "mgoparser.mly"
                                 ( [t] )
# 1428 "mgoparser.ml"
     : (Mgoast.typ list))

let _menhir_action_81 =
  fun () ->
    (
# 273 "mgoparser.mly"
                         ( [] )
# 1436 "mgoparser.ml"
     : (Mgoast.expr list))

let _menhir_action_82 =
  fun es ->
    (
# 274 "mgoparser.mly"
                         ( es )
# 1444 "mgoparser.ml"
     : (Mgoast.expr list))

let _menhir_action_83 =
  fun fs id ->
    (
# 92 "mgoparser.mly"
      (
        {
          sname  = id;
          fields = fs;
        }
      )
# 1457 "mgoparser.ml"
     : (Mgoast.struct_def))

let _menhir_action_84 =
  fun s ->
    (
# 133 "mgoparser.mly"
      (
        match s with
        | "int"    -> TInt
        | "bool"   -> TBool
        | "string" -> TString
        | _        -> failwith "unknown base type"
      )
# 1471 "mgoparser.ml"
     : (Mgoast.typ))

let _menhir_action_85 =
  fun s ->
    (
# 141 "mgoparser.mly"
      ( TStruct s )
# 1479 "mgoparser.ml"
     : (Mgoast.typ))

let _menhir_action_86 =
  fun ids ty ->
    (
# 175 "mgoparser.mly"
      ( List.map (fun id -> (id, ty)) ids )
# 1487 "mgoparser.ml"
     : ((Mgoast.ident * Mgoast.typ) list))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | AMPERSAND ->
        "AMPERSAND"
    | AND ->
        "AND"
    | ASSIGN ->
        "ASSIGN"
    | BEGIN ->
        "BEGIN"
    | COMMA ->
        "COMMA"
    | DECLARE ->
        "DECLARE"
    | DOT ->
        "DOT"
    | ELSE ->
        "ELSE"
    | END ->
        "END"
    | EOF ->
        "EOF"
    | EQEQ ->
        "EQEQ"
    | FALSE ->
        "FALSE"
    | FOR ->
        "FOR"
    | FUNC ->
        "FUNC"
    | GE ->
        "GE"
    | GT ->
        "GT"
    | IDENT _ ->
        "IDENT"
    | IF ->
        "IF"
    | IMPORT ->
        "IMPORT"
    | INT _ ->
        "INT"
    | LE ->
        "LE"
    | LPAR ->
        "LPAR"
    | LT ->
        "LT"
    | MINUS ->
        "MINUS"
    | MINUSMINUS ->
        "MINUSMINUS"
    | NIL ->
        "NIL"
    | NOT ->
        "NOT"
    | NOTEQ ->
        "NOTEQ"
    | OR ->
        "OR"
    | PACKAGE ->
        "PACKAGE"
    | PERCENT ->
        "PERCENT"
    | PLUS ->
        "PLUS"
    | PLUSPLUS ->
        "PLUSPLUS"
    | RETURN ->
        "RETURN"
    | RPAR ->
        "RPAR"
    | SEMI ->
        "SEMI"
    | SLASH ->
        "SLASH"
    | STAR ->
        "STAR"
    | STRING _ ->
        "STRING"
    | STRUCT ->
        "STRUCT"
    | TRUE ->
        "TRUE"
    | TYPE ->
        "TYPE"
    | VAR ->
        "VAR"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_goto_prog : type  ttv_stack. ttv_stack -> _ -> _menhir_box_prog =
    fun _menhir_stack _v ->
      MenhirBox_prog _v
  
  let rec _menhir_run_004 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_TYPE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState004 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_005 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos_x_, _startpos_x_, x) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_44 _endpos_x_ _startpos_x_ x in
      _menhir_goto_ident _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_ _startpos_x_ _v _menhir_s _tok
  
  and _menhir_goto_ident : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState046 ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState095 ->
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState065 ->
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState131 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState127 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState117 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState112 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState109 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState105 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState051 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState054 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState056 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState097 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState093 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState089 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState087 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState085 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState083 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState081 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState079 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState077 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState075 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState073 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState071 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState069 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState067 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState063 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState061 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState057 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState027 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState029 ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState047 ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState031 ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState022 ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState008 ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState016 ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState004 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_129 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          let _menhir_stack = MenhirCell1_ident (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_ident (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | ASSIGN | END | EQEQ | GE | GT | LE | LT | MINUS | MINUSMINUS | NOTEQ | OR | PERCENT | PLUS | PLUSPLUS | SEMI | SLASH | STAR ->
          let (_endpos_x_, _startpos_x_, x) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_18 x in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_ _startpos_x_ _v _menhir_s _tok
      | COMMA | DECLARE ->
          let (_startpos_i_, i) = (_startpos, _v) in
          let _v = _menhir_action_45 i in
          _menhir_goto_ident_list _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos_i_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_061 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_ident -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell0_LPAR (_menhir_stack, _startpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState061
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState061
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState061
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState061
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState061
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState061
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState061
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState061
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState061
      | COMMA | RPAR ->
          let _v = _menhir_action_03 () in
          _menhir_run_091 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState061 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_052 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_14 _endpos__1_ _startpos__1_ in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState046 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState117 ->
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState112 ->
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState131 ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState127 ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState109 ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState051 ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState105 ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState054 ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState056 ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState057 ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState093 ->
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState089 ->
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState087 ->
          _menhir_run_088 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState085 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState083 ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState081 ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState079 ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState077 ->
          _menhir_run_078 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState075 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState073 ->
          _menhir_run_074 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState071 ->
          _menhir_run_072 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState069 ->
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState067 ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState063 ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState097 ->
          _menhir_run_062 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState061 ->
          _menhir_run_062 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_133 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | PLUSPLUS ->
          let _endpos_0 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__2_, _startpos_e_, e) = (_endpos_0, _startpos, _v) in
          let _v = _menhir_action_55 e in
          _menhir_goto_instr_simple _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__2_ _startpos_e_ _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | PERCENT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_073 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | NOTEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | MINUSMINUS ->
          let _endpos_1 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__2_, _startpos_e_, e) = (_endpos_1, _startpos, _v) in
          let _v = _menhir_action_56 e in
          _menhir_goto_instr_simple _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__2_ _startpos_e_ _v _menhir_s _tok
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | ASSIGN | COMMA ->
          let (_endpos_e_, _startpos_e_, e) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_37 e in
          _menhir_goto_expr_list _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos_e_ _v _menhir_s _tok
      | END | SEMI ->
          let (_endpos_e_, _startpos_e_, e) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_54 e in
          _menhir_goto_instr_simple _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos_e_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_063 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_STAR (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState063 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_053 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos_s_, _startpos_s_, s) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_13 _endpos_s_ _startpos_s_ s in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_s_ _startpos_s_ _v _menhir_s _tok
  
  and _menhir_run_054 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_NOT (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState054 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_055 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_16 _endpos__1_ _startpos__1_ in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_056 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_MINUS (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState056 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_057 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_LPAR (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState057 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_058 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos_n_, _startpos_n_, n) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_12 _endpos_n_ _startpos_n_ n in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_n_ _startpos_n_ _v _menhir_s _tok
  
  and _menhir_run_059 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
      let _v = _menhir_action_15 _endpos__1_ _startpos__1_ in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_067 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_SLASH (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState067 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_instr_simple : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let (_endpos_d_, _startpos_d_, d) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_47 _endpos_d_ _startpos_d_ d in
      _menhir_goto_instr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_instr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState046 ->
          _menhir_run_138 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_125 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_138 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_BEGIN as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let i = _v in
      let _v = _menhir_action_59 i in
      _menhir_goto_instrs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_instrs : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_BEGIN as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_instrs (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | SEMI ->
          let _menhir_s = MenhirState123 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VAR ->
              _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TRUE ->
              _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | RETURN ->
              _menhir_run_109 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NIL ->
              _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAR ->
              _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FOR ->
              _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FALSE ->
              _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | END ->
              let _ = _menhir_action_65 () in
              _menhir_goto_opt_semi _menhir_stack _menhir_lexbuf _menhir_lexer
          | _ ->
              _eRR ())
      | END ->
          let _ = _menhir_action_66 () in
          _menhir_goto_opt_semi _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_047 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_VAR (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState047 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_109 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _menhir_stack = MenhirCell1_RETURN (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState109 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | END | SEMI ->
          let _v = _menhir_action_81 () in
          _menhir_goto_return_list _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_return_list : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_RETURN -> _ -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_RETURN (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos_el_, el) = (_endpos, _v) in
      let _v = _menhir_action_53 _endpos_el_ _startpos__1_ el in
      _menhir_goto_instr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_112 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_IF (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState112 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_117 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_FOR (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState117 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BEGIN ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_046 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VAR ->
          let _menhir_stack = MenhirCell1_BEGIN (_menhir_stack, _menhir_s) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | TRUE ->
          let _menhir_stack = MenhirCell1_BEGIN (_menhir_stack, _menhir_s) in
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | STRING _v ->
          let _menhir_stack = MenhirCell1_BEGIN (_menhir_stack, _menhir_s) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState046
      | RETURN ->
          let _menhir_stack = MenhirCell1_BEGIN (_menhir_stack, _menhir_s) in
          _menhir_run_109 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | NOT ->
          let _menhir_stack = MenhirCell1_BEGIN (_menhir_stack, _menhir_s) in
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | NIL ->
          let _menhir_stack = MenhirCell1_BEGIN (_menhir_stack, _menhir_s) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | MINUS ->
          let _menhir_stack = MenhirCell1_BEGIN (_menhir_stack, _menhir_s) in
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | LPAR ->
          let _menhir_stack = MenhirCell1_BEGIN (_menhir_stack, _menhir_s) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | INT _v ->
          let _menhir_stack = MenhirCell1_BEGIN (_menhir_stack, _menhir_s) in
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState046
      | IF ->
          let _menhir_stack = MenhirCell1_BEGIN (_menhir_stack, _menhir_s) in
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | IDENT _v ->
          let _menhir_stack = MenhirCell1_BEGIN (_menhir_stack, _menhir_s) in
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState046
      | FOR ->
          let _menhir_stack = MenhirCell1_BEGIN (_menhir_stack, _menhir_s) in
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | FALSE ->
          let _menhir_stack = MenhirCell1_BEGIN (_menhir_stack, _menhir_s) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | END ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _endpos__2_ = _endpos in
          let _v = _menhir_action_01 () in
          _menhir_goto_bloc _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__2_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_bloc : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState045 ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState117 ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState118 ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState115 ->
          _menhir_run_116 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState113 ->
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_139 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_FUNC, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR, _menhir_box_prog) _menhir_cell1_opt_params _menhir_cell0_RPAR, _menhir_box_prog) _menhir_cell1_opt_type_ret -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | SEMI ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_opt_type_ret (_menhir_stack, _, ret) = _menhir_stack in
          let MenhirCell0_RPAR (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_opt_params (_menhir_stack, _, params) = _menhir_stack in
          let MenhirCell0_LPAR (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_ident (_menhir_stack, _, f, _, _) = _menhir_stack in
          let MenhirCell1_FUNC (_menhir_stack, _menhir_s) = _menhir_stack in
          let body = _v in
          let _v = _menhir_action_43 body f params ret in
          let _1 = _v in
          let _v = _menhir_action_08 _1 in
          _menhir_goto_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_decl : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState003 ->
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState026 ->
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState147 ->
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState143 ->
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_146 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let d = _v in
      let _v = _menhir_action_11 d in
      _menhir_goto_decls _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_decls : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState003 ->
          _menhir_run_147 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState026 ->
          _menhir_run_143 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_147 : type  ttv_stack. (ttv_stack _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TYPE ->
          let _menhir_stack = MenhirCell1_decls (_menhir_stack, _menhir_s, _v) in
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState147
      | FUNC ->
          let _menhir_stack = MenhirCell1_decls (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState147
      | EOF ->
          let MenhirCell0_IDENT (_menhir_stack, _main, _, _) = _menhir_stack in
          let ds = _v in
          let _v = _menhir_action_76 _main ds in
          _menhir_goto_prog _menhir_stack _v
      | _ ->
          _eRR ()
  
  and _menhir_run_027 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FUNC (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState027 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_143 : type  ttv_stack. ((ttv_stack _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_IMPORT _menhir_cell0_STRING as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TYPE ->
          let _menhir_stack = MenhirCell1_decls (_menhir_stack, _menhir_s, _v) in
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState143
      | FUNC ->
          let _menhir_stack = MenhirCell1_decls (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState143
      | EOF ->
          let MenhirCell0_STRING (_menhir_stack, _s, _, _) = _menhir_stack in
          let MenhirCell1_IMPORT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, _main, _, _) = _menhir_stack in
          let ds = _v in
          let _v = _menhir_action_77 _main _s ds in
          _menhir_goto_prog _menhir_stack _v
      | _ ->
          _eRR ()
  
  and _menhir_run_145 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_decls -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_decls (_menhir_stack, _menhir_s, ds) = _menhir_stack in
      let d = _v in
      let _v = _menhir_action_10 d ds in
      _menhir_goto_decls _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_120 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_FOR -> _ -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_FOR (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos_b_, b) = (_endpos, _v) in
      let _v = _menhir_action_50 _endpos_b_ _startpos__1_ b in
      _menhir_goto_instr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_119 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_FOR, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _, e, _, _) = _menhir_stack in
      let MenhirCell1_FOR (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos_b_, b) = (_endpos, _v) in
      let _v = _menhir_action_51 _endpos_b_ _startpos__1_ b e in
      _menhir_goto_instr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_116 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_bloc -> _ -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_bloc (_menhir_stack, _, b1, _) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, e, _, _) = _menhir_stack in
      let MenhirCell1_IF (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos_b2_, b2) = (_endpos, _v) in
      let _v = _menhir_action_49 _endpos_b2_ _startpos__1_ b1 b2 e in
      _menhir_goto_instr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_114 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | ELSE ->
          let _menhir_stack = MenhirCell1_bloc (_menhir_stack, _menhir_s, _v, _endpos) in
          let _menhir_s = MenhirState115 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | BEGIN ->
              _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | END | SEMI ->
          let MenhirCell1_expr (_menhir_stack, _, e, _, _) = _menhir_stack in
          let MenhirCell1_IF (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos_b1_, b1) = (_endpos, _v) in
          let _v = _menhir_action_48 _endpos_b1_ _startpos__1_ b1 e in
          _menhir_goto_instr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_opt_semi : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_BEGIN, _menhir_box_prog) _menhir_cell1_instrs -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_instrs (_menhir_stack, _, is) = _menhir_stack in
      let MenhirCell1_BEGIN (_menhir_stack, _menhir_s) = _menhir_stack in
      let _endpos__4_ = _endpos in
      let _v = _menhir_action_02 is in
      _menhir_goto_bloc _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__4_ _v _menhir_s _tok
  
  and _menhir_run_125 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_BEGIN, _menhir_box_prog) _menhir_cell1_instrs -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_instrs (_menhir_stack, _menhir_s, is) = _menhir_stack in
      let i = _v in
      let _v = _menhir_action_60 i is in
      _menhir_goto_instrs _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_069 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PLUS (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState069 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_071 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PERCENT (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState071 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_073 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_OR (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState073 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_075 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_NOTEQ (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState075 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_077 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_MINUS (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState077 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_079 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LT (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState079 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_081 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState081 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_083 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_GT (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState083 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_085 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_GE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState085 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_087 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_EQEQ (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState087 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_065 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_DOT (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState065 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_089 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_AND (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState089 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_expr_list : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState131 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState046 ->
          _menhir_run_130 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_130 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState127 ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState109 ->
          _menhir_run_111 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState051 ->
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_132 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr_list as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr_list (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer
      | END | SEMI ->
          let MenhirCell1_expr_list (_menhir_stack, _menhir_s, lhs, _startpos_lhs_, _) = _menhir_stack in
          let (_endpos_rhs_, rhs) = (_endpos, _v) in
          let _v = _menhir_action_57 lhs rhs in
          _menhir_goto_instr_simple _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_rhs_ _startpos_lhs_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_105 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_expr_list -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState105 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_130 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr_list (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ASSIGN ->
          let _menhir_s = MenhirState131 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NOT ->
              _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NIL ->
              _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAR ->
              _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_128 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_ident_list, _menhir_box_prog) _menhir_cell1_DECLARE as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr_list (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer
      | END | SEMI ->
          let MenhirCell1_DECLARE (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_ident_list (_menhir_stack, _menhir_s, ids, _startpos_ids_) = _menhir_stack in
          let (_endpos_es_, es) = (_endpos, _v) in
          let _v = _menhir_action_58 _endpos_es_ _startpos_ids_ es ids in
          _menhir_goto_instr_simple _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_es_ _startpos_ids_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_111 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_RETURN as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr_list (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer
      | END | SEMI ->
          let (_endpos_es_, es) = (_endpos, _v) in
          let _v = _menhir_action_82 es in
          _menhir_goto_return_list _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_es_ _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_104 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_VAR, _menhir_box_prog) _menhir_cell1_ident_list, _menhir_box_prog) _menhir_cell1_opt_var_type as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr_list (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer
      | END | SEMI ->
          let (_endpos_es_, es) = (_endpos, _v) in
          let _v = _menhir_action_71 es in
          _menhir_goto_opt_var_init _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_es_ _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_opt_var_init : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_VAR, _menhir_box_prog) _menhir_cell1_ident_list, _menhir_box_prog) _menhir_cell1_opt_var_type -> _ -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_opt_var_type (_menhir_stack, _, ty) = _menhir_stack in
      let MenhirCell1_ident_list (_menhir_stack, _, ids, _) = _menhir_stack in
      let MenhirCell1_VAR (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos_init_, init) = (_endpos, _v) in
      let _v = _menhir_action_52 _endpos_init_ _startpos__1_ ids init ty in
      _menhir_goto_instr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_118 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_FOR as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | SLASH ->
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | PLUS ->
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | PERCENT ->
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | OR ->
          _menhir_run_073 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | NOTEQ ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | MINUS ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | LT ->
          _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | LE ->
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | GT ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | GE ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | EQEQ ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | DOT ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | BEGIN ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | AND ->
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | _ ->
          _eRR ()
  
  and _menhir_run_113 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_IF as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | SLASH ->
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | PLUS ->
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | PERCENT ->
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | OR ->
          _menhir_run_073 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | NOTEQ ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | MINUS ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | LT ->
          _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | LE ->
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | GT ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | GE ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | EQEQ ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | DOT ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | BEGIN ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | AND ->
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | _ ->
          _eRR ()
  
  and _menhir_run_107 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | PERCENT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_073 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | NOTEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | COMMA | END | SEMI ->
          let (_endpos_e_, _startpos_e_, e) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_37 e in
          _menhir_goto_expr_list _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos_e_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_106 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr_list as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | PERCENT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_073 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | NOTEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | ASSIGN | COMMA | END | SEMI ->
          let MenhirCell1_expr_list (_menhir_stack, _menhir_s, el, _startpos_el_, _) = _menhir_stack in
          let (_endpos_e_, e) = (_endpos, _v) in
          let _v = _menhir_action_38 e el in
          _menhir_goto_expr_list _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos_el_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_103 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_NOT as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState103
      | AND | ASSIGN | BEGIN | COMMA | END | EQEQ | GE | GT | LE | LT | MINUS | MINUSMINUS | NOTEQ | OR | PERCENT | PLUS | PLUSPLUS | RPAR | SEMI | SLASH | STAR ->
          let MenhirCell1_NOT (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos_e_, e) = (_endpos, _v) in
          let _v = _menhir_action_22 _endpos_e_ _startpos__1_ e in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_102 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_MINUS as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState102
      | AND | ASSIGN | BEGIN | COMMA | END | EQEQ | GE | GT | LE | LT | MINUS | MINUSMINUS | NOTEQ | OR | PERCENT | PLUS | PLUSPLUS | RPAR | SEMI | SLASH | STAR ->
          let MenhirCell1_MINUS (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos_e_, e) = (_endpos, _v) in
          let _v = _menhir_action_23 _endpos_e_ _startpos__1_ e in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_100 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LPAR as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | RPAR ->
          let _endpos_0 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LPAR (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (e, _endpos__3_) = (_v, _endpos_0) in
          let _v = _menhir_action_17 e in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | PERCENT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_073 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | NOTEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | _ ->
          _eRR ()
  
  and _menhir_run_094 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR, _menhir_box_prog) _menhir_cell1_call_args as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | PERCENT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_073 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | NOTEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | COMMA | RPAR ->
          let MenhirCell1_call_args (_menhir_stack, _menhir_s, es) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_05 e es in
          _menhir_goto_call_args _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_call_args : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState097 ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState061 ->
          _menhir_run_091 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_098 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_ident, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAR ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_LPAR (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_ident (_menhir_stack, _, pr, _, _) = _menhir_stack in
          let MenhirCell1_ident (_menhir_stack, _menhir_s, fmt, _startpos_fmt_, _) = _menhir_stack in
          let (_endpos__6_, args) = (_endpos, _v) in
          let _v = _menhir_action_20 _endpos__6_ _startpos_fmt_ args fmt pr in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__6_ _startpos_fmt_ _v _menhir_s _tok
      | COMMA ->
          let _menhir_stack = MenhirCell1_call_args (_menhir_stack, _menhir_s, _v) in
          _menhir_run_093 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_093 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR, _menhir_box_prog) _menhir_cell1_call_args -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState093 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NOT ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NIL ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | COMMA | RPAR ->
          let MenhirCell1_call_args (_menhir_stack, _menhir_s, es) = _menhir_stack in
          let _v = _menhir_action_06 es in
          _menhir_goto_call_args _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_091 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAR ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_LPAR (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_ident (_menhir_stack, _menhir_s, f, _startpos_f_, _) = _menhir_stack in
          let (_endpos__4_, args) = (_endpos, _v) in
          let _v = _menhir_action_21 _endpos__4_ _startpos_f_ args f in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__4_ _startpos_f_ _v _menhir_s _tok
      | COMMA ->
          let _menhir_stack = MenhirCell1_call_args (_menhir_stack, _menhir_s, _v) in
          _menhir_run_093 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_090 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_AND as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState090
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState090
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState090
      | PERCENT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState090
      | NOTEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState090
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState090
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState090
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState090
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState090
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState090
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState090
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState090
      | AND | ASSIGN | BEGIN | COMMA | END | MINUSMINUS | OR | PLUSPLUS | RPAR | SEMI ->
          let MenhirCell1_AND (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
          let (_endpos_e2_, e2) = (_endpos, _v) in
          let _v = _menhir_action_35 _endpos_e2_ _startpos_e1_ e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_088 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_EQEQ as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
      | PERCENT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
      | AND | ASSIGN | BEGIN | COMMA | END | MINUSMINUS | OR | PLUSPLUS | RPAR | SEMI ->
          let MenhirCell1_EQEQ (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
          let (_endpos_e2_, e2) = (_endpos, _v) in
          let _v = _menhir_action_29 _endpos_e2_ _startpos_e1_ e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_086 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_GE as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState086
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState086
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState086
      | PERCENT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState086
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState086
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState086
      | AND | ASSIGN | BEGIN | COMMA | END | MINUSMINUS | OR | PLUSPLUS | RPAR | SEMI ->
          let MenhirCell1_GE (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
          let (_endpos_e2_, e2) = (_endpos, _v) in
          let _v = _menhir_action_34 _endpos_e2_ _startpos_e1_ e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_084 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_GT as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | PERCENT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | AND | ASSIGN | BEGIN | COMMA | END | MINUSMINUS | OR | PLUSPLUS | RPAR | SEMI ->
          let MenhirCell1_GT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
          let (_endpos_e2_, e2) = (_endpos, _v) in
          let _v = _menhir_action_33 _endpos_e2_ _startpos_e1_ e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_082 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_LE as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState082
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState082
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState082
      | PERCENT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState082
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState082
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState082
      | AND | ASSIGN | BEGIN | COMMA | END | MINUSMINUS | OR | PLUSPLUS | RPAR | SEMI ->
          let MenhirCell1_LE (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
          let (_endpos_e2_, e2) = (_endpos, _v) in
          let _v = _menhir_action_32 _endpos_e2_ _startpos_e1_ e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_080 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_LT as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | PERCENT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | AND | ASSIGN | BEGIN | COMMA | END | MINUSMINUS | OR | PLUSPLUS | RPAR | SEMI ->
          let MenhirCell1_LT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
          let (_endpos_e2_, e2) = (_endpos, _v) in
          let _v = _menhir_action_31 _endpos_e2_ _startpos_e1_ e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_078 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_MINUS as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState078
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState078
      | PERCENT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState078
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState078
      | AND | ASSIGN | BEGIN | COMMA | END | EQEQ | GE | GT | LE | LT | MINUS | MINUSMINUS | NOTEQ | OR | PLUS | PLUSPLUS | RPAR | SEMI ->
          let MenhirCell1_MINUS (_menhir_stack, _, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
          let (_endpos_e2_, e2) = (_endpos, _v) in
          let _v = _menhir_action_25 _endpos_e2_ _startpos_e1_ e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_076 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_NOTEQ as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState076
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState076
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState076
      | PERCENT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState076
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState076
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState076
      | AND | ASSIGN | BEGIN | COMMA | END | MINUSMINUS | OR | PLUSPLUS | RPAR | SEMI ->
          let MenhirCell1_NOTEQ (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
          let (_endpos_e2_, e2) = (_endpos, _v) in
          let _v = _menhir_action_30 _endpos_e2_ _startpos_e1_ e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_074 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_OR as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState074
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState074
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState074
      | PERCENT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState074
      | NOTEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState074
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState074
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState074
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState074
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState074
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState074
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState074
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState074
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState074
      | ASSIGN | BEGIN | COMMA | END | MINUSMINUS | OR | PLUSPLUS | RPAR | SEMI ->
          let MenhirCell1_OR (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
          let (_endpos_e2_, e2) = (_endpos, _v) in
          let _v = _menhir_action_36 _endpos_e2_ _startpos_e1_ e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_072 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_PERCENT as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState072
      | AND | ASSIGN | BEGIN | COMMA | END | EQEQ | GE | GT | LE | LT | MINUS | MINUSMINUS | NOTEQ | OR | PERCENT | PLUS | PLUSPLUS | RPAR | SEMI | SLASH | STAR ->
          let MenhirCell1_PERCENT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
          let (_endpos_e2_, e2) = (_endpos, _v) in
          let _v = _menhir_action_28 _endpos_e2_ _startpos_e1_ e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_070 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_PLUS as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState070
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState070
      | PERCENT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState070
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState070
      | AND | ASSIGN | BEGIN | COMMA | END | EQEQ | GE | GT | LE | LT | MINUS | MINUSMINUS | NOTEQ | OR | PLUS | PLUSPLUS | RPAR | SEMI ->
          let MenhirCell1_PLUS (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
          let (_endpos_e2_, e2) = (_endpos, _v) in
          let _v = _menhir_action_24 _endpos_e2_ _startpos_e1_ e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_068 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_SLASH as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState068
      | AND | ASSIGN | BEGIN | COMMA | END | EQEQ | GE | GT | LE | LT | MINUS | MINUSMINUS | NOTEQ | OR | PERCENT | PLUS | PLUSPLUS | RPAR | SEMI | SLASH | STAR ->
          let MenhirCell1_SLASH (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
          let (_endpos_e2_, e2) = (_endpos, _v) in
          let _v = _menhir_action_27 _endpos_e2_ _startpos_e1_ e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_064 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_STAR as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState064
      | AND | ASSIGN | BEGIN | COMMA | END | EQEQ | GE | GT | LE | LT | MINUS | MINUSMINUS | NOTEQ | OR | PERCENT | PLUS | PLUSPLUS | RPAR | SEMI | SLASH | STAR ->
          let MenhirCell1_STAR (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
          let (_endpos_e2_, e2) = (_endpos, _v) in
          let _v = _menhir_action_26 _endpos_e2_ _startpos_e1_ e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_062 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
      | PERCENT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_073 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
      | NOTEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
      | LE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
      | GE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
      | COMMA | RPAR ->
          let e = _v in
          let _v = _menhir_action_04 e in
          _menhir_goto_call_args _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_095 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_ident -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState095 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_ident_list : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState046 ->
          _menhir_run_126 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_126 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState047 ->
          _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState029 ->
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState031 ->
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState022 ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState008 ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_126 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ident_list (_menhir_stack, _menhir_s, _v, _startpos) in
      match (_tok : MenhirBasics.token) with
      | DECLARE ->
          let _menhir_stack = MenhirCell1_DECLARE (_menhir_stack, MenhirState126) in
          let _menhir_s = MenhirState127 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NOT ->
              _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NIL ->
              _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAR ->
              _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | COMMA ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState126
      | _ ->
          _eRR ()
  
  and _menhir_run_016 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ident_list as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_COMMA (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState016 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_048 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_VAR as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ident_list (_menhir_stack, _menhir_s, _v, _startpos) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | IDENT _v_0 ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState048
      | COMMA ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | ASSIGN | END | SEMI ->
          let _menhir_s = MenhirState048 in
          let _v = _menhir_action_72 () in
          _menhir_goto_opt_var_type _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_013 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let s = _v in
          let _v = _menhir_action_85 s in
          _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_typ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState048 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok
      | MenhirState037 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState040 ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState038 ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState033 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState012 ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_049 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_VAR, _menhir_box_prog) _menhir_cell1_ident_list as 'stack) -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok ->
      let t = _v in
      let _v = _menhir_action_73 t in
      _menhir_goto_opt_var_type _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok
  
  and _menhir_goto_opt_var_type : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_VAR, _menhir_box_prog) _menhir_cell1_ident_list as 'stack) -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_opt_var_type (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | ASSIGN ->
          let _menhir_s = MenhirState051 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NOT ->
              _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NIL ->
              _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAR ->
              _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | END | SEMI ->
          let _v = _menhir_action_70 () in
          _menhir_goto_opt_var_init _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_044 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_FUNC, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR, _menhir_box_prog) _menhir_cell1_opt_params _menhir_cell0_RPAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let t = _v in
      let _v = _menhir_action_68 t in
      _menhir_goto_opt_type_ret _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_opt_type_ret : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_FUNC, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR, _menhir_box_prog) _menhir_cell1_opt_params _menhir_cell0_RPAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_opt_type_ret (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | BEGIN ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState045
      | _ ->
          _eRR ()
  
  and _menhir_run_039 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STAR ->
              let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState040
          | IDENT _v_0 ->
              let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState040
          | RPAR ->
              let t = _v in
              let _v = _menhir_action_80 t in
              _menhir_goto_ret_type_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | RPAR ->
          let t = _v in
          let _v = _menhir_action_78 t in
          _menhir_goto_ret_type_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_015 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let s = _v in
      let _v = _menhir_action_84 s in
      _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok
  
  and _menhir_goto_ret_type_list : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState038 ->
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState040 ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_042 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_FUNC, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR, _menhir_box_prog) _menhir_cell1_opt_params _menhir_cell0_RPAR, _menhir_box_prog) _menhir_cell1_LPAR -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_LPAR (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let ts = _v in
      let _v = _menhir_action_69 ts in
      _menhir_goto_opt_type_ret _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_041 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_typ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_typ (_menhir_stack, _menhir_s, t) = _menhir_stack in
      let rest = _v in
      let _v = _menhir_action_79 rest t in
      _menhir_goto_ret_type_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_034 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_ident_list -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_ident_list (_menhir_stack, _menhir_s, ids, _) = _menhir_stack in
      let ty = _v in
      let _v = _menhir_action_86 ids ty in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_vars_decl (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState031 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | RPAR ->
          let v = _v in
          let _v = _menhir_action_74 v in
          _menhir_goto_param_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_param_list : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState029 ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState031 ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_035 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_FUNC, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let ps = _v in
      let _v = _menhir_action_64 ps in
      _menhir_goto_opt_params _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_opt_params : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_FUNC, _menhir_box_prog) _menhir_cell1_ident _menhir_cell0_LPAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_opt_params (_menhir_stack, _menhir_s, _v) in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _menhir_stack = MenhirCell0_RPAR (_menhir_stack, _endpos) in
      let _menhir_s = MenhirState037 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAR ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _menhir_stack = MenhirCell1_LPAR (_menhir_stack, _menhir_s, _startpos) in
          let _menhir_s = MenhirState038 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STAR ->
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | BEGIN ->
          let _v = _menhir_action_67 () in
          _menhir_goto_opt_type_ret _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_032 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_vars_decl -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_vars_decl (_menhir_stack, _menhir_s, v) = _menhir_stack in
      let rest = _v in
      let _v = _menhir_action_75 rest v in
      _menhir_goto_param_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_018 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_ident_list -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_ident_list (_menhir_stack, _menhir_s, ids, _) = _menhir_stack in
      let ty = _v in
      let _v = _menhir_action_39 ids ty in
      match (_tok : MenhirBasics.token) with
      | SEMI ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_0 ->
              let _menhir_stack = MenhirCell1_field_decl (_menhir_stack, _menhir_s, _v) in
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState022
          | END ->
              let fd = _v in
              let _v = _menhir_action_40 fd in
              _menhir_goto_field_decls _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | END ->
          let fd = _v in
          let _v = _menhir_action_41 fd in
          _menhir_goto_field_decls _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_field_decls : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState022 ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState008 ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_023 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_field_decl -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_field_decl (_menhir_stack, _menhir_s, fd) = _menhir_stack in
      let fds = _v in
      let _v = _menhir_action_42 fd fds in
      _menhir_goto_field_decls _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_020 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_TYPE, _menhir_box_prog) _menhir_cell1_ident -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let l = _v in
      let _v = _menhir_action_62 l in
      _menhir_goto_opt_field_decls _menhir_stack _menhir_lexbuf _menhir_lexer _v
  
  and _menhir_goto_opt_field_decls : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_TYPE, _menhir_box_prog) _menhir_cell1_ident -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | SEMI ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_ident (_menhir_stack, _, id, _, _) = _menhir_stack in
          let MenhirCell1_TYPE (_menhir_stack, _menhir_s) = _menhir_stack in
          let fs = _v in
          let _v = _menhir_action_83 fs id in
          let _1 = _v in
          let _v = _menhir_action_07 _1 in
          _menhir_goto_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_033 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ident_list (_menhir_stack, _menhir_s, _v, _startpos) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState033
      | IDENT _v_0 ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState033
      | COMMA ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState033
      | _ ->
          _eRR ()
  
  and _menhir_run_012 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ident_list (_menhir_stack, _menhir_s, _v, _startpos) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState012
      | IDENT _v_0 ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState012
      | COMMA ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState012
      | _ ->
          _eRR ()
  
  and _menhir_run_096 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ident as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ident (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          let _startpos_0 = _menhir_lexbuf.Lexing.lex_start_p in
          let _menhir_stack = MenhirCell0_LPAR (_menhir_stack, _startpos_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState097
          | STRING _v_1 ->
              _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState097
          | NOT ->
              _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState097
          | NIL ->
              _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState097
          | MINUS ->
              _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState097
          | LPAR ->
              _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState097
          | INT _v_2 ->
              _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState097
          | IDENT _v_3 ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState097
          | FALSE ->
              _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState097
          | COMMA | RPAR ->
              let _v_4 = _menhir_action_03 () in
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState097 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_066 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_DOT -> _ -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_DOT (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _menhir_s, e, _startpos_e_, _) = _menhir_stack in
      let (_endpos_f_, f) = (_endpos, _v) in
      let _v = _menhir_action_19 _endpos_f_ _startpos_e_ e f in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_f_ _startpos_e_ _v _menhir_s _tok
  
  and _menhir_run_060 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          let _menhir_stack = MenhirCell1_ident (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_ident (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | ASSIGN | BEGIN | COMMA | END | EQEQ | GE | GT | LE | LT | MINUS | MINUSMINUS | NOTEQ | OR | PERCENT | PLUS | PLUSPLUS | RPAR | SEMI | SLASH | STAR ->
          let (_endpos_x_, _startpos_x_, x) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_18 x in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_ _startpos_x_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_028 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_FUNC as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ident (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _menhir_stack = MenhirCell0_LPAR (_menhir_stack, _startpos) in
          let _menhir_s = MenhirState029 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | RPAR ->
              let _v = _menhir_action_63 () in
              _menhir_goto_opt_params _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_019 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let (_startpos_i_, i) = (_startpos, _v) in
      let _v = _menhir_action_45 i in
      _menhir_goto_ident_list _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos_i_ _v _menhir_s _tok
  
  and _menhir_run_017 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_ident_list, _menhir_box_prog) _menhir_cell1_COMMA -> _ -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_COMMA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_ident_list (_menhir_stack, _menhir_s, il, _startpos_il_) = _menhir_stack in
      let i = _v in
      let _v = _menhir_action_46 i il in
      _menhir_goto_ident_list _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos_il_ _v _menhir_s _tok
  
  and _menhir_run_006 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_TYPE as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ident (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      match (_tok : MenhirBasics.token) with
      | STRUCT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | BEGIN ->
              let _menhir_s = MenhirState008 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v ->
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | END ->
                  let _v = _menhir_action_61 () in
                  _menhir_goto_opt_field_decls _menhir_stack _menhir_lexbuf _menhir_lexer _v
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  let _menhir_run_000 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | PACKAGE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
              let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v, _startpos, _endpos) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | SEMI ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | TYPE ->
                      _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState003
                  | IMPORT ->
                      let _menhir_stack = MenhirCell1_IMPORT (_menhir_stack, MenhirState003) in
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | STRING _v_0 ->
                          let _startpos_1 = _menhir_lexbuf.Lexing.lex_start_p in
                          let _endpos_2 = _menhir_lexbuf.Lexing.lex_curr_p in
                          let _menhir_stack = MenhirCell0_STRING (_menhir_stack, _v_0, _startpos_1, _endpos_2) in
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          (match (_tok : MenhirBasics.token) with
                          | SEMI ->
                              let _tok = _menhir_lexer _menhir_lexbuf in
                              (match (_tok : MenhirBasics.token) with
                              | TYPE ->
                                  _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState026
                              | FUNC ->
                                  _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState026
                              | EOF ->
                                  let _v_3 = _menhir_action_09 () in
                                  _menhir_run_143 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState026 _tok
                              | _ ->
                                  _eRR ())
                          | _ ->
                              _eRR ())
                      | _ ->
                          _eRR ())
                  | FUNC ->
                      _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState003
                  | EOF ->
                      let _v_4 = _menhir_action_09 () in
                      _menhir_run_147 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState003 _tok
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
end

let prog =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_prog v = _menhir_run_000 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
