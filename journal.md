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

##Mini projet:  
  
Exercice 1: Questions  
  
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
  
Exercice 2:  
  
1) Pour rajouter le code de HTTP de réponse à la requête des urls à chaque ligne, j'ai utilisé la commande curl en procédant de la manière suivante:  
code=$(curl -o /dev/null -s -w "%{http_code}" "$line")  
-o /dev/null permet d'ignorer le contenu téléchargé  
-s permet de ne pas afficher de messages  
-w "%{http_code}" permet d'afficher uniquement le code HTTP de la réponse__
$line renvoie à ma liste d'urls  
la commande curl permet juste de récupérer le code HTTP. Pour ce qui est de l'affichage, j'ai rajoué ${code} dans mon echo que j'ai entouré de \t afin de bien séparer avec des tabulations.  
  
2) Pour ce qui est de l'encodage, j'ai également utilisé la commande curl en procédant de la manière suivante:  
encodage=$(curl -s -I "$line" | grep -i "content-type" | grep -oE "charset=[^; ]+" | cut -d= -f2)  
curl -s -I "$line" permet de récupérer uniquement les entêtes HTTP de la réponse  
grep -oE "charset=[^; ]+" permet d'extraire la partie charset'  
cut -d= -f2 permet de garder uniquement la valeur (utf-8)  
Pour l'affichage j'ai rajouter le ${encodage} à la fin de la ligne echo car quand je le plaçait avant ${line} cela provoquait un bug d'affichage.  
  
3) Pour compter les mots des différentes pages j'ai utilisé lynx. La commande complète est la suivante:  
mots=$(lynx -dump -nolist "$line" | wc -w)  
lynx -dump -nolist permet de convertir la page web en texte brut.  
wc -w permet de compter les mots uniquement dans le texte lisible.  
Pour l'affichage j'ai rajouter le ${mots} avant ${line} car quand je le plaçait à la fin de la ligne echo cela provoquait un bug d'affichage.  
Le nombre de mots a pu être récupérer sur tous les sites sauf roboty.magistry.fr qui affiche un message d'erreur indiquant que l'accès à ce site est impossible.  
  
Suite à la correction des profs qui nous ont dit de ne pas mettre les chemins des fichier directement dans le script, j'ai légèrement modifié ce dernier:  
J'ai rajouté à mon code URL_FILE="$1" pour le fichier d'entrée et OUTPUT_FILE="$2" pour le fichier de sortie.  
Cela me permet de mettre les fichiers en argument de mon script.  
Si je déplace les fichiers, j'ai juste à noté le bon chemin du fichier en argument de mon script.  
J'ai également rajouté une condition à mon script, pour qu'il m'affiche un message d'erreur si jamais il n'y a pas le bon nombre d'argument.  

Miniprojet 2: Exercice: transformer la sortie tabulaire en HTML
  
Pour cet exercice, j'ai repris mon ancien script miniprojet.sh que j'ai modifié.  
Après l'annonce des argument, j'ai commencé à écrire mon code HTML avec un echo.  
Dans ce code j'y ai mis une entête (head) et un corps (body).  
Dans l'entête, j'y ai mis l'encodage de la page (UTF-8), un titre pour nommer la page et une balise style, qui permet la mise en forme de la page et surtout du tableau.  
Dans le corps, j'y ai mis le tableau grâce à la balise table. Dans cette balise table, j'ai rajouté des balises tr et th afin de créer un ligne d'entête pour mon tableau.  
Après cette première ligne, j'ai mis un premier $OUTPUT_FILE afin de crée le fichier, écrit l’entête et début du tableau.  
Ensuite, j'ai mis ma bloucle permettant de parcourir les urls. J'ai encore utilisé les balises tr et th pour que les résultats de la boucle soit bien dans le tableau.  
J'ai rajouté un deuxième $OUTPUT_FILE afin d'ajouter chaque ligne <tr> pour chaque URL dans le tableau. Et j'ai fini ma boucle.  
Enfin, j'ai rajouté: echo "</table></body></html>" >> "$OUTPUT_FILE" afin d'ajouter la fin du tableau et des balises HTML pour compléter le document.  
  
Maintenant, en exécutant notre script, on ajoute en argument le fichier d'entrée fr.txt et le fichier de sortie tableau-fr.html .  
En mettant les chemins corrects des fichiers afin d'avoir le script dans le dossier programmes, le fichier d'entrée dans le dossier urls et le fichier de sortie dans le dossier tableaux.  
Une fois le script exécuté, le fichier de sortie tableau-fr.html sera créé et il affichera le tableau des urls sur le navigateur.  
  
Miniprojet 3: Exercice: créer des pages web GitHub  
  
Pour cette exercice, j'ai créé un page html que j'ai appelé index.html et que j'ai placé à la racine de mon dossier.  
Sur cette page, j'ai écrit une phrase résumant le miniprojet et j'ai créé un lien vers la page html du Miniprojet 2.  
Sur cette page j'ai utilisé Bulma pour changer le CSS. Pour ce faire j'ai utilisé la balise suivante dans l'entête de la page:  
  "<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css">"  
J'ai également supprimé l'ancien CSS de ma page du Miniprojet 2 pour le remplacer par celui-ci.  
Après cela, j'ai push mon dossier sur GitHub et j'ai créé un site à partir de mon dépôt.  
Pour cela, je suis allé dans Settings en haut à droite du dépôt puis dans Pages.  
Dans Pages, je suis allé dans la section Branch et j'ai cliqué sur Main.  
Après avoir sauvegardé, j'ai attendu quelques instants et le site a été créé.  
Il est disponible avec le lien suivant: https://jacometv31.github.io/PPE1-2025/ .  
