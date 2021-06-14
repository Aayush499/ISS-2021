

sed 's|^|s/\\<|; s|$|\\>//g;|' "$2" > stopwords2.sed
num=$(sed -f stopwords2.sed "$1" | egrep -o '\b\w*\b'| wc -w )
sed -f stopwords2.sed "$1" > newtext.txt
echo $num
occur=$(egrep -ow "$3" newtext.txt | wc -w)
echo $occur

ans=$(echo $occur / $num | bc -l) 
echo $(cat newtext.txt), $ans > output.txt