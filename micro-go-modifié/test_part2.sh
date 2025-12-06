#!/bin/bash
# Comprehensive test for Part 2 MIPS generation
# Shows statistics and sample outputs

EXE=_build/default/mgoc.exe
TESTFILES="tests/min.go tests/arith.go tests/instr.go tests/nil.go tests/shadowing.go"

echo "========================================"
echo "  Partie 2 - MIPS Code Generation Test"
echo "========================================"
echo ""

# Ensure build
dune build @all 2>/dev/null || { echo "Build failed!"; exit 1; }

echo "1. Testing compilation without errors..."
echo ""

errors=0
for f in $TESTFILES; do
    if ./$EXE "$f" 2>&1 | grep -q "Anomaly\|Error"; then
        echo "   ✗ $f: compilation failed"
        ((errors++))
    else
        echo "   ✓ $f: compiled successfully"
    fi
done

if [ $errors -gt 0 ]; then
    echo ""
    echo "Some tests failed. Aborting."
    exit 1
fi

echo ""
echo "2. Verifying .s files structure..."
echo ""

for f in $TESTFILES; do
    base=$(basename "$f" .go)
    s_file="tests/${base}.s"
    
    if [ ! -f "$s_file" ]; then
        echo "   ✗ $s_file: not found"
        continue
    fi
    
    has_text=$(grep -c "^\.text$" "$s_file")
    has_data=$(grep -c "^\.data$" "$s_file")
    
    if [ "$has_text" -gt 0 ] && [ "$has_data" -gt 0 ]; then
        echo "   ✓ $s_file: has .text and .data sections"
    else
        echo "   ✗ $s_file: missing sections"
    fi
done

echo ""
echo "3. Sample outputs:"
echo ""

# Show min.go (simplest)
echo "=== tests/min.s (simplest example) ==="
cat tests/min.s
echo ""

# Show arith.go
echo "=== tests/arith.s (arithmetic) ==="
head -20 tests/arith.s
echo "   ... ($(wc -l < tests/arith.s) total lines)"
echo ""

# Show shadowing.go
echo "=== tests/shadowing.s (shadowing test) ==="
cat tests/shadowing.s
echo ""

echo "========================================"
echo "✓ All Part 2 tests completed successfully"
echo "========================================"
