#Journal de bord du projet encadré

##Exercice pour la séance 2:  
  
j'ai créer un nouveau dépot sur GitHub. J'ai récupérer l'URL SSH pour faire un git clone afin de dupliquer ce dossier sur ma machine. Après cela, j'ai créé un nouveau fichier dans ce dossier sur GitHub afin de réaliser mon journal de bord. Comme j'ai réaliser cela directement sur GitHub, cela ne s'est pas synchronisé avec ma machine. C'est pourquoi, j'ai utilisé la commande git pull afin de synchronisé le dossier avec ma machine et ainsi pouvoir récupérer le fichier créé sur GitHub.

##fonctionnement du code de la fin du diapo de Unix:  
  
Il s'agit d’un script Bash qui lit un fichier ligne par ligne pour déterminer si chaque ligne ressemble à une URL valide  
"if [ $# -ne 1 ]" vérifie qu'il a reçu exactement un argument sinon il affiche un message d'erreur  
"while read -r LINE" crée une boucle qui lit le fichier ligne par ligne  
"-r" évite que les \ soient interprétés comme des caractères spéciaux  
"[ $LINE =~ ^https?:// ]]" vérifie si la ligne commence par https  
"expr $NOK + 1" incrémente le compteur  
"done < $FICHIER_URLS" signifie que la boucle lit depuis le fichier fourni  
À la fin, le script affiche le total des URL valides et douteuses

##Mini projet: Exercice 1: Questions  
  
1) Pourquoi ne pas utiliser la commande cat ?  
Quand on utilise la commande cat, le code est le suivant: "cat fichier | while read". Toutefois, cela va créer un sous-shell.  
Avec notre code, la boucle affiche chaque ligne, donc la sortie à l'écran est bien visible, peu importe le sous-shell.  
Le souci vient quand on veux garder en mémoire une variable modifiée dans la boucle pour s’en servir après la boucle. Par exemple un compteur ou une concaténation.  
Donc, comme la boucle tourne dans un sous-shell, les modifications sont perdues.  
C'est pour cela que l'on préfère utiliser "while read ...; done < fichier" afin d'éviter ce problème.  
  
2) Comment transformer "urls/fr.txt" en paramètre du script ?  
Autrement dit, comment faire en sorte que le script arrive à lire notre fichier fr.txt .  
Il suffit de changer le chemin d'accès au fichier. Donc, on remplace "urls/fr-txt" par "../urls/fr-txt".  
Il faut sortir de notre dossier "programmes" afin de rentrer dans le dossier "urls" dans lequel se trouve notre fichier.  
  
3) Comment afficher le numéro de ligne avant chaque URL ? Et séparer les valeurs par des tabulations ?  
J'ai tout d'abord pensé à la commande awk afin de réaliser la numérotation. En écrivant la ligne "awk '{print NR ": " $0}'" à l'intérieur de ma boucle.  
Toutefois, j'ai remarqué que la numérotation ne commençait qu'à partir de la seconde ligne.  
Le problème vient du fait que awk est exécuté dans une nouvelle instance à chaque itération du while, donc le compteur NR (numéro de ligne) repart de 1 à chaque fois.  
J'ai donc décidé de faire un compteur manuel dans ma boucle.Avec i=1 avant de commencer la boucle, de remplacer la ligne "echo ${line}" par "echo -e "${i}\t${line}"" et de rajouter ((i++)) à la fin.  
Afin de séparer les valeurs par des tabulations, j'ai utilisé \t ainsi que -e qui permet à echo d'interpréter les séquences spéciales comme tel.  
