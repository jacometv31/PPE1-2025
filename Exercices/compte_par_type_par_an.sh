#!/bin/bash
cd archive-19
echo "Saisissez votre type de données :"
read type
echo "Voici le nombre de $type pour 2016"
grep $type 2016*.ann | wc -l
echo "Saisissez votre type de données :"
read type
echo "Voici le nombre de $type pour 2017"
grep $type 2017*.ann | wc -l
echo "Saisissez votre type de données :"
read type
echo "Voici le nombre de $type pour 2018"
grep $type 2018*.ann | wc -l
exit


