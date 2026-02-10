#!/bin/bash

# =============================================================
# SCRIPT D'AUDIT TECHNIQUE FLUTTER
# Auteur : William Lowe
# Date   : 10/02/2026
# =============================================================

# Couleurs pour le terminal
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # Pas de couleur

# Nom du dossier de sortie
OUTPUT_DIR="rapports_audit"

echo -e "${BLUE}===============================================================${NC}"
echo -e "${BLUE}        LANCEMENT DE L'AUDIT COMPLET           ${NC}"
echo -e "${YELLOW}      Auditeur : William Lowe                         ${NC}"
echo -e "${BLUE}===============================================================${NC}"

# 0. Création du dossier de rapport
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
    echo -e "${GREEN}[0/5] Dossier '$OUTPUT_DIR' créé.${NC}"
fi

# 1. Nettoyage et préparation
echo -e "\n${GREEN}[1/5] Préparation du projet...${NC}"
flutter pub get
# Utilisation de dart run pour les versions récentes
dart run build_runner build --delete-conflicting-outputs

# 2. Analyse statique (Qualité & Sécurité)
echo -e "\n${GREEN}[2/5] Analyse statique avec Pana...${NC}"
if ! command -v pana &> /dev/null; then
    echo -e "${YELLOW}Installation de Pana en cours...${NC}"
    dart pub global activate pana
fi
export PATH="$PATH":"$HOME/.pub-cache/bin"

# On génère le markdown temporaire dans le dossier rapport
pana . --no-warning > "$OUTPUT_DIR/audit_brut.md"

# 3. Génération du HTML avec Pandoc
echo -e "\n${GREEN}[3/5] Génération du rapport HTML...${NC}"
if command -v pandoc &> /dev/null; then
    pandoc "$OUTPUT_DIR/audit_brut.md" -s \
    --metadata title="Rapport d'Audit Technique" \
    -c https://cdn.jsdelivr.net/npm/water.css@2/out/water.css \
    -o "$OUTPUT_DIR/rapport_qualite_final.html"
    
    # Nettoyage du fichier brut
    rm "$OUTPUT_DIR/audit_brut.md"
    echo -e "${GREEN}-> Fichier $OUTPUT_DIR/rapport_qualite_final.html créé.${NC}"
else
    echo -e "${RED}Erreur: Pandoc n'est pas installé. Rapport HTML impossible.${NC}"
fi

# 4. Tests et Couverture de code
echo -e "\n${GREEN}[4/5] Tests unitaires et couverture...${NC}"
flutter test --coverage
if [ -d "coverage" ]; then
    # On génère le HTML de couverture directement dans notre dossier rapports
    genhtml coverage/lcov.info -o "$OUTPUT_DIR/couverture_html"
    echo -e "${GREEN}-> Rapport de couverture : $OUTPUT_DIR/couverture_html/index.html${NC}"
else
    echo -e "${RED}Erreur: Aucun test n'a pu générer de couverture.${NC}"
fi

# 5. Résumé final
echo -e "\n${BLUE}===============================================================${NC}"
echo -e "${GREEN}AUDIT TERMINÉ AVEC SUCCÈS !${NC}"
echo -e "Livrables disponibles dans le dossier : ${YELLOW}$OUTPUT_DIR/${NC}"
echo -e "1. Rapport de Qualité : ${BLUE}rapport_qualite_final.html${NC}"
echo -e "2. Dossier Couverture : ${BLUE}couverture_html/index.html${NC}"
echo -e "${BLUE}===============================================================${NC}"