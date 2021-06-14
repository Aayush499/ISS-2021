
name=$(awk '{for(i=1;i<=NF;i++){ if($i~/[A-Za-z]/){print $i} } }' "$1") 
date=$(awk '{print $(NF)}' "$1")
dob=$(echo $date | awk 'BEGIN {FS ="/"} {print $3$2$1}')
 
curr_date=$(date +"%Y%m%d")

echo $name $(expr \( $curr_date - $dob \) / 10000) > output.txt