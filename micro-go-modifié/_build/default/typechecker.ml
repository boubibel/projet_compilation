open Mgoast

(* Exceptions de typage *)
exception Error of Mgoast.location * string

let error loc msg = raise (Error (loc, msg))

let type_error loc ty_actual ty_expected =
  error loc
    (Printf.sprintf "attendu %s, obtenu %s"
       (typ_to_string ty_expected)
       (typ_to_string ty_actual))

(*------------------------------------------------------------------*)
(* Environnements                                                   *)
(*------------------------------------------------------------------*)

module SMap = Map.Make(String)

(* info sur une structure : map champ -> type *)
type struct_info = typ SMap.t
(* env des structures : map nom_struct -> struct_info *)
type struct_env = struct_info SMap.t

(* info sur une fonction : types des paramètres, types de retour *)
type func_sig = {
  params  : typ list;
  results : typ list;
}

(* env des fonctions : map nom_f -> signature *)
type func_env = func_sig SMap.t

(* env des variables : pile de maps pour gérer les scopes (top = head) *)
type var_env = typ SMap.t

(* environnement de typage global/local *)
type tenv = {
  structs : struct_env;
  funcs   : func_env;
  vars    : var_env list; (* pile de scopes, head = current scope *)
}

let dummy_loc : location = (Lexing.dummy_pos, Lexing.dummy_pos)

(* utilitaires sur var_env : on utilise le nom (string) des identificateurs *)
let add_var loc (x : ident) ty (env : tenv) : tenv =
  if x.id = "_" then env
  else
    match env.vars with
    | [] ->
        let top = SMap.add x.id ty SMap.empty in
        { env with vars = top :: [] }
    | top :: rest ->
        if SMap.mem x.id top then
          error loc (Printf.sprintf "variable %s déjà définie" x.id)
        else
          let top' = SMap.add x.id ty top in
          { env with vars = top' :: rest }

let find_var loc (x : ident) (env : tenv) : typ =
  let rec find_in_scopes = function
    | [] -> raise Not_found
    | top :: rest ->
        try SMap.find x.id top
        with Not_found -> find_in_scopes rest
  in
  try find_in_scopes env.vars
  with Not_found ->
    error loc (Printf.sprintf "unbound variable %s" x.id)

let find_struct loc (sname : string) (env : tenv) : struct_info =
  try SMap.find sname env.structs
  with Not_found ->
    error loc (Printf.sprintf "unknown struct %s" sname)

let find_field loc (sname : string) (fname : string) (env : tenv) : typ =
  let sinfo = find_struct loc sname env in
  try SMap.find fname sinfo
  with Not_found ->
    error loc
      (Printf.sprintf "unknown field %s in struct %s" fname sname)

let find_func loc (fname : string) (env : tenv) : func_sig =
  try SMap.find fname env.funcs
  with Not_found ->
    error loc (Printf.sprintf "unknown function %s" fname)

(*------------------------------------------------------------------*)
(* Vérification bonne formation des types                           *)
(*------------------------------------------------------------------*)

let check_type_bf loc (env : tenv) (t : typ) =
  match t with
  | TInt | TBool | TString -> ()
  | TStruct s ->
      if not (SMap.mem s env.structs) then
        error loc (Printf.sprintf "unknown struct %s" s)

(*------------------------------------------------------------------*)
(* Typage des expressions                                           *)
(*------------------------------------------------------------------*)

let rec type_expr (env : tenv) (e : expr) : typ =
  let loc = e.eloc in
  match e.edesc with
  | Int _ ->
      TInt
  | Bool _ ->
      TBool
  | String _ ->
      TString
  | Nil ->
      (* on ne donne pas de type à nil ici : il sera contrôlé dans les contextes
         où il apparaît (assignation, comparaison, etc.) *)
      error loc "impossible d'inférer le type de nil ici"
  | Var x ->
      if x.id = "_" then
        error loc "_ cannot appear in expressions";
      find_var loc x env
  | Dot (e1, f) ->
      let t = type_expr env e1 in
      begin match t with
      | TStruct sname ->
          find_field loc sname f.id env
      | _ ->
          error loc "field access on non-struct value"
      end
  | New sname ->
      (* new(S) : type = *S = TStruct sname *)
      if not (SMap.mem sname env.structs) then
        error loc (Printf.sprintf "unknown struct %s" sname);
      TStruct sname
  | Unop (op, e1) ->
      let t1 = type_expr env e1 in
      begin match op, t1 with
      | Opp, TInt -> TInt
      | Not, TBool -> TBool
      | Opp, _ ->
          type_error loc t1 TInt
      | Not, _ ->
          type_error loc t1 TBool
      end
  | Binop (op, e1, e2) ->
      begin match op with
      | Eq | Neq ->
          (* Gérer les comparaisons avec nil spécialement : inférer le type depuis l'autre opérande *)
          begin match e1.edesc, e2.edesc with
          | Nil, Nil ->
              error loc "comparing nil with nil is not allowed"
          | Nil, _ ->
              let _ = type_expr env e2 in
              (* nil prend le type de l'autre opérande *)
              TBool
          | _, Nil ->
              let _ = type_expr env e1 in
              (* nil prend le type de l'autre opérande *)
              TBool
          | _ ->
              let t1 = type_expr env e1 in
              let t2 = type_expr env e2 in
              if t1 <> t2 then
                type_error loc t2 t1;
              TBool
          end
      | Lt | Le | Gt | Ge ->
          let t1 = type_expr env e1 in
          let t2 = type_expr env e2 in
          if t1 <> TInt || t2 <> TInt then
            error loc "comparison requires int operands";
          TBool
      | Add | Sub | Mul | Div | Rem ->
          let t1 = type_expr env e1 in
          let t2 = type_expr env e2 in
          if t1 <> TInt || t2 <> TInt then
            error loc "arithmetic operator requires ints";
          TInt
      | And | Or ->
          let t1 = type_expr env e1 in
          let t2 = type_expr env e2 in
          if t1 <> TBool || t2 <> TBool then
            error loc "logical operator requires bool operands";
          TBool
      end
  | Call (f, args) ->
      let fsig = find_func loc f.id env in
      let nparams = List.length fsig.params in
      let nargs   = List.length args in
      if nparams <> nargs then
        error loc
          (Printf.sprintf
             "function %s expects %d args, got %d"
             f.id nparams nargs);
      List.iter2
        (fun a ty_exp ->
           let ty_a = type_expr env a in
           if ty_a <> ty_exp then
             type_error a.eloc ty_a ty_exp)
        args fsig.params;
      begin match fsig.results with
      | [t] -> t
      | [] ->
          error loc
            (Printf.sprintf
               "function %s returns no value; cannot use in expression"
               f.id)
      | _ ->
          error loc
            "fonction retourne plusieurs valeurs ; ne peut pas être utilisée comme expression unique"
      end
  | Print es ->
      (* Cas spécial : autoriser un Call qui retourne plusieurs valeurs à apparaître comme
         argument de Print : on vérifie les types des arguments de l'appel contre la
         signature de fonction mais on n'exige pas que la fonction retourne une
         seule valeur. Pour les autres formes d'expression, on revient à la
         vérification de type normale. *)
      List.iter
        (fun e ->
           match e.edesc with
           | Call (f, args) ->
               let fsig = find_func e.eloc f.id env in
               let nparams = List.length fsig.params in
               let nargs = List.length args in
               if nparams <> nargs then
                 error e.eloc
                   (Printf.sprintf
                      "function %s expects %d args, got %d"
                      f.id nparams nargs);
               List.iter2
                 (fun a ty_exp ->
                    let ty_a = type_expr env a in
                    if ty_a <> ty_exp then
                      type_error a.eloc ty_a ty_exp)
                 args fsig.params
           | _ -> ignore (type_expr env e))
        es;
      TInt
  (* Note : impression gérée ci-dessus ; pas de cas Print supplémentaire nécessaire ici. *)
      
(*------------------------------------------------------------------*)
(* Valeurs gauches Γ ⊢l e : τ                                       *)
(*------------------------------------------------------------------*)

let type_lvalue (env : tenv) (e : expr) : typ =
  let loc = e.eloc in
  match e.edesc with
  | Var x ->
      if x.id = "_" then
        error loc "_ cannot appear on left-hand side";
      find_var loc x env
  | Dot (e1, f) ->
      let t = type_expr env e1 in
      begin match t with
      | TStruct sname ->
          find_field loc sname f.id env
      | _ ->
          error loc "field assignment on non-struct value"
      end
  | _ ->
      error loc "not a left value"

(*------------------------------------------------------------------*)
(* Typage des instructions                                          *)
(*------------------------------------------------------------------*)

(* On fait retourner à check_instr / check_seq un environnement mis à jour,
   pour prendre en compte les déclarations de variables (Vars). *)

let rec check_seq (env : tenv) (ret : typ list) (s : seq) : tenv =
  match s with
  | [] -> env
  | i :: rest ->
      let env' = check_instr env ret i in
      check_seq env' ret rest

and check_instr (env : tenv) (ret : typ list) (i : instr) : tenv =
  let loc = i.iloc in
  match i.idesc with
  | Expr e ->
      ignore (type_expr env e);
      env
  | Inc e
  | Dec e ->
      let t = type_lvalue env e in
      if t <> TInt then type_error e.eloc t TInt;
      env
  | Set (lhs, rhs) ->
      let tl = List.map (type_lvalue env) lhs in
      let tr =
        match rhs with
        | [] -> error loc "empty right-hand side in assignment"
        | _ when List.length rhs = List.length tl ->
            List.map (type_expr env) rhs
        | [e] ->
            (* expression unique à droite : peut être un appel retournant
               plusieurs valeurs, auquel cas utiliser les types de résultat de la fonction *)
            begin match e.edesc with
            | Call (f, args) ->
                let fsig = find_func e.eloc f.id env in
                let nparams = List.length fsig.params in
                let nargs = List.length args in
                if nparams <> nargs then
                  error e.eloc
                    (Printf.sprintf
                       "function %s expects %d args, got %d"
                       f.id nparams nargs);
                List.iter2
                  (fun a ty_exp ->
                     let ty_a = type_expr env a in
                     if ty_a <> ty_exp then
                       type_error a.eloc ty_a ty_exp)
                  args fsig.params;
                fsig.results
            | _ ->
                List.map (type_expr env) rhs
            end
        | _ -> error loc "nombre de valeurs incorrect dans l'assignation"
      in
      if List.length tl <> List.length tr then
        error loc "nombre de valeurs incorrect dans l'assignation";
      List.iter2
        (fun ty_l ty_r ->
           if ty_l <> ty_r then
             error loc
               (Printf.sprintf "incompatible assignment: %s := %s"
                  (typ_to_string ty_l) (typ_to_string ty_r)))
        tl tr;
      env
  | If (e, b1, b2) ->
      let t = type_expr env e in
      if t <> TBool then type_error e.eloc t TBool;
      let env_branch = { env with vars = SMap.empty :: env.vars } in
      ignore (check_seq env_branch ret b1);
      let env_branch2 = { env with vars = SMap.empty :: env.vars } in
      ignore (check_seq env_branch2 ret b2);
      env
  | For (e, b) ->
      let t = type_expr env e in
      if t <> TBool then type_error e.eloc t TBool;
      let env_loop = { env with vars = SMap.empty :: env.vars } in
      ignore (check_seq env_loop ret b);
      env
  | Block b ->
      let env_block = { env with vars = SMap.empty :: env.vars } in
      ignore (check_seq env_block ret b);
      env
  | Vars (ids, opt_ty, init_seq) ->
      (* cas var x,y [ty] [= ...]  *)
      let env_struct_fun = env in
      (* Déterminer les types pour les identificateurs déclarés. Plusieurs formes
         sont possibles :
         - type explicite fourni : tous les ids ont ce type
         - initialisateur avec même nombre d'expressions rhs que d'ids : inférer
           le type de chaque variable depuis l'expression rhs correspondante
         - rhs unique qui est un Call retournant plusieurs valeurs : utiliser les
           types de résultat de la fonction (doit correspondre au nombre d'ids)
      *)
      let types_to_add : typ list =
        match opt_ty with
        | Some t ->
            check_type_bf loc env_struct_fun t;
            List.init (List.length ids) (fun _ -> t)
        | None ->
            begin match init_seq with
            | { idesc = Set (_, rhs); _ } :: _ ->
                begin match rhs with
                | [] -> error loc "empty initializer"
                | _ when List.length rhs = List.length ids ->
                    List.map (fun e -> type_expr env e) rhs
                | [e1] ->
                    (* rhs unique : doit être un appel retournant plusieurs valeurs *)
                    begin match e1.edesc with
                    | Call (f, args) ->
                        let fsig = find_func e1.eloc f.id env in
                        (* vérifier les types des arguments de l'appel *)
                        let nparams = List.length fsig.params in
                        let nargs = List.length args in
                        if nparams <> nargs then
                          error e1.eloc
                            (Printf.sprintf
                               "function %s expects %d args, got %d"
                               f.id nparams nargs);
                        List.iter2
                          (fun a ty_exp ->
                             let ty_a = type_expr env a in
                             if ty_a <> ty_exp then
                               type_error a.eloc ty_a ty_exp)
                          args fsig.params;
                        let res_types = fsig.results in
                        if List.length res_types <> List.length ids then
                          error loc "l'initialisateur retourne un nombre incorrect de valeurs";
                        res_types
                    | _ -> error loc "impossible d'inférer le type sans initialisateur"
                    end
                | _ -> error loc "impossible d'inférer le type sans initialisateur"
                end
            | _ -> error loc "impossible d'inférer le type sans initialisateur"
            end
      in
      (* ajout des variables dans l'environnement *)
      let env' =
        let pairs = List.combine ids types_to_add in
        List.fold_left
          (fun acc (x, ty) -> add_var loc x ty acc)
          env pairs
      in
      (* typage du code d'initialisation dans le nouvel environnement *)
      ignore (check_seq env' ret init_seq);
      env'

  | Return elist ->
      (* Γ ⊢ return e1,...,en *)
      if ret = [] && elist <> [] then
        error loc "this function does not return any value";
      let nret = List.length ret in
      let ne   = List.length elist in
      if nret <> ne then
        error loc
          (Printf.sprintf "fonction retourne %d valeurs, obtenu %d" nret ne);
      List.iter2
        (fun e ty_exp ->
           let ty = type_expr env e in
           if ty <> ty_exp then type_error e.eloc ty ty_exp)
        elist ret;
      env

(*------------------------------------------------------------------*)
(* Vérification des structures et fonctions du fichier              *)
(*------------------------------------------------------------------*)

(* 1. Ajout des structures (sans champs) dans l'environnement *)
let build_struct_env (decls : decl list) : struct_env =
  List.fold_left
    (fun acc d ->
       match d with
       | Struct sdef ->
           if SMap.mem sdef.sname.id acc then
             failwith ("structure dupliquée " ^ sdef.sname.id);
           SMap.add sdef.sname.id SMap.empty acc
       | _ -> acc)
    SMap.empty decls

(* 2(a). Ajout des signatures de fonctions *)
let build_func_env (structs : struct_env) (decls : decl list) : func_env =
  let dummy_env = { structs; funcs = SMap.empty; vars = [SMap.empty] } in
  List.fold_left
    (fun acc d ->
       match d with
       | Fun fdef ->
           if SMap.mem fdef.fname.id acc then
             failwith ("fonction dupliquée " ^ fdef.fname.id);
           (* vérif types bien formés et params distincts *)
           let seen = Hashtbl.create 16 in
           List.iter
             (fun (x, ty) ->
                if Hashtbl.mem seen x.id then
                  failwith ("paramètre dupliqué " ^ x.id)
                else Hashtbl.add seen x.id ();
                check_type_bf dummy_loc dummy_env ty)
             fdef.params;
           List.iter
             (fun ty -> check_type_bf dummy_loc dummy_env ty)
             fdef.return;
           let params_ty = List.map snd fdef.params in
           SMap.add fdef.fname.id { params = params_ty; results = fdef.return } acc
       | _ -> acc)
    SMap.empty decls

(* 2(b). Ajout des champs de structures, et vérification des types *)
let add_struct_fields (structs : struct_env) (decls : decl list) : struct_env =
  List.fold_left
    (fun acc d ->
       match d with
       | Struct sdef ->
           let sinfo =
             try SMap.find sdef.sname.id acc
             with Not_found -> SMap.empty
           in
           (* champs distincts *)
           let tmp = Hashtbl.create 16 in
           List.iter
             (fun (x, ty) ->
                if Hashtbl.mem tmp x.id then
                  failwith ("champ dupliqué " ^ x.id ^ " dans la structure " ^ sdef.sname.id)
                else Hashtbl.add tmp x.id ();
                (* type bien formé *)
                let dummy_env = { structs = acc; funcs = SMap.empty; vars = [SMap.empty] } in
                check_type_bf dummy_loc dummy_env ty)
             sdef.fields;
           let sinfo' =
             List.fold_left
               (fun m (x, ty) -> SMap.add x.id ty m)
               sinfo sdef.fields
           in
           SMap.add sdef.sname.id sinfo' acc
       | _ -> acc)
    structs decls

(* 3. Vérification des fonctions *)
let check_function (env0 : tenv) (fdef : func_def) : unit =
  (* on ajoute les paramètres dans l’environnement local *)
  let env =
    List.fold_left
      (fun acc (x, ty) ->
         add_var dummy_loc x ty acc)
      env0 fdef.params
  in
  (* ret = types de retour *)
  let ret = fdef.return in
  ignore (check_seq env ret fdef.body);
  ()

(*------------------------------------------------------------------*)
(* Entrée principale : typage d’un programme complet                *)
(* program = bool * decl list : (import_fmt, decls)                 *)
(*------------------------------------------------------------------*)

let type_program ((import_fmt, decls) : program) : program =
  ignore import_fmt;
  (* étape 1 : structures sans champs *)
  let senv0 = build_struct_env decls in
  (* étape 2(a) : fonctions *)
  let fenv = build_func_env senv0 decls in
  (* étape 2(b) : champs de structures *)
  let senv = add_struct_fields senv0 decls in
  (* environnement de base pour typer les corps de fonctions *)
  let base_env = { structs = senv; funcs = fenv; vars = [SMap.empty] } in

  (* 3. vérifier chaque fonction *)
  List.iter
    (fun d ->
       match d with
       | Fun fdef -> check_function base_env fdef
       | Struct _ -> ())
    decls;

  (* vérifier présence main sans params ni retour *)
  begin
    try
      let fsig = SMap.find "main" fenv in
      if fsig.params <> [] || fsig.results <> [] then
        failwith "main ne doit avoir aucun paramètre ni type de retour"
    with Not_found ->
      failwith "aucune fonction main définie"
  end;
  (import_fmt, decls) (* ici on renvoie le programme initial, mais on peut aussi appliquer des transformations en vue de la compilation *)

let prog = type_program
