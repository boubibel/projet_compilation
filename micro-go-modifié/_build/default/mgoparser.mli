
(* The type of tokens. *)

type token = 
  | VAR
  | TYPE
  | TRUE
  | STRUCT
  | STRING of (string)
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
  | INT of (Int64.t)
  | IMPORT
  | IF
  | IDENT of (string)
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

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Mgoast.program)
