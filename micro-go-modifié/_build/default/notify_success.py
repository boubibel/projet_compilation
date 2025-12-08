#!/usr/bin/env python3
"""
Script pour jouer un son de succès
"""
import subprocess
import sys

def play_success_sound():
    """Joue un son de succès sur macOS"""
    try:
        # Son système macOS (Funk = klaxon)
        subprocess.run(['afplay', '/System/Library/Sounds/Funk.aiff'], check=True)
    except FileNotFoundError:
        # Fallback: utiliser le beep terminal
        print('\a', flush=True)
    except Exception as e:
        print(f"Erreur lors de la lecture du son: {e}", file=sys.stderr)
        print('\a', flush=True)

if __name__ == "__main__":
    play_success_sound()
