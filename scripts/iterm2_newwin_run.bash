#!/bin/bash

# why not just run this as an AppleScript? it seems that running inside
# osascript gets it all confused about which directory we're working from.
# Hence the need to play it like this.

my_str=""
for arg in $@
do
    my_str="$my_str $arg"
done

osascript <<ENDSCRIPT
  tell application "iTerm"
    activate
    set myterm to (create new window with default profile)
    tell myterm
        -- optional part to set size of the terminal window
        set number of columns to 80
        set number of rows to 24
        -- here's the important bit
        set mysession to (make new session at the end of sessions)
        tell mysession
            exec command $my_str
        end mysession
    end tell
  end tell 

ENDSCRIPT
