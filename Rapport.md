# Projet Compilation

## Organisation du Travail

Nous avons opté pour la création d'un github partagé pour faciliter le travail de par l'intégration de git à VSCode. Le README fait office de rapport.
On y a détaillé les grandes étapes, ce que font les tests, et des problèmes rencontrés dans le développement du projet.


## Tests (10 ajoutés pour partie 1)


**Pour Tester la partie 1 : make test**
**Pour la partie 2 :**
**Nous avons testé les fichiers mips (en .s) avec MARS**
**Nous avons utilisé l'intelligence artificielle pour créer un script permettant de créer les fichiers mips. Et également pour la création de certains tests pour être sûrs de couvrir tous les cas de figures**


On a enlevé du make test les tests relevant une erreur pour permettre d'executer tous les tests qui passent, on vérifie les tests relevant une erreur un par un avec :
**./_build/default/mgoc.exe -- type-only tests/nom.go**

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

Nous avons créer beaucoup de tests dans la Partie 2, essentiellement pour régler le problème lié à div.go qui ne renvoyait pas les bonnes valeurs lors de l'éxecution dans MARS. On a ainsi séparé les 3 fonctions dans plusieurs fichiers pour tester leurs comportements séparément.

**./make_mips.sh pour créer les fichiers MIPS**


## Commandes :
- Executer fichier de test : go run tests/nom.go
- ./make_mips.sh pour créer tous les fichiers MIPS
- Tester typage : ./_build/default/mgoc.exe -- type-only tests/nom.go
- Construire le mips un par un : ./_build/default/mgoc.exe tests/nom.go





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


### mgolexer.mll (Lexer)

Gestion des mots-clés : Création d'une table de hachage pour identifier les mots-clés Go (package, func, if, for, return, etc.) et les distinguer des identifiants simples.

Parsing des entiers : Implémentation du support des littéraux entiers décimaux et hexadécimaux (0x/0X) avec validation des bornes (0 à 2⁶³-1).

Gestion des chaînes : Mise en place d'un buffer pour construire les chaînes de caractères avec support des séquences d'échappement (\n, \t, \", \\).

Injection automatique de points-virgules : Système avec un flag last_was_semicolon_candidate pour insérer automatiquement des ; après certains tokens (identifiants, littéraux, return, ++, --, ), }).

Gestion des commentaires : Implémentation de deux types de commentaires (multi-ligne /* */ et ligne simple //) avec intégration du système d'injection de points-virgules.

Reconnaissance des opérateurs : Distinction entre opérateurs multi-caractères (&&, ||, ==, !=, <=, >=, ++, --) et simples (+, -, *, /, %, !, =).

Traitement spécial pour := : Détection des listes d'identifiants séparées par des virgules suivies de := pour générer un token IDS_DECL (déclaration courte).

Gestion des retours à la ligne : Suivi des nouvelles lignes pour la localisation d'erreurs et l'injection contextuelle de points-virgules.

Tokens de ponctuation : Reconnaissance des délimiteurs ((, ), {, }, ;, ,, .) essentiels pour la structure syntaxique.

Gestion d'erreurs : Levée d'exceptions avec messages explicites pour caractères inconnus, littéraux invalides, commentaires et chaînes non terminés.

### mgoparser.mly (Parser)

Déclaration des tokens et priorités : Définition de tous les tokens du lexer et établissement des règles de priorité/associativité pour les opérateurs (%left, %right, %nonassoc).

Structure du programme : Règle prog pour parser la déclaration package, l'import optionnel de fmt et la liste des déclarations globales (structures et fonctions).

Définition des structures : Parser pour type ident struct { fields } avec gestion de listes de champs de la forme ident+ type séparés par des points-virgules.

Système de types : Règle typ pour reconnaître les types de base (int, bool, string) et les types structurés (pointeurs *ident).

Déclarations de fonctions : Parser pour func ident(params) return_type? bloc avec support des paramètres multiples et retours multiples (tuple).

Gestion des blocs : Structure { (instr ;)* instr? } permettant des blocs vides ou avec instructions séparées par des points-virgules (le dernier étant optionnel).

Instructions de contrôle : Implémentation de if/else, for (avec ou sans condition), var (avec type et initialisation optionnels), et return avec valeurs multiples.

Instructions simples : Support des expressions, incréments/décréments (++/--), affectations multiples (x,y = e1,e2) et déclarations courtes (x,y := e1,e2).

Expressions complexes : Système d'expressions avec opérateurs binaires (arithmétiques, logiques, comparaisons) et unaires (négation -, !), accès aux champs (.), appels de fonctions.

Cas spéciaux : Gestion de new(StructName) pour l'allocation, fmt.Print(...) pour l'affichage, et construction d'AST avec localisation (loc) pour chaque nœud syntaxique.



### Typechecker

Le typechecker implémente la vérification de types pour Micro-Go en suivant une architecture modulaire en trois phases distinctes.

La structure de données centrale est l'environnement de typage (tenv) qui maintient trois tables : struct_env pour les structures (map nom → champs), func_env pour les fonctions (map nom → signature), et vars pour les variables locales (pile de scopes permettant le masquage). Cette séparation permet de gérer proprement la portée des déclarations et les références croisées.

Le typage des expressions (type_expr) gère les cas spéciaux de Micro-Go : nil peut prendre le type de l'autre opérande dans les comparaisons, les appels de fonction peuvent retourner plusieurs valeurs (utilisable uniquement dans Print ou assignations multiples), et new(S) retourne un pointeur *S après vérification de l'existence de la structure.

Le typage des instructions (check_instr) supporte les assignations multiples avec deux modes : soit N expressions pour N variables, soit une seule expression qui est un Call retournant N valeurs. Les déclarations de variables (Vars) peuvent ne pas préciser le type si un initialisateur est fourni. L'instruction For accepte trois formes : for {}, for condition {}, et for init; cond; post {}.

La validation globale s'effectue en trois passes : (1) enregistrement des noms de structures, (2a) enregistrement des signatures de fonctions avec vérification des paramètres distincts, (2b) ajout des champs de structures avec vérification des types bien formés et champs distincts, (3) typage du corps de chaque fonction dans un environnement incluant ses paramètres. Une vérification finale s'assure que main() existe et n'a ni paramètres ni valeur de retour.

Les messages montrent la localisation précise (fichier, ligne, colonnes) pour faciliter le débugage.

### Compile.ml


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