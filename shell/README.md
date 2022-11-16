# Shell configurations

This handles various configuration stuff for shells, specifically zsh and (when
necessary) bash.

See useful information here: https://blog.flowblok.id.au/2013-02/shell-startup-scripts.html


## Setting up a new computer

### zsh

1. Create a file at `zshenv/$UNISONLOCALHOSTNAME`. This **must** export the
   environment variable `$UNISONLOCALHOSTNAME`, `$DOTFILES_DIR`, and, if used,
   `$MINICONDA_ROOT`. It **may** set the variable `$_LOGINSCRIPTS` (defaults
   to `~/.loginscripts`). It **must** end by sourcing
   `$DOTFILES_DIR/shell/zshenv/generic`.

2. Create a file at `zprofile/$UNISONLOCALHOSTNAME`. This **must** source all
   `login` files that are used, and could require sourcing files in `rcs` that
   are required for later logins.

3. Create a file at `rcs/$UNISONLOCALHOSTNAME`. This set any computer-specific
   interactive parameters, and should source all `rcs` and `aliases` scripts
   used on that machine.

TODO: `rcs` directory is still a little cluttered; might be good to split it
out a little more.
