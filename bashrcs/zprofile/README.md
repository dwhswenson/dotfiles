# zprofile

The `zprofile` script only runs for login shells. Use files in the `login`
directory to create files that can be sourced later in the process (and in
non-login shells). Those commands are usually slower and just create a script
to be sourced, so we only generate them per login.
