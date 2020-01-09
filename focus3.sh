#!/bin/bash



filename=$1.md
duration=$2
dir="$HOME/myScripts"

setEditor(){
    if [[ $EDITOR = "" ]]
    then
        EDITOR=vi
    else
        EDITOR=$EDITOR
    fi
}

startTimer(){
    msg="#    $duration min timer set @$(date +%y-%m-%d--%H:%M:%S)"
    padding=$(printf "%.0s " $(seq $((79-${#msg})) ))
    echo "$(printf '#%.0s' {1..80})" > $filename
	echo "$(printf "#" ; printf ' %.0s' {1..78} ; printf "#")" >> $filename
    echo "$msg$padding#" >> $filename
	echo "$(printf "#" ; printf ' %.0s' {1..78} ; printf "#")" >> $filename
    echo "$(printf '#%.0s' {1..80})" >> $filename
    $EDITOR $filename

}


timeUp(){
    # -2 <C-c> (not supported by vim)
    # -15 terminante "crash"
    # see `man signal`
    echo "EXIT @ $(date +%R)" >> $filename
    if [[ $EDITOR =~ [aA]tom ]]
    then
        ps -efw | grep -i "atom" | grep -v grep |  awk '{print $2}' | xargs kill -2
    else
        ps -efw | grep -i $filename | grep -v grep |  awk '{print $2}' | xargs kill -15
        #look for vim recover files and rename them
        mv $dir/.*\.sw[a-p] $dir/$filename
    fi

}

setEditor
startTimer
sleep $(( duration * 60 ))
timeUp
