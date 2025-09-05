# holbertonschool-cyber_security
Nmap Post Port Scan & Scripting

QA Nmap Post Port Scan & Scripting
Qu'est-ce que le Nmap Scripting Engine (NSE) et pourquoi est-il important ?
Le NSE constitue une extension puissante de Nmap, permettant d'automatiser des tâches de découverte réseau, de détection de vulnérabilités ou même d’exploitation grâce à des scripts écrits en Lua, un langage léger adapté à l'automatisation. Le NSE permet non seulement d'étendre les possibilités de Nmap, mais aussi d'adapter les analyses aux besoins précis des professionnels de la sécurité informatique.siberoloji+2
Comment fonctionne le Nmap Scripting Engine ?
Le NSE exécute des scripts Lua en parallèle avec la rapidité habituelle de Nmap. Chaque script est associé à une règle d’exécution (hostrule, portrule, prerule, postrule) qui détermine à quel moment et sur quelles cibles il s’active pendant le scan. Les scripts s’appuient sur des bibliothèques Lua embarquées et les résultats d’analyse courante fournis par Nmap.nmap+2
Quels sont les différents types de scripts (catégories) dans le NSE ?
Les scripts NSE sont organisés en plusieurs catégories fonctionnelles :
auth : gestion et contournement d’authentificationnmap


broadcast : découverte sur le réseau local par diffusion (ex : DHCP)


brute : attaques par force brute pour deviner des identifiants


default : scripts recommandés, sélectionnés par défaut


discovery : collecte d’informations sur l’hôte ou le service ciblé


dos : tests de vulnérabilité DoS (Denial of Service)


exploit : exploitation de failles détectées


external : scripts multisources, parfois dépendants d’Internet


fuzzer : tests automatiques de type fuzzing


intrusive : scripts invasifs pouvant perturber ou révéler des informations sensibles


malware : détection de logiciels malveillants


safe : scripts non intrusifs


version : identification détaillée de versions logicielles


vuln : détection ciblée de vulnérabilités connues.dev+3


Comment les scripts sont-ils organisés et exécutés dans le NSE ?
Les scripts sont stockés dans un dossier prédéfini, généralement /usr/share/nmap/scripts/. Chaque script comporte une description, un ou plusieurs auteurs, et une licence. Nmap exécute les scripts selon leur règle d’exécution, qui peut être liée à l’hôte (hostrule), au port (portrule), au contexte global (prerule), ou en fin de scan (postrule). Cela permet de réaliser des actions soit avant le scan, soit sur chaque port ou hôte détecté, soit à la fin de l’analyse.geeksforgeeks+2
Quels arguments en ligne de commande sont utilisés pour lancer les scripts NSE ?
Pour utiliser les scripts NSE, on emploie :
-sC : lance les scripts du groupe “default”,


--script=<nom_script> ou --script=<catégorie> : sélection précise de scripts, de catégories ou de répertoires,


--script-args=<clés_valeurs> : transmission d’arguments aux scripts (identifiants, chemins, options spécifiques),


--script-args-file=<fichier> : pour fournir les arguments via un fichier,


--script-help : affiche l’aide sur les scripts sélectionnés,


--script-trace et --script-updatedb : utilisés pour le debugging et la mise à jour de la base des scripts.tecmint+2


Que peut-on faire avec ces scripts Nmap ?
Les scripts NSE offrent de vastes possibilités :
Découverte réseau avancée (whois, ARIN, SNMP, NFS…)


Détection de vulnérabilités et d’exploits connus


Analyses de configuration et audit de sécurité (ex : base MySQL)


Fuzzing et force brute de mots de passestationx+2


Détection de malware et de faiblesses logicielles ou protocolaires


Automatisation de tâches administratives ou d’investigation sécurité


Comment écrire la documentation des scripts NSE avec NSEDoc ?
La documentation NSE est intégrée dans le code source du script grâce à des commentaires structurés, en s’appuyant sur le format NSEDoc, dérivé de LuaDoc. Les éléments principaux incluent :
Une variable “description” pour l’explication générale,


Les champs “author” et “license” pour citer l’auteur et la licence,


Des balises commentées --- pour documenter l’utilisation, les arguments possibles (@args), et ce que retourne le script (@output, @xmloutput).secureideas+2


Exemple de commentaire de documentation :


lua
description = [[
Scanne les entrées disallow dans /robots.txt sur un serveur web.
]]
author = "Nom de l’auteur"
license = "GPL-2.0"
--- @args http-robots.txt.path Chemin du fichier robots.txt
--- @output 80/tcp open http syn-ack | http-robots.txt: 156 disallowed entries

Ainsi, NSEDoc facilite la génération automatique d’une documentation claire et accessible pour chaque script sur le portail NSEDoc officiel.nmap

