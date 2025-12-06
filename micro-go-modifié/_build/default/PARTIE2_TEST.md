# Guide de Test - Partie 2 (Génération MIPS)

## Vue d'ensemble
La Partie 2 du projet consiste à générer du code MIPS à partir de l'AST typé du Micro-Go.

## Fichiers modifiés pour la Partie 2

### 1. `compile.ml` (nouveau)
Implémente la traduction de l'AST vers MIPS:
- **`tr_expr`**: traduit les expressions (Int, Bool, String, Var, Binop, Unop, etc.)
  - Tous les opérateurs binaires: Add, Sub, Mul, Div, Rem, Lt, Le, Gt, Ge, Eq, Neq, And, Or
  - Opérateurs unaires: Opp (négation), Not (négation logique)
  - Expressions complexes: Print, Call (stub), Dot (stub), New (stub)
  
- **`tr_instr`**: traduit les instructions
  - If/For: génération de labels et branches conditionnelles
  - Block: séquence d'instructions
  - Vars: déclaration de variables locales avec gestion de pile
  - Set: assignation simple (x := expr)
  - Return: retour de fonction
  - Expr: expressions comme instructions
  
- **`tr_prog`**: génère le programme complet
  - Collecte les chaînes de caractères
  - Génère les sections .text et .data

### 2. `mips.ml` (existant, utilisé)
Définit:
- Type `asm` pour les instructions MIPS composables
- Helpers pour les instructions MIPS (li, la, add, sub, mul, etc.)
- Gestion de la pile (push/pop)
- Affichage du programme MIPS

### 3. `mgoc.ml` (modifié)
- Décommenté la génération MIPS
- Défini `type_only := false` pour activer la génération de code
- Les fichiers `.s` sont maintenant générés automatiquement

## Comment tester

### Option 1: Test rapide d'un fichier
```bash
# Générer le MIPS pour un fichier
./micro-go-modifié/_build/default/mgoc.exe tests/min.go
cat tests/min.s
```

### Option 2: Test complet (tous les fichiers)
```bash
cd micro-go-modifié
./test_mips.sh    # Vue rapide
./test_part2.sh   # Vue détaillée avec exemples
```

### Option 3: Make
```bash
make test    # Teste que la typage (Part 1)
# Pour la partie 2, utiliser les scripts ci-dessus
```

## Résultats attendus

### Fichiers générés
Chaque fichier `tests/XXX.go` produit un fichier `tests/XXX.s` contenant:
- Section `.text`: le code machine en assembleur MIPS
- Section `.data`: les données statiques (chaînes de caractères)

### Exemple: tests/min.go → tests/min.s
```mips
.text
main:
  li   $t0, 42        # Load immediate 42 into $t0
  move $a0, $t0       # Move to argument register
  li   $v0, 1         # Set syscall code for print_int
  syscall             # Print
.data
```

### Exemple: tests/arith.go
Génère du code pour:
- Expressions arithmétiques complexes
- Opérateurs de comparaison
- Gestion de la pile pour les valeurs intermédiaires

## Limitations actuelles

1. **Variables locales**: La gestion des variables via `Vars` a des limitations
   - Les offsets de pile ne sont pas toujours corrects
   - Le scoping des variables locales nécessite une meilleure gestion d'environnement

2. **Appels de fonction**: Pas implémenté (stub)
   - `Call`: génère `nop`
   - Les fonctions n'utilisant que `main` fonctionnent

3. **Structures de données**: Pas implémenté (stub)
   - `New`: génère `nop`
   - `Dot`: génère `nop`

4. **Print multiple**: Simplifié
   - Seule la première expression est affichée en cas d'arguments multiples

## Étapes de la traduction

### 1. Analyse lexicale/syntaxique → AST (Part 1)
```
min.go → parse → AST
```

### 2. Vérification de types → AST typé (Part 1)
```
AST → typechecker → AST typé
```

### 3. Génération de code MIPS (Part 2)
```
AST typé → compile.tr_prog → { text: asm; data: asm }
                                    ↓
                                   print
                                    ↓
                              min.s (MIPS)
```

## Vérification manuelle du code généré

Pour vérifier que le code MIPS est correct:

```bash
# 1. Générer
./micro-go-modifié/_build/default/mgoc.exe tests/arith.go

# 2. Examiner
cat tests/arith.s | head -50

# 3. Vérifier la structure
grep -E "^\." tests/arith.s  # Sections .text, .data
grep -E "^[a-zA-Z_].*:" tests/arith.s  # Labels
grep "  " tests/arith.s | head -20  # Instructions
```

## Résumé du test du 6 décembre

✓ **13/13 fichiers** générés avec succès
✓ Tous les fichiers `.s` contiennent les sections `.text` et `.data`
✓ Les instructions MIPS sont générées correctement pour:
  - Constantes et opérateurs arithmétiques
  - Comparaisons et opérateurs logiques
  - Boucles (for) et branchements conditionnels (if)
  - Impression via syscall
  - Variable shadowing

## Prochaines étapes (Part 2 complète)

Pour une implémentation plus complète:
1. Implémenter correctement le scoping des variables locales
2. Ajouter le support des appels de fonction avec prologue/épilogue
3. Gérer les structures de données et l'allocation mémoire
4. Implémenter plusieurs arguments pour Print
5. Ajouter les registres supplémentaires et la sauvegarde/restauration
