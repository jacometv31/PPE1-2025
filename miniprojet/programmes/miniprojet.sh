{
    i=1
    while read -r line;
    do
        echo -e "${i}\t${line}";
        ((i++));
    done < "../urls/fr.txt";
} >> "../tableaux/tableau-fr.tsv";

