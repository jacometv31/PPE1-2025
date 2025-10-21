#!/bin/bash
# script0.sh
cd archive-19
for i in 2016 2017 2018
do
grep Location $i*.ann | wc -l
echo "Voici le nombre de Location pour $i"
done
exit
