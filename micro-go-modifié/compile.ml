open Mgoast
open Mips

let new_label =
  let cpt = ref (-1) in
  fun () -> incr cpt; Printf.sprintf "_label_%i" !cpt

(* association variable id -> adresse dans la pile *)
let var_stack = ref []

(* le résultat de l'expression est dans le registre $t0,
   la pile est utilisée pour les valeurs intermédiaires *)
let rec tr_expr e = match e.edesc with
  | Int(n)  -> li t0 (Int64.to_int n)   (* on supposera que les constantes entières
                                           sont représentables sur 32 bits *)
  | String(_) -> 
      (* allocation d'une chaîne dans la zone de données statiques *)
      let lbl = new_label() in
      la t0 lbl
  | Var(id) -> 
      (* charger la valeur de la variable depuis la pile *)
      (try
        let addr = List.assoc id.id !var_stack in
        lw t0 addr sp
      with Not_found ->
        (* variable non trouvée dans la pile *)
        comment (Printf.sprintf "var %s not found" id.id))
  | Binop(bop, e1, e2) ->
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
    tr_expr e2
    @@ push t0
    @@ tr_expr e1
    @@ pop t1
    @@ op t0 t0 t1
  | Bool(b) -> li t0 (if b then 1 else 0)
  | Nil -> li t0 0  (* nil is represented as 0 *)
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
         tr_expr e
         @@ move a0 t0
         @@ li v0 1  (* syscall 1 = print_int *)
         @@ syscall
     | _ ->
         (* Multiple arguments : simplification, on affiche le premier *)
         nop)
  | Call(_fname, _args) ->
    (* Appel de fonction : à compléter *)
    nop
  | Dot(_e, _field) ->
    (* Accès à un champ de structure : à compléter *)
    nop
  | New(_typename) ->
    (* Allocation de structure : à compléter *)
    nop


let rec tr_seq = function
  | []   -> nop
  | [i]  -> tr_instr i
  | i::s -> tr_instr i @@ tr_seq s

and tr_instr i = match i.idesc with 
  | If(c, s1, s2) ->
    let then_label = new_label()
    and end_label = new_label()
    in
    tr_expr c
    @@ bnez t0 then_label
    @@ tr_seq s2
    @@ b end_label
    @@ label then_label
    @@ tr_seq s1
    @@ label end_label

  | For(c, s) ->
    let test_label = new_label()
    and code_label = new_label()
    in
    b test_label
    @@ label code_label
    @@ tr_seq s
    @@ label test_label
    @@ tr_expr c
    @@ bnez t0 code_label
    
  | Block(s) ->
    tr_seq s
    
  | Set(lhs, rhs) ->
    (* Assignation : lhs := rhs *)
    (* Pour simplifier, on supporte seulement l'assignation simple x := e *)
    (match lhs, rhs with
     | [{ edesc = Var(id); _ }], [e] ->
         tr_expr e @@
         (try
           let addr = List.assoc id.id !var_stack in
           sw t0 addr sp
         with Not_found ->
           comment (Printf.sprintf "set: var %s not found" id.id))
     | _ ->
         (* Assignations multiples ou complexes non supportées *)
         nop)
    
  | Inc(_e) ->
    (* Incrémenter : e++ *)
    nop  (* À compléter: implémentation de Inc *)
    
  | Dec(_e) ->
    (* Décrémenter : e-- *)
    nop  (* À compléter: implémentation de Dec *)
    
  | Vars(ids, _typ_opt, s) ->
    (* Déclaration de variables locales *)
    let old_stack = !var_stack in
    let n = List.length ids in
    let total_size = n * 4 in
    (* Calculer les offsets: après avoir décrémenté sp, les vars sont à des offsets positifs *)
    let _ = List.fold_left (fun i id ->
      let offset = i * 4 in  (* offset positif depuis le nouveau sp *)
      var_stack := (id.id, offset) :: !var_stack;
      i + 1
    ) 0 ids in
    (* allouer l'espace sur la pile *)
    let alloc_code = addi sp sp (-total_size) in
    (* exécuter le corps avec les variables déclarées *)
    let body_code = tr_seq s in
    (* désallouer *)
    let dealloc_code = addi sp sp total_size in
    (* restaurer l'environnement APRÈS avoir généré le code *)
    var_stack := old_stack;
    alloc_code @@ body_code @@ dealloc_code
    
  | Return(exprs) ->
    (* Retour de fonction : mettre les valeurs dans $v0, etc. et jr $ra *)
    (match exprs with
     | [] -> jr ra
     | [e] -> tr_expr e @@ move v0 t0 @@ jr ra
     | e :: _rest -> 
         (* Multiple return : pas supporté pour l'instant *)
         tr_expr e @@ move v0 t0 @@ jr ra)
    
  | Expr(e) ->
    (* Expression utilisée comme instruction *)
    tr_expr e


let tr_fun df =
       label df.fname.id
    @@ tr_seq df.body

let rec tr_ldecl = function
    Fun df::p -> tr_fun df @@ tr_ldecl p
  | _ :: p -> tr_ldecl p
  | [] -> nop

(* collecte les chaînes de caractères du programme pour la zone de données *)
let string_map = ref []
let next_string_id = ref 0

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
  let string_decls = List.map (fun (s, id) ->
    label id @@ asciiz (Printf.sprintf "\"%s\"" s)
  ) !string_map in
  match string_decls with
  | [] -> nop
  | first :: rest ->
      List.fold_left (fun acc decl -> acc @@ decl) first rest

let tr_prog p =
  collect_strings p;
  { text = tr_ldecl (snd p) ; data = tr_data () }
