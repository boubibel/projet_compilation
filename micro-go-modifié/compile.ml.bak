open Mgoast
open Mips

let new_label =
  let cpt = ref (-1) in
  fun () -> incr cpt; Printf.sprintf "_label_%i" !cpt

(* association variable id -> adresse dans la pile *)
let var_stack = ref []

(* nombre de paramètres de la fonction courante *)
let n_params = ref 0

(* vrai si la fonction courante est main *)
let is_main_fun = ref false

(* collecte les chaînes de caractères du programme pour la zone de données *)
let string_map = ref []
let next_string_id = ref 0

(* collecte les définitions de structures : nom -> liste de champs *)
let struct_defs = ref []

(* le résultat de l'expression est dans le registre $t0,
   la pile est utilisée pour les valeurs intermédiaires *)
let rec tr_expr e = match e.edesc with
  | Int(n)  -> li t0 (Int64.to_int n)   (* on supposera que les constantes entières
                                           sont représentables sur 32 bits *)
  | String(s) -> 
      (* Récupérer le label de la chaîne depuis string_map *)
      let lbl = 
        try List.assoc s !string_map
        with Not_found -> 
          (* Si pas trouvé (ne devrait pas arriver), créer un nouveau label *)
          let new_lbl = Printf.sprintf "_str_%d" !next_string_id in
          incr next_string_id;
          string_map := (s, new_lbl) :: !string_map;
          new_lbl
      in
      la t0 lbl
  | Var(id) -> 
      (* charger la valeur de la variable depuis la pile *)
      (try
        let addr = List.assoc id.id !var_stack in
        lw t0 addr sp
      with Not_found ->
        (* variable non trouvée dans la pile *)
        comment (Printf.sprintf "var %s non trouvée" id.id))
  | Binop(bop, e1, e2) ->
    (* Court-circuit pour && et || *)
    (match bop with
    | And ->
        (* e1 && e2 : évaluer e1, si faux (0) alors résultat=0, sinon évaluer e2 *)
        let label_false = new_label () in
        let label_end = new_label () in
        tr_expr e1
        @@ beqz t0 label_false  (* si e1 == 0, sauter à false *)
        @@ tr_expr e2           (* sinon évaluer e2 *)
        @@ b label_end          (* et sauter à la fin *)
        @@ label label_false
        @@ li t0 0              (* résultat = 0 *)
        @@ label label_end
    | Or ->
        (* e1 || e2 : évaluer e1, si vrai (!=0) alors résultat=1, sinon évaluer e2 *)
        let label_true = new_label () in
        let label_end = new_label () in
        tr_expr e1
        @@ bnez t0 label_true   (* si e1 != 0, sauter à true *)
        @@ tr_expr e2           (* sinon évaluer e2 *)
        @@ b label_end          (* et sauter à la fin *)
        @@ label label_true
        @@ li t0 1              (* résultat = 1 *)
        @@ label label_end
    | _ ->
        (* Autres opérations binaires *)
        let op = match bop with
          | Add -> add
          | Sub -> (fun r1 r2 r3 -> S(Printf.sprintf "  sub  %s, %s, %s" r1 r2 r3))
          | Mul -> mul
          | Div -> (fun r1 r2 r3 -> S(Printf.sprintf "  div  %s, %s, %s" r1 r2 r3))
          | Rem -> (fun r1 r2 r3 -> S(Printf.sprintf "  rem  %s, %s, %s" r1 r2 r3))
          | Lt  -> slt
          | Le  -> (fun r1 r2 r3 -> S(Printf.sprintf "  sle  %s, %s, %s" r1 r2 r3))
          | Gt  -> (fun r1 r2 r3 -> S(Printf.sprintf "  sgt  %s, %s, %s" r1 r2 r3))
          | Ge  -> (fun r1 r2 r3 -> S(Printf.sprintf "  sge  %s, %s, %s" r1 r2 r3))
          | Eq  -> (fun r1 r2 r3 -> S(Printf.sprintf "  seq  %s, %s, %s" r1 r2 r3))
          | Neq -> (fun r1 r2 r3 -> S(Printf.sprintf "  sne  %s, %s, %s" r1 r2 r3))
          | And -> and_
          | Or  -> (fun r1 r2 r3 -> S(Printf.sprintf "  or   %s, %s, %s" r1 r2 r3))
        in
        (* Évaluer e2 d'abord *)
        let code_e2 = tr_expr e2 in
        (* Pousser le résultat sur la pile *)
        let code_push = push t0 in
        (* Ajuster var_stack pour refléter le push (tous les offsets +4) *)
        let old_stack = !var_stack in
        var_stack := List.map (fun (name, off) -> (name, off + 4)) !var_stack;
        (* Évaluer e1 avec les offsets ajustés *)
        let code_e1 = tr_expr e1 in
        (* Restaurer var_stack *)
        var_stack := old_stack;
        (* Dépiler et calculer *)
        code_e2 @@ code_push @@ code_e1 @@ pop t1 @@ op t0 t0 t1)
  | Bool(b) -> li t0 (if b then 1 else 0)
  | Nil -> li t0 0  (* nil est représenté par 0 *)
  | Unop(op, e) ->
    let instr = match op with
      | Opp -> (fun r -> S(Printf.sprintf "  neg  %s, %s" r r))
      | Not -> (fun r -> S(Printf.sprintf "  xori %s, %s, 1" r r))
    in
    tr_expr e @@ instr t0
  | Print(exprs) ->
    (* Pour fmt.Print: appel système pour affichage *)
    (match exprs with
     | [e] ->
         (* Détecter si c'est une string pour utiliser le bon syscall *)
         let syscall_code = match e.edesc with
           | String _ -> 4  (* syscall 4 = print_string *)
           | _ -> 1         (* syscall 1 = print_int *)
         in
         tr_expr e
         @@ move a0 t0
         @@ li v0 syscall_code
         @@ syscall
     | exprs ->
         (* Arguments multiples : afficher chaque expression *)
         List.fold_left (fun code e ->
           let syscall_code = match e.edesc with
             | String _ -> 4
             | _ -> 1
           in
           code
           @@ tr_expr e
           @@ move a0 t0
           @@ li v0 syscall_code
           @@ syscall
         ) nop exprs)
  | Call(fname, args) ->
    (* Appel de fonction : empiler les arguments puis appeler *)
    (* 1. Évaluer et empiler les arguments dans l'ordre *)
    let push_args =
      List.fold_left (fun code arg ->
        code @@ tr_expr arg @@ push t0
      ) nop args
    in
    (* 2. Appeler la fonction *)
    let call_code = jal fname.id in
    (* 3. Nettoyer la pile (nombre d'arguments * 4) *)
    let cleanup = 
      let n = List.length args in
      if n > 0 then addi sp sp (n * 4) else nop
    in
    (* 4. Récupérer le résultat de $v0 dans $t0 *)
    push_args @@ call_code @@ cleanup @@ move t0 v0
  | Dot(e, field) ->
    (* Accès à un champ de structure : e.field *)
    (* e doit être un pointeur vers la structure *)
    (* On charge le champ à l'offset approprié *)
    let code_e = tr_expr e in
    (* $t0 contient maintenant l'adresse de la structure *)
    (* Trouver l'offset du champ *)
    let offset = 
      try
        (* Chercher le champ dans toutes les structures définies *)
        let rec find_field_offset structs =
          match structs with
          | [] -> 
              (* Fallback pour les anciennes structures hardcodées *)
              (match field.id with
               | "x" | "quo" -> 0
               | "y" | "rem" -> 4
               | _ -> 0)
          | sd :: rest ->
              (* Chercher le champ dans cette structure *)
              let rec find_in_fields fields idx =
                match fields with
                | [] -> None
                | (fid, _) :: rest_fields ->
                    if fid.id = field.id then Some (idx * 4)
                    else find_in_fields rest_fields (idx + 1)
              in
              match find_in_fields sd.fields 0 with
              | Some off -> off
              | None -> find_field_offset rest
        in
        find_field_offset !struct_defs
      with Not_found -> 0
    in
    code_e @@ lw t0 offset t0
  | New(typename) ->
    (* Allocation de structure sur le heap (avec sbrk syscall 9) *)
    let size = 
      try
        let def = List.find (fun sd -> sd.sname.id = typename) !struct_defs in
        List.length def.fields * 4
      with Not_found -> 8  (* Par défaut, supposer 2 champs *)
    in
    (* Utiliser syscall 9 (sbrk) pour allouer sur le heap *)
    li a0 size           (* taille à allouer *)
    @@ li v0 9           (* syscall sbrk *)
    @@ syscall           (* $v0 contient maintenant l'adresse allouée *)
    @@ move t0 v0        (* copier dans $t0 pour cohérence avec le reste du code *)


let rec tr_seq = function
  | []   -> nop
  | [i]  -> tr_instr i
  | i::s -> 
      let code_i = tr_instr i in
      let code_s = tr_seq s in
      code_i @@ code_s

and tr_instr i = match i.idesc with 
  | If(c, s1, s2) ->
    let old_stack = !var_stack in
    let old_stack_size = List.length old_stack in
    let then_label = new_label()
    and end_label = new_label()
    in
    let code_before = tr_expr c @@ bnez t0 then_label in
    let code_s2 = tr_seq s2 in
    let new_stack_size_s2 = List.length !var_stack in
    let dealloc_s2 = (new_stack_size_s2 - old_stack_size) * 4 in
    var_stack := old_stack;
    let code_s1 = tr_seq s1 in
    let new_stack_size_s1 = List.length !var_stack in
    let dealloc_s1 = (new_stack_size_s1 - old_stack_size) * 4 in
    var_stack := old_stack;
    code_before
    @@ code_s2
    @@ (if dealloc_s2 > 0 then addi sp sp dealloc_s2 else nop)
    @@ b end_label
    @@ label then_label
    @@ code_s1
    @@ (if dealloc_s1 > 0 then addi sp sp dealloc_s1 else nop)
    @@ label end_label

  | For(c, s) ->
    let old_stack = !var_stack in
    let old_stack_size = List.length old_stack in
    let test_label = new_label()
    and code_label = new_label()
    in
    let code_body = tr_seq s in
    let new_stack_size = List.length !var_stack in
    let dealloc = (new_stack_size - old_stack_size) * 4 in
    var_stack := old_stack;
    b test_label
    @@ label code_label
    @@ code_body
    @@ (if dealloc > 0 then addi sp sp dealloc else nop)
    @@ label test_label
    @@ tr_expr c
    @@ bnez t0 code_label
    
  | Block(s) ->
    let old_stack = !var_stack in
    let old_stack_size = List.length old_stack in
    let code = tr_seq s in
    let new_stack_size = List.length !var_stack in
    let dealloc = (new_stack_size - old_stack_size) * 4 in
    var_stack := old_stack;
    code @@ (if dealloc > 0 then addi sp sp dealloc else nop)
    
  | Set(lhs, rhs) ->
    (* Assignation : lhs := rhs *)
    (match lhs, rhs with
     | [{ edesc = Var(id); _ }], [e] ->
         (* Assignation simple : x := e *)
         (* Évaluer l'expression (qui peut modifier var_stack si c'est new()) *)
         let code_e = tr_expr e in
         (* PUIS capturer l'offset de la variable après l'évaluation *)
         (try
           let addr = List.assoc id.id !var_stack in
           code_e @@ comment (Printf.sprintf "set %s at offset %d" id.id addr) @@ sw t0 addr sp
         with Not_found ->
           code_e @@ comment (Printf.sprintf "set: var %s non trouvée" id.id))
     | [{ edesc = Dot(e_struct, field); _ }], [e_val] ->
         (* Assignation à un champ : a.x := e *)
         (* 1. Évaluer la valeur *)
         let code_val = tr_expr e_val in
         (* 2. Pousser la valeur *)
         let code_push = push t0 in
         (* 3. Ajuster var_stack pour le push *)
         let old_stack = !var_stack in
         var_stack := List.map (fun (name, off) -> (name, off + 4)) !var_stack;
         (* 4. Évaluer l'adresse de la structure *)
         let code_struct = tr_expr e_struct in
         (* 5. Restaurer var_stack *)
         var_stack := old_stack;
         (* 6. Trouver l'offset du champ dynamiquement *)
         let offset = 
           try
             let rec find_field_offset structs =
               match structs with
               | [] -> 
                   (match field.id with
                    | "x" | "quo" -> 0
                    | "y" | "rem" -> 4
                    | _ -> 0)
               | sd :: rest ->
                   let rec find_in_fields fields idx =
                     match fields with
                     | [] -> None
                     | (fid, _) :: rest_fields ->
                         if fid.id = field.id then Some (idx * 4)
                         else find_in_fields rest_fields (idx + 1)
                   in
                   match find_in_fields sd.fields 0 with
                   | Some off -> off
                   | None -> find_field_offset rest
             in
             find_field_offset !struct_defs
           with Not_found -> 0
         in
         (* 7. Dépiler la valeur et la stocker *)
         code_val @@ code_push @@ code_struct @@ pop t1 @@ sw t1 offset t0
     | vars, exprs when List.length vars = List.length exprs && List.length vars > 1 ->
         (* Assignation multiple : x, y := a, b *)
         let n = List.length vars in
         let old_stack = !var_stack in
         (* 1. Évaluer toutes les expressions et les pousser sur la pile *)
         (* Ajuster var_stack pour chaque push *)
         let rec push_exprs_with_adjust exprs_list =
           match exprs_list with
           | [] -> nop
           | e :: rest ->
               let code_e = tr_expr e in
               let code_push = push t0 in
               (* Ajuster var_stack après le push *)
               var_stack := List.map (fun (name, off) -> (name, off + 4)) !var_stack;
               code_e @@ code_push @@ push_exprs_with_adjust rest
         in
         let push_code = push_exprs_with_adjust exprs in
         (* 2. Assigner depuis la pile vers les variables *)
         (* Les valeurs sont sur la pile à offsets 0, 4, 8, ... (en ordre inverse des vars) *)
         let rec assign_vars vars_list offset =
           match vars_list with
           | [] -> nop
           | { edesc = Var(id); _ } :: rest ->
               (try
                 let addr = List.assoc id.id !var_stack in
                 lw t0 offset sp @@ sw t0 addr sp @@ assign_vars rest (offset + 4)
               with Not_found ->
                 comment (Printf.sprintf "set: var %s non trouvée" id.id) @@ assign_vars rest (offset + 4))
           | _ :: rest ->
               assign_vars rest (offset + 4)
         in
         let assign_code = assign_vars (List.rev vars) 0 in
         (* Restaurer var_stack puis nettoyer la pile *)
         var_stack := old_stack;
         push_code @@ assign_code @@ addi sp sp (4 * n)
     | _ ->
         (* Assignations complexes non supportées *)
         nop)
    
  | Inc(e) ->
    (* Incrémenter : e++ *)
    (match e.edesc with
     | Var(id) ->
         (try
           let offset = List.assoc id.id !var_stack in
           lw t0 offset sp
           @@ addi t0 t0 1
           @@ sw t0 offset sp
         with Not_found ->
           comment (Printf.sprintf "Inc: var %s non trouvée" id.id))
     | Dot(struct_e, field) ->
         (* Incrémenter un champ de structure : r.quo++ *)
         let code_struct = tr_expr struct_e in  (* $t0 = adresse de la structure *)
         let offset = 
           try
             let rec find_field_offset structs =
               match structs with
               | [] -> 
                   (match field.id with
                    | "x" | "quo" -> 0
                    | "y" | "rem" -> 4
                    | _ -> 0)
               | sd :: rest ->
                   let rec find_in_fields fields idx =
                     match fields with
                     | [] -> None
                     | (fid, _) :: rest_fields ->
                         if fid.id = field.id then Some (idx * 4)
                         else find_in_fields rest_fields (idx + 1)
                   in
                   match find_in_fields sd.fields 0 with
                   | Some off -> off
                   | None -> find_field_offset rest
             in
             find_field_offset !struct_defs
           with Not_found -> 0
         in
         code_struct
         @@ lw t1 offset t0      (* charger la valeur du champ *)
         @@ addi t1 t1 1         (* incrémenter *)
         @@ sw t1 offset t0      (* sauvegarder *)
     | _ -> comment "Inc: expression non supportée")
    
  | Dec(e) ->
    (* Décrémenter : e-- *)
    (match e.edesc with
     | Var(id) ->
         (try
           let offset = List.assoc id.id !var_stack in
           lw t0 offset sp
           @@ addi t0 t0 (-1)
           @@ sw t0 offset sp
         with Not_found ->
           comment (Printf.sprintf "Dec: var %s non trouvée" id.id))
     | Dot(struct_e, field) ->
         (* Décrémenter un champ de structure : r.quo-- *)
         let code_struct = tr_expr struct_e in
         let offset = 
           try
             let rec find_field_offset structs =
               match structs with
               | [] -> 
                   (match field.id with
                    | "x" | "quo" -> 0
                    | "y" | "rem" -> 4
                    | _ -> 0)
               | sd :: rest ->
                   let rec find_in_fields fields idx =
                     match fields with
                     | [] -> None
                     | (fid, _) :: rest_fields ->
                         if fid.id = field.id then Some (idx * 4)
                         else find_in_fields rest_fields (idx + 1)
                   in
                   match find_in_fields sd.fields 0 with
                   | Some off -> off
                   | None -> find_field_offset rest
             in
             find_field_offset !struct_defs
           with Not_found -> 0
         in
         code_struct
         @@ lw t1 offset t0
         @@ addi t1 t1 (-1)
         @@ sw t1 offset t0
     | _ -> comment "Dec: expression non supportée")
    
  | Vars(ids, _typ_opt, s) ->
    (* Déclaration de variables locales *)
    let n = List.length ids in
    let total_size = n * 4 in
    (* Les nouvelles variables seront aux offsets 0, 4, 8, ... depuis le NOUVEAU sp *)
    (* Les anciennes variables voient leur offset augmenté de total_size *)
    var_stack := List.map (fun (name, off) -> (name, off + total_size)) !var_stack;
    List.iteri (fun i id ->
      var_stack := (id.id, i * 4) :: !var_stack
    ) ids;
    (* Générer : allocation + corps (PAS de désallocation car new() peut avoir modifié var_stack) *)
    addi sp sp (-total_size)
    @@ tr_seq s
    
  | Return(exprs) ->
    (* Retour de fonction : mettre les valeurs dans $v0, etc. et jr $ra *)
    (* D'abord calculer combien de variables locales nettoyer *)
    let locals_size = (List.length !var_stack - !n_params) * 4 in
    let cleanup = 
      if !is_main_fun then
        if locals_size > 0 then addi sp sp locals_size else nop
      else
        (* Fonction non-main : toujours restaurer $ra *)
        if locals_size > 0 then
          addi sp sp locals_size @@ pop ra
        else
          pop ra
    in
    (match exprs with
     | [] -> cleanup @@ jr ra
     | [e] -> tr_expr e @@ move v0 t0 @@ cleanup @@ jr ra
     | e :: _rest -> 
         (* Retours multiples : pas supporté pour l'instant *)
         tr_expr e @@ move v0 t0 @@ cleanup @@ jr ra)
    
  | Expr(e) ->
    (* Expression utilisée comme instruction *)
    tr_expr e


let tr_fun df =
  var_stack := [];  (* Réinitialiser pour chaque fonction *)
  let np = List.length df.params in
  n_params := np;
  
  (* Vérifier si c'est main *)
  let is_main = df.fname.id = "main" in
  is_main_fun := is_main;
  
  (* Les paramètres restent sur la pile où ils ont été empilés *)
  (* Pour div2(a, b) appelé avec push(45), push(6) : *)
  (*   - 0($sp) = b (dernier empilé) *)
  (*   - 4($sp) = a (premier empilé) *)
  (* On les ajoute à var_stack avec leurs offsets *)
  let rec add_params params idx =
    match params with
    | [] -> ()
    | (id, _typ) :: rest ->
        let offset = (np - 1 - idx) * 4 in
        var_stack := (id.id, offset) :: !var_stack;
        add_params rest (idx + 1)
  in
  add_params df.params 0;
  
  (* Toujours sauvegarder $ra, même pour main (car main peut appeler d'autres fonctions) *)
  let save_ra = push ra in
  (* Ajuster les offsets des paramètres après save $ra *)
  var_stack := List.map (fun (name, off) -> (name, off + 4)) !var_stack;
  
  (* Traduire le corps de la fonction *)
  let body_code = tr_seq df.body in
  
  (* Ajouter un return implicite à la fin si la fonction ne retourne pas *)
  let has_explicit_return = 
    match List.rev df.body with
    | { idesc = Return _; _ } :: _ -> true
    | _ -> false
  in
  let implicit_return =
    if has_explicit_return then
      nop
    else 
      (* Fonction sans return explicite : restaurer $ra et retourner *)
      (* Calculer locals_size APRÈS tr_seq pour avoir le var_stack final *)
      let locals_size = (List.length !var_stack - np) * 4 in
      if locals_size > 0 then
        addi sp sp locals_size @@ pop ra @@ jr ra
      else
        pop ra @@ jr ra
  in
  
  label df.fname.id
  @@ save_ra
  @@ body_code
  @@ implicit_return

let rec tr_ldecl = function
    Fun df::p -> tr_fun df @@ tr_ldecl p
  | _ :: p -> tr_ldecl p
  | [] -> nop

let collect_strings prog =
  string_map := [];
  next_string_id := 0;
  let rec collect_expr e = match e.edesc with
    | String(s) ->
        if not (List.mem_assoc s !string_map) then (
          string_map := (s, Printf.sprintf "_str_%d" !next_string_id) :: !string_map;
          incr next_string_id
        )
    | Binop(_, e1, e2) -> collect_expr e1; collect_expr e2
    | Unop(_, e) -> collect_expr e
    | Print(exprs) -> List.iter collect_expr exprs
    | Call(_, args) -> List.iter collect_expr args
    | Dot(e, _) -> collect_expr e
    | _ -> ()
  in
  let rec collect_instr i = match i.idesc with
    | Expr(e) -> collect_expr e
    | If(c, s1, s2) -> collect_expr c; List.iter collect_instr s1; List.iter collect_instr s2
    | For(c, s) -> collect_expr c; List.iter collect_instr s
    | Block(s) -> List.iter collect_instr s
    | Set(lhs, rhs) -> List.iter collect_expr lhs; List.iter collect_expr rhs
    | Vars(_, _, s) -> List.iter collect_instr s
    | Return(exprs) -> List.iter collect_expr exprs
    | Inc(e) | Dec(e) -> collect_expr e
  in
  let rec collect_decl = function
    | Fun df :: rest ->
        List.iter collect_instr df.body;
        collect_decl rest
    | Struct _ :: rest -> collect_decl rest
    | [] -> ()
  in
  let (_, decls) = prog in
  collect_decl decls

let tr_data () =
  let escape_string s =
    (* Échapper \ en premier pour éviter de ré-échapper les autres *)
    let s = String.concat "\\\\" (String.split_on_char '\\' s) in
    let s = String.concat "\\n" (String.split_on_char '\n' s) in
    let s = String.concat "\\t" (String.split_on_char '\t' s) in
    let s = String.concat "\\r" (String.split_on_char '\r' s) in
    let s = String.concat "\\\"" (String.split_on_char '"' s) in
    s
  in
  let string_decls = List.map (fun (s, id) ->
    label id @@ asciiz (Printf.sprintf "\"%s\"" (escape_string s))
  ) !string_map in
  match string_decls with
  | [] -> nop
  | first :: rest ->
      List.fold_left (fun acc decl -> acc @@ decl) first rest

let tr_prog p =
  (* Collecter les définitions de structures *)
  struct_defs := [];
  let (_, decls) = p in
  List.iter (fun d -> match d with
    | Struct sd -> struct_defs := sd :: !struct_defs
    | _ -> ()
  ) decls;
  
  collect_strings p;
  (* Ajouter un saut initial vers main comme point d'entrée *)
  let entry_point = 
    jal "main" 
    @@ li v0 10 
    @@ syscall 
  in
  { text = entry_point @@ tr_ldecl (snd p) ; data = tr_data () }
