#!/bin/bash

#On affiche un message d'erreur dans le cas où on a pas nos deux arguments
if [ $# -ne 2 ];
then
    echo "Erreur: il faut deux arguments pour exécuter le script"
    exit 1
fi

#Cela nous permet de rentrer les chemins des fichiers d'entrée et de sortie lorsqu'on exécute le script
#Cela nous évite de noter les chemins directement dans le code
URL_FILE="$1";
OUTPUT_FILE="$2";

i=1
while read -r line;
do
    code=$(curl -o /dev/null -s -w "%{http_code}" "$line");
    encodage=$(curl -s -I "$line" | grep -oE "charset=[^; ]+" | cut -d= -f2);
    mots=$(lynx -dump -nolist "$line" | wc -w);
    echo -e "${i}\t${code}\t${mots}\t${line}\t${encodage}";
    ((i++));
done < "$URL_FILE" >> "$OUTPUT_FILE";

