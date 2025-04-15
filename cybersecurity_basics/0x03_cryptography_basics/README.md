# holbertonschool-cyber_security / Cryptography BASICS
Le chiffrement est essentiel car il protège les données et les informations contre les accès non autorisés et préserve ainsi leur confidentialité. Cet article vous aidera à comprendre ce _qu'est la cryptographie_ et comment l'utiliser pour protéger les secrets d'entreprise, les informations classifiées et les informations personnelles, notamment contre l'usurpation d'identité.

- Introduction à la cryptographie ?
- Algorithmes de chiffrement
- Comment fonctionnent les différents algorithmes cryptographiques ?

Imaginons _qu'Andy_ envoie un message à son ami _Sam_ , à l'autre bout du monde . Il souhaite évidemment que ce message reste privé et que personne d'autre n'y ait accès. Il utilise un forum public, par exemple _WhatsApp_ , pour envoyer ce message. L'objectif principal est de sécuriser cette communication.

Imaginons qu'un homme intelligent nommé _Eaves_ ait secrètement accès à votre canal de communication. Puisqu'il a accès à vos communications, il peut faire bien plus que simplement écouter aux portes : il peut par exemple tenter de modifier le message. Voici un petit exemple. Que se passerait-il si _Eave_ avait accès à vos informations privées ? Les conséquences pourraient être catastrophiques.

Alors, comment _Andy_ peut- il être sûr que personne au milieu ne puisse accéder au message envoyé à _Sam_ ? C'est là qu'intervient **_le chiffrement, ou cryptographie_** .

# Qu'est-ce que la cryptographie ?

La cryptographie est la pratique et l’étude des techniques permettant de sécuriser les communications et les données en présence d’adversaires.


_Très bien, maintenant que vous savez « ce qu’est la cryptographie », voyons comment la cryptographie peut aider à sécuriser la connexion entre Andy et Sam._

Pour protéger son message, _Andy_ le convertit d'abord en un message illisible. Il le convertit ensuite en nombres aléatoires. Il utilise ensuite une clé pour chiffrer son message. En cryptographie, on appelle cela un **_texte chiffré_** .

_Andy_ envoie ce message _chiffré_ via le canal de communication ; il n'aura pas à craindre que quelqu'un découvre ses messages privés. Imaginons _qu'Eaves_ découvre le message et parvienne à le modifier avant qu'il n'atteigne _Sam_ .

_Sam_ aurait désormais besoin d'une clé pour déchiffrer le message et récupérer le texte en clair original. Pour convertir le texte chiffré en texte clair, _Sam_ devrait utiliser la clé de déchiffrement. Grâce à cette clé, il convertirait le texte chiffré ou la valeur numérique en texte clair correspondant.

Après avoir utilisé la clé de déchiffrement, le message _en clair_ original est une _erreur_ . Cette erreur est cruciale. Elle permet à _Sam_ de savoir que le message envoyé par _Andy_ est différent de celui qu'il a reçu. Le chiffrement est donc essentiel pour communiquer ou partager des informations sur le réseau.

# Algorithmes de chiffrement

La cryptographie est généralement classée en deux catégories : **_la cryptographie à clé symétrique_** et **_la cryptographie à clé asymétrique_** (communément appelée cryptographie à clé publique).
