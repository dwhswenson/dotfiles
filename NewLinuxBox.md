# New Cluster Account

1. Install `conda`:

        CONDA_PY="3.7" curl https://raw.githubusercontent.com/openpathsampling/openpathsampling/master/devtools/ci/miniconda_install.sh | bash

   If that doesn't do it, the longer version should work:

        MINICONDA=Miniconda3-latest-Linux-x86_64.sh
        MINICONDA_MD5=$(curl -s https://repo.continuum.io/miniconda/ | grep -A3 $MINICONDA | sed -n '4p' | sed -n 's/ *<td>\(.*\)<\/td> */\1/p')
        wget https://repo.continuum.io/miniconda/$MINICONDA
        if [[ $MINICONDA_MD5 != $(md5sum $MINICONDA | cut -d ' ' -f 1) ]]; then
            echo "Miniconda MD5 mismatch"
            echo "Expected: $MINICONDA_MD5"
            echo "Found: $(md5sum $MINICONDA | cut -d ' ' -f 1)"
            exit 1
        fi
        bash $MINICONDA -b

        conda config --add channels http://conda.anaconda.org/omnia
        conda update --yes conda


2. Install things from conda:

        conda install git cmake gcc conda

3. Set up dotfiles:

        cd ~ && git clone --recursive https://github.com/dwhswenson/dotfiles.git
        # (a) Install my dotfiles
        # correct my git config info if $HOME is not /Users/dwhs/
        ./install
        sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc # RESPECT MY ZSHRC, OMZ!
        # Vundle plugins
        vim "+PluginInstall" "+q" "+q"

4. Set up computer-specific bashrc

* set up computer specific bashrc (add conda to $PATH)

5. Compile YouCompleteMe

        cd ~/.vim/bundle/YouCompleteMe
        ./install.py --clang-completer

6. Copy `.ssh` over. If server, create keys on local machine and use
   `ssh-copy-id` to copy make it reachable.


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
