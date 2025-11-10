#!/bin/bash

# Vérification des arguments
if [ $# -ne 2 ]; then
    echo "Erreur: il faut deux arguments pour exécuter le script"
    exit 1
fi

URL_FILE="$1"
OUTPUT_FILE="$2"

# Début du HTML
echo "<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>Résultat URLs</title> <!-- Le nom de la page est Résultat URLs -->
<style>
table { border-collapse: collapse; width: 100%; }
th, td { border: 1px solid #000; padding: 5px; text-align: left; }
</style> <!-- permet la mise en page, ici style est utilisé pour la mise en forme du tableau -->
</head>
<body>
<table>
<tr>
<th>#</th>
<th>Code HTTP</th>
<th>Nombre de mots</th>
<th>URL</th>
<th>Encodage</th>
</tr>" > "$OUTPUT_FILE" #permet de créer le tableau

# Parcours des URLs
i=1
while read -r line; do
    code=$(curl -o /dev/null -s -w "%{http_code}" "$line")
    encodage=$(curl -s -I "$line" | grep -oE "charset=[^; ]+" | cut -d= -f2)
    mots=$(lynx -dump -nolist "$line" | wc -w)
    echo "<tr>
<td>${i}</td>
<td>${code}</td>
<td>${mots}</td>
<td><a href=\"$line\">$line</a></td>
<td>${encodage}</td>
</tr>" >> "$OUTPUT_FILE" #permet de rajouter des lignes dans le tableau
    ((i++))
done < "$URL_FILE"

# Fin du HTML
echo "</table> <!-- table permet de créer un tableau -->
</body>
</html>" >> "$OUTPUT_FILE" #permet la fermeture du fichier HTML
