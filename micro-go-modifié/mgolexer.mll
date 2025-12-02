{
  open Lexing
  open Mgoparser

  let split_comma s = List.map String.trim (String.split_on_char ',' s)

  exception Error of string

  (* Table des mots-clés : si l’identifiant lut est dans la table,
     on renvoie le token correspondant, sinon un IDENT s. *)
  let keyword_or_ident =
    let h = Hashtbl.create 17 in
    List.iter (fun (s, k) -> Hashtbl.add h s k)
      [
        "package", PACKAGE;
        "import",  IMPORT;
        "type",    TYPE;
        "struct",  STRUCT;

        (* Mots-clés supplémentaires de Micro Go *)
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

  (* Conversion et contrôle de portée des entiers.
     On ne traite que les entiers positifs, la négation se fait au niveau syntaxique
     via l’opérateur unaire -.
     Le sujet impose : entre -2^63 et 2^63-1, donc ici 0..2^63-1. *)
  let parse_int_literal s =
    try
      let n = Int64.of_string s in
      if n < 0L || n > Int64.max_int then
        raise (Error ("integer literal out of range: " ^ s))
      else
        n
    with Failure _ ->
      raise (Error ("invalid integer literal: " ^ s))

  (* Buffer utilisé pour construire les chaînes de caractères *)
  let str_buf = Buffer.create 128
}

(* Déclarations de regex ocamllex *)
let digit = ['0'-'9']
let hexa  = ['0'-'9''a'-'f''A'-'F']
let alpha = ['a'-'z''A'-'Z''_']
let ident = alpha (alpha | digit)*

rule token = parse
  (* Blancs *)
  | [' ' '\t' '\r']       { token lexbuf }
  | '\n'                  { new_line lexbuf; token lexbuf }

  (* Commentaires *)
  | "/*"                  { comment lexbuf; token lexbuf }
  | "//"                  { line_comment lexbuf; token lexbuf }

  (* Identificateurs / mots-clés *)
  (* Special-case: comma-separated identifier list followed by ':=' -> emit IDS_DECL (string list) *)
  | ident ([' ' '\t']* ',' [' ' '\t']* ident)* [' ' '\t']* ":="
      {
        (* s contains the whole lexeme ending with ':='; extract identifiers *)
        let lex = Lexing.lexeme lexbuf in
        (* remove trailing ':=' and split by commas *)
        let without_decl =
          let n = String.length lex in
          String.sub lex 0 (n - 2)
        in
        let parts = split_comma without_decl in
        IDS_DECL parts
      }

  | ident as id           { keyword_or_ident id }

  (* Constantes entières : décimal ou hexadécimal (0x / 0X) *)
  | "0x" hexa+ as s
  | "0X" hexa+ as s
  | digit+ as s           { INT (parse_int_literal s) }

  (* Constantes chaînes : on lit le  ouvrant, puis on passe à la règle string *)
  | '"'                   { Buffer.clear str_buf; string lexbuf }

  (* Opérateurs et ponctuation multi-caractères – à mettre avant les simples ! *)
  | "&&"                  { AND }
  | "||"                  { OR }
  | "=="                  { EQEQ }
  | "!="                  { NOTEQ }
  | "<="                  { LE }
  | ">="                  { GE }
  | "++"                  { PLUSPLUS }
  | "--"                  { MINUSMINUS }
  (* ":=" is handled by the IDS_DECL rule above; no DECLARE token needed *)

  (* Opérateurs et ponctuation simples *)
  | '='                   { ASSIGN }
  | '<'                   { LT }
  | '>'                   { GT }
  | '+'                   { PLUS }
  | '-'                   { MINUS }
  | '*'                   { STAR }
  | '/'                   { SLASH }
  | '%'                   { PERCENT }
  | '!'                   { NOT }


  | '('                   { LPAR }
  | ')'                   { RPAR }
  | '{'                   { BEGIN }
  | '}'                   { END }
  | ';'                   { SEMI }
  | ','                   { COMMA }
  | '.'                   { DOT }

  (* Fin de fichier *)
  | eof                   { EOF }

  (* Caractère inconnu *)
  | _                     { raise (Error ("unknown character: " ^ Lexing.lexeme lexbuf)) }

(* Commentaire multi-ligne C-like : /* ... */  *)
and comment = parse
  | "*/"                  { () }
  | '\n'                  { new_line lexbuf; comment lexbuf }
  | eof                   { raise (Error "unterminated comment") }
  | _                     { comment lexbuf }

(* Commentaire ligne : // ... \n *)
and line_comment = parse
  | '\n'                  { new_line lexbuf }
  | eof                   { () }
  | _                     { line_comment lexbuf }

(* Lecture d’une constante chaîne de caractères.
   On accepte les échappements : \n, \t, \, \\ comme dans le sujet. *)
and string = parse
  | '"'                   { let s = Buffer.contents str_buf in
                            STRING s }
  | "\\n"                 { Buffer.add_char str_buf '\n'; string lexbuf }
  | "\\t"                 { Buffer.add_char str_buf '\t'; string lexbuf }
  | "\\\""                { Buffer.add_char str_buf '\"'; string lexbuf }
  | "\\\\"                { Buffer.add_char str_buf '\\'; string lexbuf }

  | '\n'                  { raise (Error "unterminated string literal") }
  | eof                   { raise (Error "unterminated string literal") }

  (* Tout autre caractère « normal » (ASCII 32..126 hors guillemets et \) *)
  | _                     { Buffer.add_string str_buf (Lexing.lexeme lexbuf);
                            string lexbuf }
