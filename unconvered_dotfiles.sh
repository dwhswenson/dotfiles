#!/bin/bash

# A quick and dirty script to check which dotfiles are in the home directory
# but not yet covered in this repository.

for file in `ls -a $HOME | grep "^\."`
do
    found="N"
    # 1. check if the file is covered
    storedfile=`echo $file | sed 's/^\.//'`
    in_local=`ls | grep "^$storedfile$"`
    if [ "$in_local" != "" ]
    then
        found="Y"
    fi
    # 2. check if the file is in dotfiles_ignore
    in_ignore=`grep "^$file$" dotfiles_to_ignore.txt`
    if [ "$in_ignore" != "" ]
    then
        found="Y"
    fi

    # 3. if not found, then print
    if [ "$found" == "N" ]
    then
        echo $file
    fi
done
