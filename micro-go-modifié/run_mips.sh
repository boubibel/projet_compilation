#!/bin/bash
# Script pour exécuter un fichier .s avec MARS ou SPIM

if [ $# -eq 0 ]; then
    echo "Usage: ./run_mips.sh <fichier.s>"
    exit 1
fi

FILE="$1"

if [ ! -f "$FILE" ]; then
    echo "Erreur: fichier $FILE introuvable"
    exit 1
fi

# Chercher MARS
MARS_JAR=""
if [ -f "Mars4_5.jar" ]; then
    MARS_JAR="Mars4_5.jar"
elif [ -f "Mars.jar" ]; then
    MARS_JAR="Mars.jar"
elif [ -f "../Mars4_5.jar" ]; then
    MARS_JAR="../Mars4_5.jar"
elif [ -f "../Mars.jar" ]; then
    MARS_JAR="../Mars.jar"
fi

# Essayer MARS d'abord
if [ -n "$MARS_JAR" ] && command -v java &> /dev/null; then
    echo "=== Exécution avec MARS ==="
    java -jar "$MARS_JAR" "$FILE"
# Sinon essayer SPIM
elif command -v spim &> /dev/null; then
    echo "=== Exécution avec SPIM ==="
    spim -file "$FILE"
else
    echo "Erreur: Aucun simulateur MIPS trouvé."
    echo ""
    echo "Options:"
    echo "1. Télécharger MARS: http://courses.missouristate.edu/kenvollmar/mars/"
    echo "   Placer Mars.jar dans ce dossier"
    echo "2. Installer SPIM: brew install spim"
    echo "3. Utiliser MARS en ligne: https://kobzol.github.io/davis/"
    exit 1
fi
