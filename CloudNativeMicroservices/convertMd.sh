#!/bin/bash
##
CSSFILE=$2
cat ./$1.md | pandoc  -f markdown_github > ./$1.html


echo "<!DOCTYPE html><html lang=\"en-us\"><link rel=\"stylesheet\" href=\"css/${CSSFILE}.css\"/>" | cat - ~./$1.html > ./$1.tmp

echo '</html>' >> ./$1.tmp

mv ./$1.tmp ./$1.html
