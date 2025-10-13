#!/bin/bash
cd archive-19
echo "Saisissez votre type de données :"
read type
echo "Voici le nombre de $type pour 2016"
grep $type 2016*.ann | wc -l
exit
