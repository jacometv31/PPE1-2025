{
    i=1
    while read -r line;
    do
        code=$(curl -o /dev/null -s -w "%{http_code}" "$line");
        encodage=$(curl -s -I "$line" | grep -oE "charset=[^; ]+" | cut -d= -f2)
        mots=$(lynx -dump -nolist "$line" | wc -w)
        echo -e "${i}\t${code}\t$mots\t${line}\t${encodage}";
        ((i++));
    done < "../urls/fr.txt";
} >> "../tableaux/tableau-fr.tsv";

