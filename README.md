# 🔐 CyberScan - Outil d'Audit Web Professionnel

🎯 CyberScan est un script **bash tout-en-un** développé par *Issam Belayachi* pour réaliser un **scan de sécurité complet sur un site web**. Il combine plusieurs outils d'audit reconnus : Nikto, WhatWeb, Dirb, Gobuster, et Wireshark pour capturer le trafic.

> ⚡️ Simple, rapide, visuel et 100% en ligne de commande !

---

## 🧰 Fonctionnalités

✅ **Scan de vulnérabilités** avec [Nikto](https://cirt.net/Nikto2)  
🧬 **Fingerprinting** du serveur avec [WhatWeb](https://github.com/urbanadventurer/WhatWeb)  
🗂️ **Recherche de chemins cachés** avec [Dirb](https://tools.kali.org/web-applications/dirb) ou [Gobuster](https://github.com/OJ/gobuster)  
📡 **Capture réseau automatique** avec [Wireshark](https://www.wireshark.org/) *(si root)*  
🌐 Support **HTTP/HTTPS**  
🎨 Interface en ligne de commande **visuelle et professionnelle**  
🧾 Signature personnalisée : *"Made by Issam Belayachi"*

---

## 📦 Installation

Clone le projet :

```bash
git clone https://github.com/issambelayachi/CyberScan.git
cd CyberScan
chmod +x cyber_scan.sh
```
Lance le script :

bash
Copier
Modifier
sudo ./cyber_scan.sh
Le mode sudo est requis pour lancer la capture réseau avec Wireshark.

🖥️ Dépendances
Le script installe automatiquement les outils suivants s’ils ne sont pas présents :

nikto

whatweb

dirb

gobuster

wireshark

curl, ip, etc.

🧪 Testé sous Ubuntu / Debian

🚀 Utilisation
Le script est interactif : il vous guidera étape par étape.

📍 Exemple de lancement :
bash
Copier
Modifier
sudo ./cyber_scan.sh
✅ Étapes :
Choisissez la cible (site.com, 192.168.1.100, etc.)

Sélectionnez le protocole : http ou https

Sélectionnez l’outil de scan ou Tous

Saisissez le chemin de wordlist si vous utilisez Gobuster

Lancez la capture Wireshark si vous êtes en root

📸 Aperçu visuel


📁 Exemple de sortie
```bash
text
Copier
Modifier
📌 Cible        : https://testphp.vulnweb.com
🔧 Outil choisi : Tous
📡 Interface    : eth0
🚨 Forcer erreurs : y
🎥 Capture réseau lancée sur eth0...
[... scan en cours ...]
✅ Scan terminé.
📁 Capture réseau enregistrée dans /tmp/capture_issam.pcapng
```

👨‍💻 Auteur
Issam Belayachi
🔗 [linkedin.com/in/issambelayachi](https://www.linkedin.com/in/issam-belayachi-505575347)
📧 issambelayachi000@gmail.com

