#!/usr/bin/env zsh
# Used this once to clear out some extremely old installs. Wrote it as a
# script so that I do a dry run; kept the script because why not?

# USAGE:
#     delete_by_date.sh `\ls -rt`
# backslash before ls ensures no asterisks following executables, etc

for file in $@; do
    ls -l $file  # allows you to see the date modified
    echo -n 'Delete? (y/n) [y] '
    read do_delete
    do_delete=${do_delete:-y}
    if [ $do_delete = "y" ]; then
        #echo "deleting $file"
        rm $file
    fi
done
