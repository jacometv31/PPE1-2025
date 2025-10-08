#!/bin/bash
# script0.sh
cd archive-19
echo "Voici le nombre de Location pour 2016"
grep Location 2016*.ann | wc -l
echo "Voici le nombre de Location pour 2017"
grep Location 2017*.ann | wc -l
echo "Voici le nombre de Location pour 2018"
grep Location 2018*.ann | wc -l
exit
