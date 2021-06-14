
while getopts ":k:f:l:n:o:c:v:C:ad" optKey; do
	case "$optKey" in
		k)
			edit_name="$OPTARG"
			;;
		f)
		    fname="$OPTARG"
			;;
		l)
			lname="$OPTARG"
			;;
		n)
			number="$OPTARG"
			;;
        o)  
            company="$OPTARG"
            
            ;;
        c)
            column="$OPTARG"
            ;;
        v)  search_val="$OPTARG"
            ;;
        C)  
            comm="$OPTARG"
            ;;
        a)   
            sort_order="a"
            ;;
        d)
            sort_order="d"
            ;;
		
	esac
done

 tail -n +2 contacts.csv > contacts2.csv


case $comm in

  insert)
    echo "$fname,$lname,$number,$company" >> contacts.csv
    ;;

  edit)
    
    accumvar="$fname,$lname,$number,$company"

    sed -i "s/^$edit_name.*$/"$fname,$lname,$number,$company"/" contacts.csv

    ;;

  display)
    if [[ $sort_order == "a" ]]
    then
    sort -k1 -n -t,  contacts2.csv
    else
    sort -k1 -nr -t,  contacts2.csv
    fi
    ;;

    search)
    if [[ $column == fname ]]
    then
        col=1
    elif [[ $column == lname ]]
    then 
        col=2
    elif [[ $column == number ]]
    then    
        col=3
    else
    echo invalid
    fi    
   
        cat ./contacts2.csv | awk -F "," -v search=$search_val -v col=$col '{ if (search == $col) print $0 }'
    ;;

    delete)
    if [[ $column == fname ]]
    then
        col=1
    elif [[ $column == lname ]]
    then 
        col=2
    elif [[ $column == number ]]
    then    
        col=3
    else
    echo invalid
    fi    
        cat ./contacts.csv | awk -F "," -v search=$search_val -v col=$col '{if (search != $col) print $0}' > temp.csv
        mv ./temp.csv ./contacts.csv
    ;;
   
esac


