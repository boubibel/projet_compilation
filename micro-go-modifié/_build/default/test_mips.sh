#!/bin/bash
# Test script for Part 2 (MIPS code generation)

EXE=_build/default/mgoc.exe
GOFILES=$(find tests -name "*.go" ! -name "neg*" -type f | sort)

echo "=== Testing MIPS Generation (Partie 2) ==="
echo ""

# Build first
echo "Building..."
dune build @all || exit 1
echo ""

success_count=0
fail_count=0

for f in $GOFILES; do
    base=$(basename "$f" .go)
    # Utiliser le chemin du fichier .go pour trouver le .s correspondant
    s_file="${f%.go}.s"
    
    echo -n "Generating MIPS for $f ... "
    
    if ./$EXE "$f" 2>/dev/null; then
        if [ -f "$s_file" ]; then
            lines=$(wc -l < "$s_file")
            echo "✓ (generated $lines lines)"
            ((success_count++))
        else
            echo "✗ (file not created)"
            ((fail_count++))
        fi
    else
        echo "✗ (compilation failed)"
        ((fail_count++))
    fi
done

echo ""
echo "=== Summary ==="
echo "Successful: $success_count"
echo "Failed: $fail_count"

if [ $fail_count -eq 0 ]; then
    echo "All tests passed!"
    exit 0
else
    echo "Some tests failed."
    exit 1
fi
