#!/bin/bash
    ###MOTIVATION###
    # todo.sh inspiration
    # similar workflow, but minimal implementation. Reduce cognitive workload when studying and having to find the appropriate notes for a given topic when something not directly related to the topic "appears"

    # SET ENVIRONMENT VARIABLES ON FIRST RUN

    #### DEFAULTS
    # Editor : set at start , if unset , vim
    # Directory : set at start , if unset cwd/TIL
    # FileName :  default = <string>+date+counter
    #### options : string,date,time,counter,projectName
    #### check if file exists
    # Format : md ; optional txt
    #####

    # SET FLAGS
    #### override default
    #### other options

    ###BASICS
    #FOCUS on making it work for MAC

    #[X] Write Template Header when opening File
    #[ ] Read input logic
    #[ ] Set deafult VARIABLES
    #[ ] Flag logic

    ###WANTED
    # python script to :
        #collate by day
        #rearrange into thematic blogs given tag


filename=$1
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
# setEditor
EDITOR=atom
startTimer(){
    msg="#    $duration min timer set @$(date +%y-%m-%d--%H:%M:%S)"
    padding=$(printf "%.0s " $(seq $((79-${#msg})) ))
    echo "$(printf '#%.0s' {1..80})" > $filename.md
	echo "$(printf "#" ; printf ' %.0s' {1..78} ; printf "#")" >> $filename.md
    echo "$msg$padding#" >> $filename.md
	echo "$(printf "#" ; printf ' %.0s' {1..78} ; printf "#")" >> $filename.md
    echo "$(printf '#%.0s' {1..80})" >> $filename.md
    $EDITOR $filename.md

}


startTimer

sleep 10
timeUp(){
    ps -efw | grep -i $filename.md | grep -v grep |  awk '{print $2}' | xargs kill -3
    sleep 5
    if [[ls | grep $dir$filename.md]]
    then
        echo "file exists"
    else
        echo "file does not exist"
        ps -efw | grep -i $filename.md | grep -v grep |  awk '{print $2}' | xargs kill -15
    fi
    echo "EXIT @ $(date +%R)" >> $filename.md
}

timeUp
