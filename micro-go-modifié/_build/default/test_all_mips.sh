#!/bin/bash

echo "=== Testing all MIPS files ==="
echo ""

passed=0
failed=0
errors=()

for f in tests/*.s; do
    name=$(basename "$f")
    echo -n "Testing $name ... "
    
    # Exécuter avec timeout de 2 secondes
    output=$(gtimeout 2s ./run_mips.sh "$f" 2>&1)
    exit_code=$?
    
    if [ $exit_code -eq 124 ]; then
        echo "❌ TIMEOUT (boucle infinie?)"
        ((failed++))
        errors+=("$name: TIMEOUT")
    elif echo "$output" | grep -q "Error in\|Runtime exception\|Processing terminated due to errors"; then
        error_msg=$(echo "$output" | grep -E "Error in|Runtime exception" | head -1 | cut -c1-80)
        echo "❌ $error_msg"
        ((failed++))
        errors+=("$name: RUNTIME ERROR")
    elif [ $exit_code -ne 0 ]; then
        echo "❌ Exit code: $exit_code"
        ((failed++))
        errors+=("$name: EXIT ERROR")
    else
        result=$(echo "$output" | grep -v "MARS\|Copyright\|===" | grep -v "^$" | tail -1)
        echo "✅ Output: $result"
        ((passed++))
    fi
done

echo ""
echo "=== Summary ==="
echo "Passed: $passed"
echo "Failed: $failed"
echo ""

if [ $failed -gt 0 ]; then
    echo "Failed tests:"
    for err in "${errors[@]}"; do
        echo "  - $err"
    done
    exit 1
fi

echo "All tests passed!"
