## Projet Compilation

# Organisation du Travail

Nous avons opté pour la création d'un github partagé pour faciliter le travail de par l'intégration de git à VSCode. Le README fait office de rapport.
On y a détaillé les grandes étapes, ce que font les tests, et des problèmes rencontrés dans le développement du projet.


## Tests (10 ajoutés)

# 
Pour Tester la partie 1 : make test
Pour la partie 2 :
./test_mips.sh    pour une vue rapide
./test_part2.sh   vue détaillée avec exemples

#
On a enlevé du make test les tests relevant une erreur pour permettre d'executer tous les tests qui passent, on vérifie les tests relevant une erreur un par un avec :
/_build/default/mgoc.exe tests/nom.go

Arith.go : calcul arithmétique
Teste : priorités d'associativité entre les opérations

Div.go : 3 variantes de divisions entières (itérative, récursive, renvoyant un pointeur vers une structure).
Teste : fonctions avec retours multiples, récursion, boucle for et modifications d'arguments, structures, pointeurs, accès aux champs et impression des valeurs retournées.

Instr.go : Exponentiation Rapide
Teste : For, réassignation de variables, modulo

Min.go : imprime 42

Point.go : Définition d'un type "point"
Teste : types structurés, new(Type), accès et modification de champs, affichage d'expression sur champs.

Neg_test.go : Déclaration récursive de types
** renvoi une erreur car pas de main, bon comportement **

Var.go : Calcul d'expressions à partir de plusieurs variables
Teste : déclarations de variables, assignations, expressions composées

Multi_return_assign.go : Affectation multiple depuis une fonction

Shadowing.go : Masquage de variables

For_icp.go : instr.go utilise la forme for (cond) {}, mais la forme avec init/cond/post n'est pas testée 
Teste : for (init; cond; post)

Neg_type_mismatch.go : Teste passage d'argument avec type incorrect
# renvoi une erreur car int != string, bon comportement

Neg_return_assign_func : Teste l'affectation à une variable de l'appel d'une fonction qui renvoie 2 variabels
# renvoi une erreur car différences de type à l'assignation, bon comportement

Nil.go : Vérifier que nil est bien pris en charge
Teste : comparaison pointeur avec nil

Logic_op : Teste de && et que le if est bien paresseux (n'évalue pas la 2eme condition du &&
quand la première est fausse)

Struct_assign.go : Assignation de variable et accès à une structure

Neg_assign_var.go : Déclare 2 fois une variable avec le même nom
# renvoi une erreur x already defined, bon comportement

Multiple_assign.go : Teste assignations multiples


## Commandes :
- Executer fichier de test : go run tests/nom.go




## Problèmes rencontrés :

# Teste de masquage dans shadowing.go :

Problème : une déclaration intérieure x := ... dans un bloc était rejetée par le compilateur (erreur « variable x already defined »).
Cause : le typechecker utilisait une seule table globale de variables; toute nouvelle declaration était comparée à l'ensemble global, empêchant le masquage lexical.
Ainsi, tests/shadowing.go ne passait pas alors que le code était valide en Micro‑Go attendu.
Solution : remplacer la table globale par une pile de tables (liste de maps) dans typechecker.ml.
Détail : add_var n’ajoute plus que dans la portée courante (top de la pile); find_var cherche du sommet vers la base.
Portée : on pousse une nouvelle table (scope) avant de typer les Block, les branches If et les corps For, et on la pop après vérification.
Résultat : les déclarations locales peuvent masquer des noms externes sans erreur, et les variables externes restent accessibles hors de la portée et shadowing.go passe les tests de typage.

# Problème : typage de nil dans les comparaisons

Test nil.go contenait if (p == nil) où p est de type *T.
Le typechecker original appelait type_expr sur les deux opérandes avant de vérifier s'il s'agissait d'une comparaison avec nil.
Quand type_expr rencontrait Nil, il levait immédiatement l'erreur "cannot infer type of nil here" — car nil n'a pas de type intrinsèque.
Résultat, impossible de compiler p == nil ou nil == p.
Solution : gestion spéciale de nil dans les comparaisons Eq/Neq

Modifié le cas Binop (Eq | Neq, e1, e2) dans typechecker.ml pour inspecter e1.edesc et e2.edesc avant de typer les expressions.
Ajout de trois branches :
Nil, Nil → erreur (interdit par spécification).
Nil, _ → on type seulement e2 et on accepte (nil prend le type de e2).
_, Nil → on type seulement e1 et on accepte (nil prend le type de e1).
Sinon → comportement normal (typage des deux, vérif d'égalité de types).
Pour les autres opérateurs (Lt, Add, And, etc.), on continue de typer e1 et e2 normalement (nil ne peut pas apparaître dans ces contextes).
Résultat : p == nil et nil == p passent maintenant la vérification de types et le test nil.go compile.



## Implémentation du ; automatique



## Grandes étapes : 


1. mgolexer.mll (Lexer)
Objectif: Éliminer l'ambiguïté entre une simple expression ident et une déclaration avec := (ex: x,y := ...).

2. mgoparser.mly (Parser Menhir)
Objectif: Supprimer les conflits shift/reduce et reduce/reduce en restructurant la grammaire des expressions et déclarations.




# Typechecker


1. Restructuration des environnements de typage
De : Trois maps séparées et mal structurées

À : Un record unifié avec sous-environnements typés

Avantage : Meilleure clarté, gestion d'erreurs unifiée, passage d'environnement unique au lieu de triplets.

2. Implémentation complète du typage des expressions
De : Skeleton avec seulement Int _ et failwith pour tous les autres cas

À : Implémentation exhaustive de type_expr :

Littéraux : Int, Bool, String, Nil
Variables : avec vérification existence et interdiction _
Accès champs : e.field avec vérification struct et champ
Allocation : new(S) avec validation struct
Unaires : - (int), ! (bool)
Binaires :
Arithmétiques (+, -, *, /, %) sur int
Comparaisons (<, <=, >, >=) sur int
Égalité/inégalité avec vérification types identiques (pas nil == nil)
Logiques (&&, ||) sur bool
Appels : vérification existence fonction, arité, types params, type retour
Print : fmt.Print(...) avec vérification expressions
3. Ajout du typage des valeurs gauches (lvalues)
Nouveau concept ajouté : type_lvalue pour expressions à gauche de :=

Permet : contrôle que seules les variables et champs peuvent être modifiés (pas 5 := 10, pas func() := x).

4. Typage complet des instructions
De : Stub failwith générique

À : check_instr exhaustif :

Expr : expression comme instruction (side effects)
Inc/Dec : ++, -- uniquement sur int
Set : affectation multiple x,y,z = e1,e2,e3 avec vérification types
If/For : condition booléenne
Block : bloc imbriqué
Vars : déclaration var x,y [ty] [= ...] avec :
Inférence de type à partir de l'initialisation
Ajout des variables au nouvel environnement
Typage du code d'initialisation
Return : vérification arité et types retour
Gestion environnement : check_instr retourne l'environnement mis à jour (pour tracer les déclarations de variables).

5. Construction d'environnements en 3 phases
Phase 1 : build_struct_env

Collecte tous les noms de structures (sans champs initialement)
Détecte doublons de structures
Phase 2a : build_func_env

Collecte signatures de fonctions (params et types retour)
Vérifie paramètres bien formés et distincts
Détecte doublons de fonctions
Phase 2b : add_struct_fields

Remplit les champs de chaque structure
Vérifie champs distincts par structure
Valide types des champs bien formés
Phase 3 : Vérification des fonctions

Pour chaque fonction : ajoute paramètres à l'environnement local
Type le corps avec environnement augmenté
6. Vérification de contraintes globales
Ajout de contrôles au niveau programme entier :

Types bien formés : check_type_bf valide int | bool | string | *structname
Pas de références circulaires : structures ne peuvent pas contenir d'instances directes
Fonction main obligatoire : sans paramètres ni types retour
Pas de redéfinitions : variables, champs, fonctions, structures uniques
7. Gestion d'erreurs améliorée
De : failwith "case not implemented" partout

À : Erreurs sémantiques précises avec localisation :

"variable X already defined"
"unknown function Y"
"field Z not in struct S"
"incompatible assignment: int := string"
"function expects N args, got M"
"expected int, got bool"
etc.
Chaque erreur inclut la location (position dans le fichier source) pour rapport utilisateur clair.

8. Support de fonctionnalités Micro-Go spécifiques
Structures avec champs typés : validation accès expr.field
Allocation dynamique : new(S) retourne *S (TStruct)
Appels de fonction : vérification signature complète
Déclarations avec typage implicite : var x = 5 infère int
Retours multiples : fonctions peuvent retourner plusieurs valeurs typées
fmt.Print : primitive d'impression sans type de retour utile