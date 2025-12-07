#!/bin/bash
# Script pour exécuter un fichier .s avec SPIM

if [ $# -eq 0 ]; then
    echo "Usage: ./run_mips.sh <fichier.s>"
    exit 1
fi

FILE="$1"

if [ ! -f "$FILE" ]; then
    echo "Erreur: fichier $FILE introuvable"
    exit 1
fi

# Vérifier si spim est installé
if command -v spim &> /dev/null; then
    echo "=== Exécution avec SPIM ==="
    spim -file "$FILE"
else
    echo "SPIM n'est pas installé."
    echo "Pour installer: brew install spim"
    echo ""
    echo "Ou utilise MARS en ligne: https://www.cs.cornell.edu/courses/cs3410/2019sp/tools/mips/"
    exit 1
fi
