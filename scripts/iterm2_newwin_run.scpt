on run argv
    tell application "iTerm"
        activate -- although it's probably already active
        set myterm to (make new terminal)
        set mydir to (quoted form of first item of argv)
        set rest_of_args to (items 2 thru -1 of argv)
        set AppleScript's text item delimiters to space
        set arg_str to ( rest_of_args as string)
        tell myterm
            -- optional part to set size of terminal window
            set number of columns to 80
            set number of rows to 24
            -- here's the important bit
            set mysession to (make new session at the end of sessions)
            tell mysession
                --exec command "echo " &  arg_str & " " & mydir
                set cdcmd to ("cd " & mydir)
                set runit to "bash -l -c \"" & cdcmd & " && " & arg_str & "\""
                --exec command "echo " & runit -- DEBUG
                exec command "bash -l -c \"" & cdcmd & " && " & arg_str & "\""
            end tell
        end tell
    end tell
end run
