#!/bin/bash

todo='notes/TODO.md'
completed='notes/completed.md'
touch $completed || exit
awk '/COMPLETED/{y=1;next}y' $todo | cat - $completed > temp && mv -f temp $completed
awk '1;/COMPLETED/{exit}' $todo > temp && mv -f temp $todo
