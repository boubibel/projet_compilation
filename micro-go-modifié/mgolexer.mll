{
  open Lexing
  open Mgoparser

  let split_comma s = List.map String.trim (String.split_on_char ',' s)

  exception Error of string

  let keyword_or_ident =
    let h = Hashtbl.create 17 in
    List.iter (fun (s, k) -> Hashtbl.add h s k)
      [
        "package", PACKAGE;
        "import",  IMPORT;
        "type",    TYPE;
        "struct",  STRUCT;

        "func",    FUNC;
        "var",     VAR;
        "if",      IF;
        "else",    ELSE;
        "for",     FOR;
        "return",  RETURN;
        "true",    TRUE;
        "false",   FALSE;
        "nil",     NIL;
      ];
    fun s ->
      try Hashtbl.find h s
      with Not_found -> IDENT s

  let controle_entier s =
    try
      let n = Int64.of_string s in
      if n < 0L || n > Int64.max_int then
        raise (Error ("entier hors limites : " ^ s))
      else
        n
    with Failure _ ->
      raise (Error ("entier invalide : " ^ s))

  let str_buf = Buffer.create 128

  let dernier_pv = ref false

  let dernier_token t =
    dernier_pv :=
      (match t with
       | IDENT _ | IDS_DECL _ | INT _ | STRING _ | TRUE | FALSE | NIL
       | RETURN | PLUSPLUS | MINUSMINUS | RPAR | END -> true
       | _ -> false);
    t
}

(* Déclarations de regex ocamllex *)
let digit = ['0'-'9']
let hexa  = ['0'-'9''a'-'f''A'-'F']
let alpha = ['a'-'z''A'-'Z''_']
let ident = alpha (alpha | digit)*

rule token = parse
 
  | [' ' '\t' '\r']       { token lexbuf }
  | '\n'                  { new_line lexbuf;
                             if !dernier_pv then
                               (dernier_pv := false; SEMI)
                             else
                               token lexbuf }


  | "/*"                  { commentaire lexbuf }
  | "//"                  { ligne_commentaire lexbuf }


  (* Déclaration de plusieurs identifiants séparés par des virgules, suivie de ":=" *)
  | ident ([' ' '\t']* ',' [' ' '\t']* ident)* [' ' '\t']* ":="
      {
        let lex = Lexing.lexeme lexbuf in
        let without_decl =
          let n = String.length lex in
          String.sub lex 0 (n - 2)
        in
        let parts = split_comma without_decl in
        dernier_token (IDS_DECL parts)
      }

  | ident as id           { dernier_token (keyword_or_ident id) }


  | "0x" hexa+ as s
  | "0X" hexa+ as s
  | digit+ as s           { dernier_token (INT (controle_entier s)) }

  | '"'                   { Buffer.clear str_buf; string lexbuf }

  | "&&"                  { dernier_token AND }
  | "||"                  { dernier_token OR }
  | "=="                  { dernier_token EQEQ }
  | "!="                  { dernier_token NOTEQ }
  | "<="                  { dernier_token LE }
  | ">="                  { dernier_token GE }
  | "++"                  { dernier_token PLUSPLUS }
  | "--"                  { dernier_token MINUSMINUS }

  | '='                   { dernier_token ASSIGN }
  | '<'                   { dernier_token LT }
  | '>'                   { dernier_token GT }
  | '+'                   { dernier_token PLUS }
  | '-'                   { dernier_token MINUS }
  | '*'                   { dernier_token STAR }
  | '/'                   { dernier_token SLASH }
  | '%'                   { dernier_token PERCENT }
  | '!'                   { dernier_token NOT }

  | '('                   { dernier_token LPAR }
  | ')'                   { dernier_token RPAR }
  | '{'                   { dernier_token BEGIN }
  | '}'                   { dernier_token END }
  | ';'                   { dernier_pv := false; SEMI }
  | ','                   { dernier_token COMMA }
  | '.'                   { dernier_token DOT }
  | eof                   { dernier_token EOF }
  | _                     { raise (Error ("caractère inconnu : " ^ Lexing.lexeme lexbuf)) }

and commentaire = parse
  | "*/"                  { token lexbuf }
  | '\n'                  { new_line lexbuf;
                            if !dernier_pv then
                              (dernier_pv := false; SEMI)
                            else
                              commentaire lexbuf }
  | eof                   { raise (Error "commentaire non terminé") }
  | _                     { commentaire lexbuf }

and ligne_commentaire = parse
  | '\n'                  { new_line lexbuf;
                            if !dernier_pv then
                              (dernier_pv := false; SEMI)
                            else
                              token lexbuf }
  | eof                   { EOF }
  | _                     { ligne_commentaire lexbuf }

and string = parse
  | '"'                   { let s = Buffer.contents str_buf in dernier_token (STRING s) }
  | "\\n"                 { Buffer.add_char str_buf '\n'; string lexbuf }
  | "\\t"                 { Buffer.add_char str_buf '\t'; string lexbuf }
  | "\\\""                { Buffer.add_char str_buf '\"'; string lexbuf }
  | "\\\\"                { Buffer.add_char str_buf '\\'; string lexbuf }

  | '\n'                  { raise (Error "chaîne non terminé") }
  | eof                   { raise (Error "chaîne non terminé") }

  | _                     { Buffer.add_string str_buf (Lexing.lexeme lexbuf);
                            string lexbuf }

