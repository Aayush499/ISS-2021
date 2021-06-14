echo 1.Word startswith ‘s’ and is not follow by ‘a’.
grep -oP '\bs(?!a)\w*' "$1" 
echo 2.Word starts with ‘w’ and is followed by ‘h’ 
grep -oP '\bwh\w*' "$1"
echo 3.Word starts with ‘t’ and is followed by ‘h’
 grep -oP '\bth\w*' "$1"
echo 4.Word starts with ‘a’ and is not followed by ‘n’
grep -oP '\ba(?!n)\w*' "$1" 