Voici une synthèse des points essentiels concernant les vulnérabilités liées au téléversement de fichiers, basée sur la page de l'Académie de Sécurité Web de PortSwigger citeturn0search0 :

### Qu'est-ce qu'une vulnérabilité de téléversement de fichiers ?

Une vulnérabilité de téléversement de fichiers survient lorsqu'un serveur web permet aux utilisateurs de téléverser des fichiers sans valider correctement des aspects tels que le nom, le type, le contenu ou la taille du fichier. Une validation insuffisante peut permettre à un attaquant de téléverser des fichiers dangereux, y compris des scripts côté serveur pouvant entraîner une exécution de code à distance.

### Impact des vulnérabilités de téléversement de fichiers

L'impact dépend de deux facteurs principaux :

1. **Aspect non validé du fichier** : Par exemple, si le type de fichier n'est pas correctement validé, un attaquant pourrait téléverser un fichier exécutable comme un script PHP, conduisant potentiellement à une prise de contrôle complète du serveur.

2. **Restrictions post-téléversement** : Si les restrictions sur les fichiers téléversés sont insuffisantes, cela peut permettre des attaques telles que l'écrasement de fichiers critiques ou des attaques par déni de service en saturant l'espace disque.

### Origine des vulnérabilités de téléversement de fichiers

Ces vulnérabilités apparaissent souvent lorsque les développeurs implémentent des mécanismes de validation défaillants ou facilement contournables. Par exemple, tenter de bloquer certains types de fichiers sans considérer les différentes manières dont les extensions peuvent être manipulées ou en se basant uniquement sur des propriétés facilement falsifiables par un attaquant.

### Exploitation des vulnérabilités de téléversement

Les attaquants peuvent exploiter ces vulnérabilités pour :

- **Déployer une web shell** : En téléversant un script malveillant, l'attaquant peut exécuter des commandes arbitraires sur le serveur.

- **Contourner les validations de type de fichier** : En manipulant les extensions de fichier ou en utilisant des techniques d'obfuscation, un attaquant peut téléverser des fichiers interdits.

- **Exploiter des conditions de course** : Si le processus de validation et de stockage des fichiers téléversés est vulnérable à des conditions de course, un attaquant peut exécuter un fichier malveillant avant que le serveur ne le supprime.

### Prévention des vulnérabilités de téléversement de fichiers

Pour prévenir ces vulnérabilités, il est recommandé de :

- **Utiliser une liste blanche** des types de fichiers autorisés et vérifier le type MIME côté serveur.

- **Renommer les fichiers téléversés** avec des noms générés par le serveur pour éviter l'exécution de fichiers malveillants.

- **Stocker les fichiers téléversés en dehors des répertoires accessibles publiquement** ou configurer le serveur pour empêcher l'exécution de ces fichiers.

- **Limiter la taille des fichiers téléversés** pour prévenir les attaques par déni de service.

- **Analyser les fichiers téléversés** avec un antivirus avant de les stocker ou de les utiliser.

En appliquant ces mesures, les risques associés aux vulnérabilités de téléversement de fichiers peuvent être significativement réduits. 