**1. What is LFI ?**  
LFI signifie _Local File Inclusion_ (inclusion de fichiers locaux). C’est une vulnérabilité web qui permet à un attaquant d’inclure des fichiers présents sur le serveur, souvent via des paramètres manipulés dans l’URL.

**2. What is RFI ?**  
RFI signifie _Remote File Inclusion_ (inclusion de fichiers distants). Cette vulnérabilité permet à un attaquant d’inclure des fichiers hébergés à l’extérieur du serveur, généralement pour exécuter du code malveillant.

**3. How to prevent FI attacks ?**  
Pour prévenir les attaques d’inclusion de fichiers, il faut :

- Valider et filtrer les entrées utilisateur
    
- Désactiver les fonctions dangereuses comme `allow_url_include`
    
- Utiliser des chemins absolus ou des listes blanches de fichiers autorisés
    

**4. What is ../../ used for in FI ?**  
La chaîne `../../` est utilisée pour remonter dans l’arborescence du système de fichiers. Les attaquants l’utilisent pour atteindre des fichiers sensibles hors du répertoire prévu.

**5. How can LFI lead to RCE ?**  
LFI peut mener à une exécution de code à distance (RCE) si un attaquant réussit à inclure un fichier contenant du code exécutable, par exemple via des fichiers de log ou des fichiers uploadés.

**6. What are the mechanisms through which file inclusion vulnerabilities can be exploited ?**  
Les mécanismes d’exploitation incluent :

- La manipulation des paramètres GET/POST
    
- L’utilisation de séquences comme `../../`
    
- L’inclusion de fichiers temporaires ou de logs contenant du code injecté
    

**7. What is the potential impact of successful file inclusion attacks on a system ?**  
Les conséquences peuvent inclure :

- L’accès à des fichiers sensibles (ex : mots de passe)
    
- L’exécution de commandes arbitraires
    
- Le contrôle total du serveur
    

**8. What techniques can be used to detect file inclusion vulnerabilities in web applications ?**  
On peut utiliser :

- Des outils d’analyse statique et dynamique (Burp Suite, Nikto, etc.)
    
- Des tests manuels en injectant des chemins de fichiers
    
- Des scanners de sécurité spécialisés
    

**9. How can effective mitigation strategies be implemented to safeguard against file inclusion vulnerabilities ?**  
Il faut :

- Valider strictement les entrées utilisateur
    
- Utiliser des listes blanches pour les fichiers
    
- Configurer correctement le serveur PHP
    
- Garder les logiciels à jour