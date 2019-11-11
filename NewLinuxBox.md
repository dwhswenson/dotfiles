# New Cluster Account

1. Install dotfiles:

        cd ~ && git clone --recursive https://github.com/dwhswenson/dotfiles.git
        cd dotfiles && ./install

2. Install `conda`:

        MINICONDA_ROOT=$HOME  # or other
        CONDA_PY=3.7
        source miniconda_install.sh
        conda init
        conda config --add channels omnia
        conda config --add channels conda-forge

3. Add a few packages to the `base` conda env:

        conda install glances
        pip install thefuck

3. Set up miscellaneous things:

        sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc # RESPECT MY ZSHRC, OMZ!
        # Vundle plugins
        vim "+PluginInstall" "+q" "+q"

4. Set up computer-specific bashrc

* set up computer specific bashrc (add conda to $PATH)

5. Set up SSH keys for the new machine

5. Compile YouCompleteMe

        cd ~/.vim/bundle/YouCompleteMe
        ./install.py --clang-completer

6. Make ssh keys and copy them over

        # in .ssh/ directory on local machine
        ssh-keygen -t rsa
        ssh-copy-id -i ~/.ssh/mykey user@host

6. Copy `.ssh` over. 

6. Copy private GPG key over (for signing commits)

7. Install dev version of OPS from my fork, with other forks as remotes

        mkdir src
        pushd src
        git clone git@github.com:dwhswenson/openpathsampling.git
        cd openpathsampling
        git remote add upstream https://github.com/openpathsampling/openpathsampling.git
        git remote add jhp https://github.com/jhprinz/openpathsampling.git
        python devtools/install_recipe_requirements.py devtools/conda-recipe/meta.yaml
        pip install -e .

8. Install dev versions of other software


### Directory structure

```
$HOME/
  dotfiles/
  installed/
    (source packages for installed things; e.g. GSL)
  src/
    openpathsampling/
    openmmtools/
    ipynb-test/
    ...
  projects/
```

with subdirectories of `projects/` often having symlinks to the main
directory
