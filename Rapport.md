# Projet Compilation

Lucas Iltis / 
Abel Julin /
LDD3-IM

## Organisation du Travail

Nous avons opté pour la création d'un github partagé pour faciliter le travail de par l'intégration de git à VSCode. Ce fichier MarkDown fait office de rapport.
On y a détaillé les grandes étapes, ce que font les tests, et des problèmes rencontrés dans le développement du projet.


## Tests (10 ajoutés pour partie 1)


**Pour Tester la partie 1 : make test**
**Pour la partie 2 :**
**Nous avons testé les fichiers mips (en .s) avec MARS**
**Nous avons utilisé l'intelligence artificielle pour créer un script permettant de créer les fichiers mips. Et également pour la création de certains tests pour être sûr de couvrir tous les cas de figures et pour débugger div.s**


On a enlevé du make test les tests relevant une erreur pour permettre d'executer tous les tests qui passent, on vérifie les tests relevant une erreur un par un avec :
**./_build/default/mgoc.exe tests/nom.go**
en vérifiant qu'il relève bien l'erreur voulue

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

## Tests Partie 2

**./make_mips.sh pour créer les fichiers MIPS**

Pour la partie 2, nous avons rajouté beaucoup de tests, essentiellement pour corriger le problème lors de la création de div.s. Il n'affichait pas le bon résultat dans MARS, nous avons donc dû séparés chacunes des 3 fonctions dans des fichiers séparés pour vérifier leur bon comportement une à une. Nous avons ensuite testé chaque fichier dans MARS en vérifiant que la valeur renvoyée était bien la bonne.


## Commandes :
- Executer fichier de test : go run tests/nom.go
- Vérifie le type un par un : ./_build/default/mgoc.exe --type-only tests/nom.go
- Crée le fichier mips en .s ./_build/default/mgoc.exe tests/nom.go
- Crée tous les fichiers mips : ./make_mips.sh


# Problèmes rencontrés :

## Teste de masquage dans shadowing.go :

Problème : une déclaration intérieure x := ... dans un bloc était rejetée par le compilateur (erreur « variable x already defined »).
Cause : le typechecker utilisait une seule table globale de variables; toute nouvelle declaration était comparée à l'ensemble global, empêchant le masquage lexical.
Ainsi, tests/shadowing.go ne passait pas alors que le code était valide en Micro‑Go attendu.
Solution : remplacer la table globale par une pile de tables (liste de maps) dans typechecker.ml.
Détail : add_var n’ajoute plus que dans la portée courante (top de la pile); find_var cherche du sommet vers la base.
Portée : on pousse une nouvelle table (scope) avant de typer les Block, les branches If et les corps For, et on la pop après vérification.
Résultat : les déclarations locales peuvent masquer des noms externes sans erreur, et les variables externes restent accessibles hors de la portée et shadowing.go passe les tests de typage.

## Typage de nil dans les comparaisons

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



# Implémentation du ; automatique

L'insertion automatique de point-virgule en Go suit cette règle : quand une nouvelle ligne survient après certains tokens (identifiants, constantes, return, }, ++, --, etc.), un ; est inséré automatiquement.

Une variable globale last_was_semicolon_candidate (bool) indique si le dernier token peut déclencher un point-virgule automatique. La fonction set_last met à jour ce flag selon le type de token : IDENT, INT, TRUE, RETURN, RPAR, END, etc. positionnent le flag à true.

À chaque '\n' rencontré, le lexer vérifie le flag : s'il est vrai, il retourne le token SEMI et réinitialise le flag, sinon il continue l'analyse. La même logique s'applique dans les commentaires /* */ et // : si un saut de ligne survient et que le flag est actif, un SEMI est injecté. Les point-virgules explicites réinitialisent le flag sans vérification supplémentaire.

# Grandes étapes : 


## mgolexer.mll (Lexer)

Le lexer transforme le flux de caractères en tokens reconnaissables par le parser. Il gère d'abord les mots-clés (if, for, return, func, struct, etc.) et les opérateurs (&&, ||, ==, :=, ++, --). Les identifiants sont distingués des mots-clés via une table de hachage. Les constantes sont reconnues : entiers décimaux/hexadécimaux, booléens (true/false), chaînes avec échappements (\n, \t, ", \), et nil.

L'insertion automatique de point-virgule suit la règle Go : un flag last_was_semicolon_candidate mémorise si le dernier token peut déclencher un ; automatique (IDENT, INT, RETURN, }, ++, --). À chaque '\n' rencontré, si le flag est vrai, un token SEMI est injecté automatiquement avant de continuer.

Les commentaires sont gérés de deux façons : // consomme jusqu'à la fin de ligne (avec insertion de ; si nécessaire), et /* */ peut être multi-lignes (avec même logique d'insertion). Les espaces, tabulations et retours chariot sont ignorés. La position (ligne, colonne) est maintenue via Lexing.lexeme_start_p pour les messages d'erreur précis du typechecker.

## mgoparser.mly (Parser)

Le parser construit l'AST à partir des tokens du lexer en suivant la grammaire Micro-Go. La structure principale est file → liste de déclarations (structures et fonctions), avec vérification que main() existe et correspond à la signature attendue.

Les déclarations de structures (struct S { champs }) et de fonctions (func f(params) returns { body }) sont parsées avec leurs types. Les paramètres peuvent avoir plusieurs identifiants partageant le même type (a, b int). Les valeurs de retour multiples sont supportées via une liste de types.

Les expressions suivent la priorité des opérateurs Go : OR (||) < AND (&&) < comparaisons (==, !=, <, <=, >, >=) < addition/soustraction < multiplication/division/modulo < unaires (!, -) < primaires (appels, accès champs, new). Cette hiérarchie élimine les conflits shift/reduce.

Les instructions incluent : blocs { stmts }, conditionnelles if expr { } else { }, boucles for (trois formes : infinie, avec condition, avec init/cond/post), assignations simples/multiples (x := e ou x, y := a, b), déclarations de variables (var x, y typ := init), return avec valeurs multiples, et incréments/décréments.

L'ambiguïté x := e vs simple expression est résolue au niveau lexical : := est un token unique COLONEQ. Les listes d'expressions/identifiants utilisent des séparateurs virgules avec règles non-ambiguës. Les parenthèses forcent la priorité et permettent les expressions complexes. Le parser génère directement l'AST typé (mgoast.ml) avec positions pour le typechecker.


### typechecker.ml

Le typechecker implémente la vérification de types pour Micro-Go en suivant une architecture modulaire en trois phases distinctes.

La structure de données centrale est l'environnement de typage (tenv) qui maintient trois tables : struct_env pour les structures (map nom → champs), func_env pour les fonctions (map nom → signature), et vars pour les variables locales (pile de scopes permettant le masquage). Cette séparation permet de gérer proprement la portée des déclarations et les références croisées.

Le typage des expressions (type_expr) gère les cas spéciaux de Micro-Go : nil peut prendre le type de l'autre opérande dans les comparaisons, les appels de fonction peuvent retourner plusieurs valeurs (utilisable uniquement dans Print ou assignations multiples), et new(S) retourne un pointeur *S après vérification de l'existence de la structure.

Le typage des instructions (check_instr) supporte les assignations multiples avec deux modes : soit N expressions pour N variables, soit une seule expression qui est un Call retournant N valeurs. Les déclarations de variables (Vars) peuvent ne pas préciser le type si un initialisateur est fourni. L'instruction For accepte trois formes : for {}, for condition {}, et for init; cond; post {}.

La validation globale s'effectue en trois passes : (1) enregistrement des noms de structures, (2a) enregistrement des signatures de fonctions avec vérification des paramètres distincts, (2b) ajout des champs de structures avec vérification des types bien formés et champs distincts, (3) typage du corps de chaque fonction dans un environnement incluant ses paramètres. Une vérification finale s'assure que main() existe et n'a ni paramètres ni valeur de retour.

Les messages montrent la localisation précise (fichier, ligne, colonnes) pour faciliter le débugage.

## compile.ml


1. Variables globales

var_stack : table associative (nom → offset/$sp) pour les variables locales
func_table : Hashtbl (nom_fonction → nb_retours) pour détecter retours multiples
struct_defs : liste des définitions de structures pour accès aux champs
string_map : collecte des chaînes littérales pour la section .data

2. Traduction des expressions (tr_expr)

Constantes (Int, Bool, String, Nil) → chargement immédiat ou label
Variables → lw depuis pile via offset dans var_stack
Binop → évaluation court-circuit pour And/Or, sinon push/pop avec ajustement var_stack
Call → empile args avec ajustement récursif de var_stack, jal, cleanup, résultat dans $v0
Dot → accès champ structure avec offset dynamique
New → allocation heap via syscall 9 (sbrk)
Print → détecte retours multiples via func_table, affiche $v0 et $v1 si besoin

3. Traduction des instructions (tr_instr)

If/For/Block → gestion branches + cleanup variables locales avec sauvegarde/restauration var_stack
Set → assignation simple, champs structures, ou assignation multiple avec push récursif
Inc/Dec → sur variables ou champs structures
Vars → alloue sur pile, ajuste offsets, cas spécial pour init par call multi-retour
Return → nettoie locals, restaure $ra, place valeurs dans $v0/$v1, jr $ra

4. Traduction des fonctions (tr_fun)

Initialise var_stack avec paramètres (ordre inversé : dernier arg = 0($sp))
Sauve $ra et ajuste offsets (+4)
Traduit corps avec tr_seq
Ajoute return implicite si absent

5. Point d'entrée et données

tr_prog : collecte structures/fonctions, jal main, syscall exit
tr_data : génère labels pour strings avec échappement
Bug critique résolu : var_stack non ajusté pendant push d'arguments → offsets erronés → valeurs corrompues. Solution : fonction récursive push_args_rec qui ajuste après chaque push.

## Mips.ml

Le fichier mips.ml définit un DSL (Domain Specific Language) interne en OCaml pour la génération de code assembleur MIPS, évitant la manipulation directe de chaînes de caractères.

Le type asm représente un arbre de syntaxe abstraite pour l'assembleur avec trois constructeurs : Nop (instruction vide), S (instruction unique sous forme de chaîne), et C (composition de deux instructions). L'opérateur infixe (@@) permet de chaîner les instructions de manière fluide et lisible, construisant un arbre binaire d'instructions qui sera aplati lors de l'impression.

Les registres MIPS sont définis comme constantes de chaînes : t0, t1 (temporaires), a0 (argument), v0 (valeur de retour), sp (pointeur de pile), ra (adresse de retour). Les fonctions génératrices d'instructions utilisent sprintf pour produire la syntaxe MIPS correcte : li pour charger une constante, la pour charger une adresse, move pour copier entre registres, add/addi/mul/slt pour l'arithmétique, lw/sw pour accéder à la mémoire, et j/jr/b/beqz/bnez pour les sauts.

Les utilitaires push/pop encapsulent la gestion de la pile : push décrémente sp de 4 octets puis stocke le registre, pop charge depuis la pile puis incrémente sp. Les directives assembleur (label, comment, dword, asciiz) génèrent les déclarations nécessaires pour les sections .text et .data.

La fonction print_program parcourt récursivement l'arbre asm en profondeur, émettant d'abord la section .text puis .data vers un canal de sortie formaté. Le type program structure le code en deux sections distinctes, simplifiant la génération du fichier assembleur final avec la disposition standard MIPS.
