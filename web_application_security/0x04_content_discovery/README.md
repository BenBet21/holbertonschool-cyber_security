🕵️‍♂️ Cours sur le Content Discovery
1️⃣ Introduction au Content Discovery

Le Content Discovery consiste à explorer un site web à la recherche de ressources non répertoriées dans l’interface utilisateur, mais accessibles publiquement.

📌 Pourquoi est-ce important ?

    Trouver des pages d’administration oubliées.
    Découvrir des fichiers de configuration exposés.
    Accéder à des backups contenant des informations sensibles.
    Identifier des endpoints API qui ne devraient pas être publics.

2️⃣ Techniques de Content Discovery
🔍 1. Exploration Manuelle

Certains fichiers et répertoires sont souvent exposés par erreur. Vous pouvez les rechercher manuellement en testant des chemins comme :

https://example.com/admin  
https://example.com/backup.zip  
https://example.com/.git  

💡 Astuce : Recherchez des fichiers standards comme .htaccess, robots.txt et sitemap.xml qui peuvent donner des indices sur la structure du site.
🏗 2. Bruteforce de Directories & Files

On utilise des outils pour tester automatiquement des milliers de combinaisons d’URLs.
🔹 Outils populaires :

    Gobuster : Rapide et efficace pour tester des répertoires.
    Dirb / Dirbuster : Basés sur des wordlists de répertoires courants.
    FFUF : Très rapide et personnalisable.
    Wfuzz : Utile pour tester plusieurs paramètres en parallèle.

📌 Exemple avec Gobuster :

gobuster dir -u http://example.com -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt

Ce qui permet de tester des centaines de chemins en quelques secondes.
🔍 3. Analyse des Réponses HTTP

    Un code 200 (OK) indique que la ressource existe.
    Un code 403 (Forbidden) peut signaler une ressource cachée mais accessible d’une autre manière.
    Un code 302 (Redirection) peut révéler un endpoint API ou une authentification.
    Un code 500 (Erreur serveur) peut indiquer un fichier mal sécurisé.

📜 4. Exploitation des Fichiers Publics

Certains fichiers sont souvent laissés exposés accidentellement :

    robots.txt : Contient souvent des chemins interdits aux moteurs de recherche.
    .git/ : Peut révéler le code source du site !
    sitemap.xml : Liste des pages indexées par le site.

3️⃣ Automatisation et Techniques Avancées
🤖 1. Utilisation d’outils avancés

    Burp Suite : Peut automatiser la recherche de contenus cachés.
    Wayback Machine & Google Dorking : Permettent de retrouver d’anciennes pages supprimées.

📌 Exemple de Google Dorking pour trouver des fichiers de configuration exposés :

site:example.com ext:env | ext:config | ext:log

🏗 2. Fingerprinting & Recon avancé

    Utiliser WhatWeb ou Wappalyzer pour identifier la techno du site.
    Scanner les sous-domaines avec Sublist3r pour trouver d’autres endpoints.

4️⃣ Exercices et Pratique
💻 TryHackMe Rooms recommandées :

    "Basic Content Discovery" : Introduction aux outils comme Gobuster.
    "Burp Suite Basics" : Pour apprendre à intercepter des requêtes HTTP.
    "OSINT & Recon" : Techniques avancées pour la collecte d’informations.

🎯 Conclusion

Le Content Discovery est une étape clé pour tester la sécurité d’un site web. En combinant exploration manuelle et outils automatiques, il est possible d’identifier des failles critiques. Toujours tester avec l’autorisation du propriétaire du site ! 🚀