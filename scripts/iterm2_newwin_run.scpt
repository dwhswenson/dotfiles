-- iterm2 v3
on run argv
    -- argv is pwd, followed by rest_of_args
    set mydir to (quoted form of first item of argv)
    set rest_of_args to (items 2 thru -1 of argv)
    set AppleScript's text item delimiters to space
    set arg_str to (rest_of_args as string)
    set cmd to "cd " & mydir & " && " & arg_str
    set bash_wrap to "bash -l -c \"" & cmd & "\""
    tell application "iTerm"
        activate
        create window with default profile command bash_wrap
    end tell
end run
