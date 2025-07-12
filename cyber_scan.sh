#!/bin/bash

# ==== 🎨 COULEURS ====
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
NC='\033[0m' # No Color

clear

# ==== 🖋️ SIGNATURE ====
echo -e "${CYAN}"
echo "╔══════════════════════════════════════╗"
echo "║ 🔐 CYBER SCAN TOOL - Projet Certif   ║"
echo "║ 📍 Made by Issam Belayachi           ║"
echo "╚══════════════════════════════════════╝"
echo -e "${NC}"

# 📦 Installer les dépendances automatiquement
install_if_missing() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${YELLOW}📦 $1 n'est pas installé. Installation...${NC}"
        sudo apt update && sudo apt install "$1" -y
    else
        echo -e "${GREEN}✔ $1 est déjà installé.${NC}"
    fi
}

# 🔧 Vérifie les outils nécessaires
for tool in nikto whatweb dirb gobuster wireshark; do
    install_if_missing "$tool"
done

# ==== 🎯 Entrée utilisateur ====
read -p "🌐 Entrez le domaine ou IP cible (ex: site.com ou 192.168.1.100) : " RAW_TARGET
RAW_TARGET=$(echo "$RAW_TARGET" | sed -e 's~http[s]*://~~g' | sed -e 's~/$~~')

echo -e "\n🔧 Choisissez le protocole :"
select PROTO in "http" "https"; do
    [[ "$PROTO" == "http" || "$PROTO" == "https" ]] && break
done

TARGET="$PROTO://$RAW_TARGET"

echo -e "\n🛠️ Choisissez l'outil de scan :"
select TOOL in "Nikto" "WhatWeb" "Dirb" "Gobuster" "Tous"; do
    [[ "$TOOL" =~ ^(Nikto|WhatWeb|Dirb|Gobuster|Tous)$ ]] && break
done

# 🌐 Détection interface si root
if [ "$EUID" -eq 0 ]; then
    INTERFACES=$(ip -o link show | awk -F': ' '{print $2}' | grep -v lo)
    echo -e "\n📡 Interfaces détectées : ${YELLOW}$INTERFACES${NC}"
    read -p "🎥 Interface Wireshark (laisser vide pour ignorer) : " INTERFACE
else
    echo -e "\n${RED}⚠️ Wireshark désactivé : exécute le script avec sudo.${NC}"
    INTERFACE=""
fi

# ⚙️ Forcer les erreurs ?
read -p "⚠️ Forcer même en cas d'erreur ? (y/n) : " FORCE
FORCE=$(echo "$FORCE" | tr '[:upper:]' '[:lower:]')

# ==== 🔎 AFFICHAGE ====
echo -e "${BLUE}"
echo "═══════════════════════════════════════"
echo -e "📌 Cible        : ${YELLOW}$TARGET${BLUE}"
echo -e "🔧 Outil choisi : ${YELLOW}$TOOL${BLUE}"
echo -e "📡 Interface    : ${YELLOW}${INTERFACE:-Non}${BLUE}"
echo -e "🚨 Forcer erreurs : ${YELLOW}$FORCE${BLUE}"
echo "═══════════════════════════════════════"
echo -e "${NC}"

# ==== 🎥 Capture Wireshark ====
if [ "$EUID" -eq 0 ] && [ -n "$INTERFACE" ]; then
    echo -e "${MAGENTA}🎥 Capture réseau lancée sur $INTERFACE pendant 60s...${NC}"
    timeout 60 wireshark -i "$INTERFACE" -k -w "/tmp/capture_issam.pcapng" >/dev/null 2>&1 &
    sleep 2
fi

# ==== 🚀 Fonctions de scan ====
run_nikto() {
    echo -e "${CYAN}\n🔍 Nikto Scan:${NC}"
    nikto -h "$TARGET"
}

run_whatweb() {
    echo -e "${CYAN}\n🧬 WhatWeb Fingerprinting:${NC}"
    whatweb "$TARGET"
}

run_dirb() {
    echo -e "${CYAN}\n📂 Dirb Scan:${NC}"
    dirb "$TARGET"
}

run_gobuster() {
    echo -e "${CYAN}\n🕵️ Gobuster Scan:${NC}"
    read -p "📄 Chemin wordlist (ex: /usr/share/wordlists/dirb/common.txt) : " WORDLIST
    gobuster dir -u "$TARGET" -w "$WORDLIST"
}

# ==== 🔁 Exécution ====
case $TOOL in
    Nikto) run_nikto ;;
    WhatWeb) run_whatweb ;;
    Dirb) run_dirb ;;
    Gobuster) run_gobuster ;;
    Tous)
        run_nikto
        run_whatweb
        run_dirb
        run_gobuster
        ;;
esac

# ==== ✅ Fin ====
echo -e "${GREEN}\n✅ Scan terminé.${NC}"
[ "$EUID" -eq 0 ] && [ -n "$INTERFACE" ] && echo -e "📁 Capture réseau enregistrée dans ${YELLOW}/tmp/capture_issam.pcapng${NC}"

# ==== 🖋️ Signature finale ====
echo -e "\n${MAGENTA}"
echo "═══════════════════════════════════════"
echo "✨ Outil développé avec passion par Issam Belayachi ✨"
echo "═══════════════════════════════════════"
echo -e "${NC}"
