#!/usr/bin/bash
#compile tex files , bib (if mod) and clean aux files


# init stat shell vars
eval set `stat -s "$1.bib"`
mTime=$st_mtime

# compile bibliography
function bib(){
		biber "$1.bib"
		pdflatex "$1" 
		pdflatex "$1"
	}

if [[ !(-e ".tmp") ]] ; then
	echo "preTime=$(echo $st_mtime)" > ".tmp"
	pdflatex "$1"
	bib
else
	source ".tmp"
	if [[ preTime -eq mTime ]] ; then
		pdflatex "$1"
	else 
		pdflatex "$1"
		bib
fi

# clear aux files
latexmk -c 
rm *\.xml


	
