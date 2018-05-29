# New Cluster Account

1. Install `conda`:

        MINICONDA=Miniconda2-latest-Linux-x86_64.sh
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

        conda install git cmake gcc openpathsampling

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

6. Copy `.ssh` over

7. Install dev versions of software (openpathsampling, etc.)


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
