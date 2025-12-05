# Projet Compilation


1. mgolexer.mll (Lexer)
Objectif: Éliminer l'ambiguïté entre une simple expression ident et une déclaration avec := (ex: x,y := ...).

2. mgoparser.mly (Parser Menhir)
Objectif: Supprimer les conflits shift/reduce et reduce/reduce en restructurant la grammaire des expressions et déclarations.




# Grandes étapes des transformations du Typechecker


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