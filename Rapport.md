# Projet Compilation

## Organisation du Travail

Nous avons opté pour la création d'un github partagé pour faciliter le travail de par l'intégration de git à VSCode. Le README fait office de rapport.
On y a détaillé les grandes étapes, ce que font les tests, et des problèmes rencontrés dans le développement du projet.


## Tests (10 ajoutés pour partie 1)


**Pour Tester la partie 1 : make test**
**Pour la partie 2 :**
**./test_mips.sh    pour une vue rapide**
**./test_part2.sh   vue détaillée avec exemples**

**On a également testé les fichiers mips (en .s) avec MARS**


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
**renvoi une erreur car pas de main, bon comportement**

Var.go : Calcul d'expressions à partir de plusieurs variables
Teste : déclarations de variables, assignations, expressions composées

Multi_return_assign.go : Affectation multiple depuis une fonction

Shadowing.go : Masquage de variables

For_icp.go : instr.go utilise la forme for (cond) {}, mais la forme avec init/cond/post n'est pas testée 
Teste : for (init; cond; post)

Neg_type_mismatch.go : Teste passage d'argument avec type incorrect
**renvoi une erreur car int != string, bon comportement**

Neg_return_assign_func : Teste l'affectation à une variable de l'appel d'une fonction qui renvoie 2 variabels
**renvoi une erreur car différences de type à l'assignation, bon comportement**

Nil.go : Vérifier que nil est bien pris en charge
Teste : comparaison pointeur avec nil

Logic_op : Teste de && et que le if est bien paresseux (n'évalue pas la 2eme condition du &&
quand la première est fausse)

Struct_assign.go : Assignation de variable et accès à une structure

Neg_assign_var.go : Déclare 2 fois une variable avec le même nom
**renvoi une erreur x already defined, bon comportement**

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

L'insertion automatique de point-virgule en Go suit cette règle : quand une nouvelle ligne survient après certains tokens (identifiants, constantes, return, }, ++, --, etc.), un ; est inséré automatiquement.

Une variable globale last_was_semicolon_candidate (bool) indique si le dernier token peut déclencher un point-virgule automatique. La fonction set_last met à jour ce flag selon le type de token : IDENT, INT, TRUE, RETURN, RPAR, END, etc. positionnent le flag à true.

À chaque '\n' rencontré, le lexer vérifie le flag : s'il est vrai, il retourne le token SEMI et réinitialise le flag, sinon il continue l'analyse. La même logique s'applique dans les commentaires /* */ et // : si un saut de ligne survient et que le flag est actif, un SEMI est injecté. Les point-virgules explicites réinitialisent le flag sans vérification supplémentaire.

## Grandes étapes : 


### 1. mgolexer.mll (Lexer)
Objectif: Éliminer l'ambiguïté entre une simple expression ident et une déclaration avec := (ex: x,y := ...).

### 2. mgoparser.mly (Parser)
Objectif: Supprimer les conflits shift/reduce et reduce/reduce en restructurant la grammaire des expressions et déclarations.




### Typechecker

Le typechecker implémente la vérification de types pour Micro-Go en suivant une architecture modulaire en trois phases distinctes.

La structure de données centrale est l'environnement de typage (tenv) qui maintient trois tables : struct_env pour les structures (map nom → champs), func_env pour les fonctions (map nom → signature), et vars pour les variables locales (pile de scopes permettant le masquage). Cette séparation permet de gérer proprement la portée des déclarations et les références croisées.

Le typage des expressions (type_expr) gère les cas spéciaux de Micro-Go : nil peut prendre le type de l'autre opérande dans les comparaisons, les appels de fonction peuvent retourner plusieurs valeurs (utilisable uniquement dans Print ou assignations multiples), et new(S) retourne un pointeur *S après vérification de l'existence de la structure.

Le typage des instructions (check_instr) supporte les assignations multiples avec deux modes : soit N expressions pour N variables, soit une seule expression qui est un Call retournant N valeurs. Les déclarations de variables (Vars) peuvent ne pas préciser le type si un initialisateur est fourni. L'instruction For accepte trois formes : for {}, for condition {}, et for init; cond; post {}.

La validation globale s'effectue en trois passes : (1) enregistrement des noms de structures, (2a) enregistrement des signatures de fonctions avec vérification des paramètres distincts, (2b) ajout des champs de structures avec vérification des types bien formés et champs distincts, (3) typage du corps de chaque fonction dans un environnement incluant ses paramètres. Une vérification finale s'assure que main() existe et n'a ni paramètres ni valeur de retour.

Les messages montrent la localisation précise (fichier, ligne, colonnes) pour faciliter le débugage.

### Compile.ml

Le fichier compile.ml implémente la génération de code MIPS à partir de l'AST typé de Micro-Go, en utilisant une approche de traduction directe en faisant correspondre des patterns.

La gestion des variables locales utilise une table d'association var_stack qui maintient la correspondance entre identificateurs et décalages dans la pile. Les variables sont allouées à des décalages positifs depuis $sp, permettant un accès direct via lw/sw. La fonction new_label génère des étiquettes uniques pour les sauts conditionnels et boucles, avec un compteur global incrémental.

La traduction des expressions (tr_expr) place systématiquement le résultat dans $t0, utilisant la pile pour les valeurs intermédiaires lors des opérations binaires. Les constantes entières sont chargées avec li, les chaînes sont référencées via des labels dans .data, nil est représenté par 0, et les booléens par 0/1. Les opérateurs arithmétiques et logiques sont traduits directement en instructions MIPS (add, sub, mul, div, slt, seq, etc.).

La traduction des instructions (tr_instr) gère les structures de contrôle avec des labels : If génère deux labels (then/end), For utilise deux labels pour le test et le corps de boucle. Les assignations simples (x := e) stockent le résultat dans la pile via sw. L'instruction Vars alloue l'espace pile (n*4 octets), calcule les décalages pour chaque variable, génère le code du corps, puis désalloue en restaurant l'ancien environnement. Return place la valeur dans $v0 et exécute jr $ra.

La génération de données (.data) collecte toutes les chaînes du programme via collect_strings qui parcourt récursivement les expressions et instructions, associe chaque chaîne unique à un label (_str_N), puis génère les déclarations asciiz correspondantes. Les fonctions sont traduites en labels MIPS suivis du code de leur corps.

Le programme final (tr_prog) produit une structure avec deux sections : .text contenant le code des fonctions et .data contenant les chaînes constantes.

## Mips.ml

Le fichier mips.ml définit un DSL (Domain Specific Language) interne en OCaml pour la génération de code assembleur MIPS, évitant la manipulation directe de chaînes de caractères.

Le type asm représente un arbre de syntaxe abstraite pour l'assembleur avec trois constructeurs : Nop (instruction vide), S (instruction unique sous forme de chaîne), et C (composition de deux instructions). L'opérateur infixe (@@) permet de chaîner les instructions de manière fluide et lisible, construisant un arbre binaire d'instructions qui sera aplati lors de l'impression.

Les registres MIPS sont définis comme constantes de chaînes : t0, t1 (temporaires), a0 (argument), v0 (valeur de retour), sp (pointeur de pile), ra (adresse de retour). Les fonctions génératrices d'instructions utilisent sprintf pour produire la syntaxe MIPS correcte : li pour charger une constante, la pour charger une adresse, move pour copier entre registres, add/addi/mul/slt pour l'arithmétique, lw/sw pour accéder à la mémoire, et j/jr/b/beqz/bnez pour les sauts.

Les utilitaires push/pop encapsulent la gestion de la pile : push décrémente sp de 4 octets puis stocke le registre, pop charge depuis la pile puis incrémente sp. Les directives assembleur (label, comment, dword, asciiz) génèrent les déclarations nécessaires pour les sections .text et .data.

La fonction print_program parcourt récursivement l'arbre asm en profondeur, émettant d'abord la section .text puis .data vers un canal de sortie formaté. Le type program structure le code en deux sections distinctes, simplifiant la génération du fichier assembleur final avec la disposition standard MIPS.