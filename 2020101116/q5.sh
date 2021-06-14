countFiles () {
    countFiles_rec "$1" 2>&1 >/dev/null | sort -nr
}

countFiles_rec () {
    local -i nfiles 
    dir="$1"
    nfiles=$(find "$dir" -mindepth 1 -maxdepth 1 -type f -print | wc -l)
    while IFS= read -r subdir; do
        set -- $(countFiles_rec "$subdir")
        (( nfiles += $1 ))
    done < <(find "$dir" -mindepth 1 -maxdepth 1 -type d -print)
    printf "%d %s\n" $nfiles "$dir" | tee /dev/stderr
}

if [ $# -eq 0 ]; then
    echo "Directories:"
    countFiles . | sort -nr | sed '$d' | awk 'BEGIN {FS ="./"} {print $NF", "$1 "file(s)"}'
    echo
    echo "Files:"
    find . -type f -printf "%s\t%p\n" | sort -nr | awk 'BEGIN {FS ="./"} {print $NF}'
else
    echo "Directories:"
    countFiles "$1" | sort -nr | sed '$d' | awk 'BEGIN {FS ="./"} {print $NF", "$1 "file(s)"}'
    echo
    echo "Files:"
    find "$1" -type f -printf "%s\t%p\n" | sort -nr | awk 'BEGIN {FS ="./"} {print $NF}'
fi

