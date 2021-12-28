# zshenv

In general, the `.zshenv` file is used to set information that needs to be
known for all runs: login and non-login; interactive and non-interactive. This
runs first (of the user files).

In the current setup (the Winter 2021-2022 version), when setting up for a new
computer you need to export the following variables:

* `UNISONLOCALHOSTNAME`: This is the custom name for the host. This should also
  be the name of the zshenv file within this directory (case-sensitive match).
* `DOTFILES_DIR`: The directory where the `dotfiles` repository can be found.
* `MINICONDA_ROOT` (if using conda): The root directory where all conda files
  are stored (usually `~/mambaforge`, `~/anaconda`, or `~/miniconda`).
