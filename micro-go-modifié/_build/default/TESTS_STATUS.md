# État des tests MIPS

## Tests qui fonctionnent correctement ✓

Les fichiers suivants génèrent du code MIPS correct et s'exécutent dans MARS/SPIM :

- **arith.go** : Opérations arithmétiques simples
- **debug.go** : Tests de débogage
- **for_icp.go** : Boucles for simples
- **instr.go** : Instructions de base
- **logic_op.go** : Opérateurs logiques (&&, ||, !)
- **min.go** : Calcul de minimum
- **shadowing.go** : Portée des variables (shadowing)
- **simple_div.go** : Division simple sans récursion
- **simple_var.go** : Variables simples
- **var.go** : Déclarations de variables

## Tests avec limitations ⚠️

### div.go - Fonctionnalités avancées non implémentées

Ce fichier utilise :
1. **Retours multiples** : `return x, y` - seule la première valeur est retournée
2. **Assignations multiples** : `x, y := div1(a, b)` - non supporté, génère `nop`
3. **Récursion** : `div1` s'appelle récursivement - fonctionne grâce à la sauvegarde de `$ra`
4. **Structures** : `new(res)`, `r.quo`, `r.rem` - non implémenté, retourne 0

**Résultat attendu vs obtenu :**
- `div1(45, 6)` devrait retourner `(7, 3)` mais retourne seulement `7` (première valeur)
- `div2(45, 6)` devrait retourner `(7, 3)` mais retourne seulement `7`
- `div3(45, 6)` ne fonctionne pas car utilise des structures

### Tests avec structures/pointeurs

Les fichiers suivants compilent mais ne s'exécutent pas correctement :
- **point.go** : Utilise des structures
- **struct_assign.go** : Assignations de structures
- **nil.go** : Tests de pointeurs nil

## Fonctionnalités implémentées ✓

- Variables locales et paramètres de fonction
- Opérations arithmétiques : +, -, *, /, %
- Opérations logiques : &&, ||, !, <, <=, >, >=, ==, !=
- Structures de contrôle : if/else, for
- Blocs et portée des variables (shadowing)
- Appels de fonction simples
- Récursion (avec sauvegarde de `$ra`)
- Incrémentation/décrémentation : `x++`, `x--`
- Strings littérales avec `fmt.Print`
- Initialisation de `$sp` pour MARS/SPIM

## Fonctionnalités non implémentées ✗

- **Retours multiples** : `return x, y` - seule la première valeur est retournée dans `$v0`
- **Assignations multiples** : `x, y := f()` - génère `nop`
- **Structures** : `new(Type)`, accès aux champs `obj.field`
- **Inc/Dec sur champs** : `obj.field++` - génère un commentaire
- **Pointeurs** : déréférencement, opérations sur pointeurs
- **Court-circuit pour && et ||** : les deux opérandes sont toujours évalués

## Notes techniques

1. **Pile** : Initialisée à `0x7fffeffc` (2147479548)
2. **Convention d'appel** : Arguments passés sur la pile, résultat dans `$v0`
3. **Sauvegarde de `$ra`** : Automatique pour toutes les fonctions sauf `main`
4. **Strings** : Stockées dans `.data` avec labels `_str_0`, `_str_1`, etc.
5. **Syscalls** :
   - `syscall 1` : afficher un entier
   - `syscall 4` : afficher une string
   - `syscall 10` : terminer le programme

## Compilation

```bash
# Compiler un fichier
./mgoc.exe tests/fichier.go

# Générer fichier.s dans tests/

# Tester tous les fichiers
./test_mips.sh
```

## Exécution dans MARS

1. Ouvrir MARS
2. File → Open → sélectionner le fichier `.s`
3. Run → Assemble
4. Run → Go (ou F5)
5. Voir la sortie dans "Run I/O"
