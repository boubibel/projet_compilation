open Mgoast

exception Error of Mgoast.location * string

let error loc msg = raise (Error (loc, msg))

let type_erreur loc ty_actu ty_attendu =
  error loc (Printf.sprintf "attendu %s, obtenu %s" (typ_to_string ty_attendu) (typ_to_string ty_actu))


       (*  Environnements   *)   

module SMap = Map.Make(String)


type struct_info = typ SMap.t

type struct_env = struct_info SMap.t

type func_sig = { params:typ list; results:typ list; }

type func_env = func_sig SMap.t

type var_env = typ SMap.t

type tenv = { structs:struct_env; funcs:func_env; vars:var_env list; }

let loc_lex : location = (Lexing.dummy_pos, Lexing.dummy_pos)


let ajouter_variable loc (x : ident) ty (env : tenv) : tenv =
  if x.id = "_" then env
  else
    match env.vars with
    | [] -> let top = SMap.add x.id ty SMap.empty in { env with vars = top :: [] }
    | top :: rest -> 
        if SMap.mem x.id top then
          error loc (Printf.sprintf "variable %s déjà définie" x.id)
        else
          let top' = SMap.add x.id ty top in { env with vars = top' :: rest }

let rechercher_variable loc (x : ident) (env : tenv) : typ =
  let rec cherche = function
    | [] -> raise Not_found
    | top :: rest -> try SMap.find x.id top
        with Not_found -> cherche rest
  in
  try cherche env.vars
  with Not_found -> error loc (Printf.sprintf "variable %s non liée" x.id)

let rechercher_structure loc (sname : string) (env : tenv) : struct_info =
  try SMap.find sname env.structs
  with Not_found -> error loc (Printf.sprintf "struct %s inconnue" sname)

let rechercher_champ loc (sname : string) (fname : string) (env : tenv) : typ =
  let sinfo = rechercher_structure loc sname env in
  try SMap.find fname sinfo 
  with Not_found -> error loc (Printf.sprintf "champ inconnu %s dans struct %s" fname sname)

let rechercher_fct loc (fname : string) (env : tenv) : func_sig =
  try SMap.find fname env.funcs 
  with Not_found -> error loc (Printf.sprintf "function inconnue %s" fname)

       (*  Vérification des types   *)   

let verifier_type_valide loc (env : tenv) (t : typ) =
  match t with
  | TInt | TBool | TString -> ()
  | TStruct s ->
      if not (SMap.mem s env.structs) then
        error loc (Printf.sprintf "struct inconnue %s" s)


       (*  Typage des expressions   *) 

let rec type_expr (env : tenv) (e : expr) : typ =
  let loc = e.eloc in match e.edesc with
  | Int _ -> TInt
  | Bool _ -> TBool
  | String _ -> TString
  | Nil -> error loc "impossible d'inférer le type de nil ici"
  | Var x -> if x.id = "_" then error loc "_ ne peut pas apparaître dans une expression";
      rechercher_variable loc x env
  | Dot (e1, f) -> let t = type_expr env e1 in begin match t with
      | TStruct sname -> rechercher_champ loc sname f.id env
      | _ -> error loc "accès champ sur valeur non-structure"
      end
  | New sname -> if not (SMap.mem sname env.structs) then
        error loc (Printf.sprintf "struct inconnue %s" sname);
      TStruct sname
  | Unop (op, e1) -> let t1 = type_expr env e1 in begin match op, t1 with
      | Opp, TInt -> TInt
      | Not, TBool -> TBool
      | Opp, _ -> type_erreur loc t1 TInt
      | Not, _ -> type_erreur loc t1 TBool
      end
  | Binop (op, e1, e2) -> begin match op with
      | Eq | Neq -> begin match e1.edesc, e2.edesc with
          | Nil, Nil -> error loc "comparer nil et nil interdit"
          | Nil, _ -> let _ = type_expr env e2 in TBool
          | _, Nil -> let _ = type_expr env e1 in TBool
          | _ -> let t1 = type_expr env e1 in
              let t2 = type_expr env e2 in if t1 <> t2 then
                type_erreur loc t2 t1;
              TBool
          end
      | Lt | Le | Gt | Ge -> let t1 = type_expr env e1 in
          let t2 = type_expr env e2 in
          if t1 <> TInt || t2 <> TInt then error loc "comparaison nécessite deux entiers";
          TBool
      | Add | Sub | Mul | Div | Rem -> let t1 = type_expr env e1 in
          let t2 = type_expr env e2 in
          if t1 <> TInt || t2 <> TInt then error loc "opérateur arithmétique nécessite deux int";
          TInt
      | And | Or -> let t1 = type_expr env e1 in
          let t2 = type_expr env e2 in
          if t1 <> TBool || t2 <> TBool then error loc "opérateur logique nécessite des bool";
          TBool
      end
  | Call (f, args) -> let fsig = rechercher_fct loc f.id env in
      let nparams = List.length fsig.params in
      let nargs   = List.length args in
      if nparams <> nargs then error loc (Printf.sprintf "fonction %s attend %d arguments, reçu %d" f.id nparams nargs);
      List.iter2 (fun a ty_exp ->
           let ty_a = type_expr env a in
           if ty_a <> ty_exp then  type_erreur a.eloc ty_a ty_exp) args fsig.params;
      begin match fsig.results with
      | [t] -> t
      | [] -> error loc (Printf.sprintf "fonction %s ne retourne rien — impossible dans une expression" f.id)
      | _ -> error loc "fonction retourne plusieurs valeurs ; ne peut pas être utilisée comme expression unique"
      end
  | Print es ->
      List.iter (fun e -> match e.edesc with
        | Call (f, args) ->
            let fsig = rechercher_fct e.eloc f.id env in
            let nparams = List.length fsig.params in
            let nargs = List.length args in
            if nparams <> nargs then
              error e.eloc (Printf.sprintf "fonction %s attend %d args, reçu %d" f.id nparams nargs);
            List.iter2
              (fun a ty_exp -> 
              let ty_a = type_expr env a in
                if ty_a <> ty_exp then type_erreur a.eloc ty_a ty_exp) args fsig.params
        | _ -> ignore (type_expr env e))
      es;
    TInt


       (*  Valeurs gauches Γ ⊢l e : τ    *) 


let type_lvalue (env : tenv) (e : expr) : typ =
  let loc = e.eloc in match e.edesc with
  | Var x -> if x.id = "_" then  error loc "_ interdit à gauche d’une affectation";
      rechercher_variable loc x env
  | Dot (e1, f) -> let t = type_expr env e1 in begin match t with
      | TStruct sname -> rechercher_champ loc sname f.id env
      | _ -> error loc "accès champ sur valeur non-struct"
      end
  | _ -> error loc "pas une valeur assignable"



         (*  Typage des instructions     *) 


let rec verifier_seq (env : tenv) (ret : typ list) (s : seq) : tenv =
  match s with
  | [] -> env
  | i :: rest -> let env' = verifier_instr env ret i in verifier_seq env' ret rest

and verifier_instr (env : tenv) (ret : typ list) (i : instr) : tenv =
  let loc = i.iloc in match i.idesc with
  | Expr e -> ignore (type_expr env e);
      env
  | Inc e
  | Dec e -> let t = type_lvalue env e in
      if t <> TInt then type_erreur e.eloc t TInt;
      env
  | Set (lhs, rhs) -> let tl = List.map (type_lvalue env) lhs in
      let tr = match rhs with
        | [] -> error loc "empty right-hand side in assignment"
        | _ when List.length rhs = List.length tl ->
            List.map (type_expr env) rhs
        | [e] -> begin match e.edesc with
            | Call (f, args) ->
                let fsig = rechercher_fct e.eloc f.id env in
                let nparams = List.length fsig.params in
                let nargs = List.length args in
                if nparams <> nargs then
                  error e.eloc (Printf.sprintf "function %s expects %d args, got %d" f.id nparams nargs);
                List.iter2 (fun a ty_exp ->
                     let ty_a = type_expr env a in
                     if ty_a <> ty_exp then
                       type_erreur a.eloc ty_a ty_exp)
                  args fsig.params;
                fsig.results
            | _ -> List.map (type_expr env) rhs
            end
        | _ -> error loc "nombre de valeurs incorrect dans l'assignation"
      in
      if List.length tl <> List.length tr then
        error loc "nombre de valeurs incorrect dans l'assignation";
      List.iter2 (fun ty_l ty_r -> if ty_l <> ty_r then error loc
               (Printf.sprintf "assignement incompatible: %s := %s"
                  (typ_to_string ty_l) (typ_to_string ty_r)))
        tl tr;
      env
  | If (e, b1, b2) ->
      let t = type_expr env e in
      if t <> TBool then type_erreur e.eloc t TBool;
      let env_branch = { env with vars = SMap.empty :: env.vars } in
      ignore (verifier_seq env_branch ret b1);
      let env_branch2 = { env with vars = SMap.empty :: env.vars } in
      ignore (verifier_seq env_branch2 ret b2);
      env
  | For (e, b) ->
      let t = type_expr env e in
      if t <> TBool then type_erreur e.eloc t TBool;
      let env_loop = { env with vars = SMap.empty :: env.vars } in
      ignore (verifier_seq env_loop ret b);
      env
  | Block b ->
      let env_block = { env with vars = SMap.empty :: env.vars } in
      ignore (verifier_seq env_block ret b);
      env
  | Vars (ids, opt_ty, init_seq) -> 
      let env_struct_fun = env in
      let types_to_add : typ list =
        match opt_ty with
        | Some t -> verifier_type_valide loc env_struct_fun t;
            List.init (List.length ids) (fun _ -> t)
        | None -> begin match init_seq with
            | { idesc = Set (_, rhs); _ } :: _ -> begin match rhs with
                | [] -> error loc "initialisateur vide"
                | _ when List.length rhs = List.length ids -> List.map (fun e -> type_expr env e) rhs
                | [e1] -> begin match e1.edesc with
                    | Call (f, args) -> let fsig = rechercher_fct e1.eloc f.id env in
                        let nparams = List.length fsig.params in
                        let nargs = List.length args in
                        if nparams <> nargs then
                          error e1.eloc (Printf.sprintf "function %s attend %d args, obtient %d" f.id nparams nargs);
                        List.iter2
                          (fun a ty_exp -> let ty_a = type_expr env a in
                             if ty_a <> ty_exp then type_erreur a.eloc ty_a ty_exp) args fsig.params;
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
      let env' =
        let pairs = List.combine ids types_to_add in
        List.fold_left (fun acc (x, ty) -> ajouter_variable loc x ty acc) env pairs
      in
      ignore (verifier_seq env' ret init_seq);
      env'

  | Return elist -> 
      if ret = [] && elist <> [] then error loc "ne retourne pas de valeur";
      let nret = List.length ret in
      let ne   = List.length elist in
      if nret <> ne then error loc (Printf.sprintf "fonction retourne %d valeurs, obtenu %d" nret ne);
      List.iter2 (fun e ty_exp -> let ty = type_expr env e in
           if ty <> ty_exp then type_erreur e.eloc ty ty_exp) elist ret;
      env


         (*  Vérification des structures et fonctions du fichier     *) 


let build_struct_env (decls : decl list) : struct_env =
  List.fold_left (fun acc d -> match d with
       | Struct sdef -> if SMap.mem sdef.sname.id acc then
             failwith ("structure dupliquée " ^ sdef.sname.id);
           SMap.add sdef.sname.id SMap.empty acc
       | _ -> acc)
    SMap.empty decls


let build_func_env (structs : struct_env) (decls : decl list) : func_env =
  let dummy_env = { structs; funcs = SMap.empty; vars = [SMap.empty] } in
  List.fold_left
    (fun acc d -> match d with
       | Fun fdef ->
           if SMap.mem fdef.fname.id acc then failwith ("fonction dupliquée " ^ fdef.fname.id);
           let seen = Hashtbl.create 16 in
           List.iter (fun (x, ty) -> if Hashtbl.mem seen x.id then
                  failwith ("paramètre dupliqué " ^ x.id)
                else Hashtbl.add seen x.id ();
                verifier_type_valide loc_lex dummy_env ty)
             fdef.params;
           List.iter (fun ty -> verifier_type_valide loc_lex dummy_env ty) fdef.return;
           let params_ty = List.map snd fdef.params in
           SMap.add fdef.fname.id { params = params_ty; results = fdef.return } acc
       | _ -> acc)
    SMap.empty decls

let add_struct_fields (structs : struct_env) (decls : decl list) : struct_env =
  List.fold_left (fun acc d -> match d with
       | Struct sdef ->
           let sinfo = try SMap.find sdef.sname.id acc
             with Not_found -> SMap.empty
           in
           let tmp = Hashtbl.create 16 in
           List.iter (fun (x, ty) -> if Hashtbl.mem tmp x.id then failwith ("champ dupliqué " ^ x.id ^ " dans la structure " ^ sdef.sname.id)
                else Hashtbl.add tmp x.id ();
                let dummy_env = { structs = acc; funcs = SMap.empty; vars = [SMap.empty] } in
                verifier_type_valide loc_lex dummy_env ty) sdef.fields;
           let sinfo' = List.fold_left (fun m (x, ty) -> SMap.add x.id ty m) sinfo sdef.fields
           in
           SMap.add sdef.sname.id sinfo' acc
       | _ -> acc)
    structs decls


let check_function (env0 : tenv) (fdef : func_def) : unit =
  let env = List.fold_left (fun acc (x, ty) -> ajouter_variable loc_lex x ty acc) env0 fdef.params
  in
  let ret = fdef.return in
  ignore (verifier_seq env ret fdef.body);
  ()
  
       (*  Typage du programme   *)

let type_program ((import_fmt, decls) : program) : program =
  ignore import_fmt; 
  let senv0 = build_struct_env decls in 
  let fenv = build_func_env senv0 decls in 
  let senv = add_struct_fields senv0 decls in 
  let base_env = { structs = senv; funcs = fenv; vars = [SMap.empty] } in
  List.iter (fun d -> match d with
       | Fun fdef -> check_function base_env fdef
       | Struct _ -> ()) 
       decls;

  begin
    try
      let fsig = SMap.find "main" fenv in
      if fsig.params <> [] || fsig.results <> [] then failwith "main ne doit avoir aucun paramètre ni type de retour"
    with Not_found -> failwith "aucune fonction main définie"
  end;
  (import_fmt, decls)
let prog = type_program

