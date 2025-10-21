#Journal de bord du projet encadré

##Exercice pour la séance 2: j'ai créer un nouveau dépot sur GitHub. J'ai récupérer l'URL SSH pour faire un git clone afin de dupliquer ce dossier sur ma machine. Après cela, j'ai créé un nouveau fichier dans ce dossier sur GitHub afin de réaliser mon journal de bord. Comme j'ai réaliser cela directement sur GitHub, cela ne s'est pas synchronisé avec ma machine. C'est pourquoi, j'ai utilisé la commande git pull afin de synchronisé le dossier avec ma machine et ainsi pouvoir récupérer le fichier créé sur GitHub.

##fonctionnement du code de la fin du diapo de Unix:  
Il s'agit d’un script Bash qui lit un fichier ligne par ligne pour déterminer si chaque ligne ressemble à une URL valide  
"if [ $# -ne 1 ]" vérifie qu'il a reçu exactement un argument sinon il affiche un message d'erreur  
"while read -r LINE" crée une boucle qui lit le fichier ligne par ligne  
"-r" évite que les \ soient interprétés comme des caractères spéciaux.  
"[ $LINE =~ ^https?:// ]]" vérifie si la ligne commence par https  
"expr $NOK + 1" incrémente le compteur  
"done < $FICHIER_URLS" signifie que la boucle lit depuis le fichier fourni  
À la fin, le script affiche le total des URL valides et douteuses
