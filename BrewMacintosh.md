# New Macintosh (using `brew`)

Untested so far, but I think the next Mac I set up will only require
copy-pasting the following script:

        # install my dotfiles
        cd ~ && git clone --recursive http://github.com/dwhswenson/dotfiles.git
        cd dotfiles
        ./install

        # install brew (http://brew.sh)
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew tap homebrew/cask
        brew tap homebrew/cask-fonts
        ./strip_comments brew_installs.txt | xargs brew install
        ./strip_comments brew_cask_fonts.txt | xargs brew install --cask
        ./strip_comments brew_cask_installs.txt | xargs brew install --cask

        # clean up brew stuff
        ## octave installs gnuplot without aquaterm support
        brew uninstall --ignore-dependencies gnuplot
        brew install gnuplot --with-aquaterm --with-x11 --with-qt

        # NOTE: from here down will be platform-independent
        # get zsh set up
        sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc # RESPECT MY ZSHRC, OMZ!
        sudo chsh -s /usr/local/bin/zsh dwhs # or whatever my username is

        # set up Vundle plugings in vim
        vim "+PluginInstall" "+q" "+q"
        pushd ~/.vim/bundle/YouCompleteMe
        ./install.py --clang-completer
        popd


        # install conda
        OS_ARCH=MacOSX-x86_64
        source miniconda_install.sh
        conda config --add channels omnia
        conda config --add channels conda-forge
        # TODO: add conda envs in here

        # install latex things
        tlmgr --usermode init-usertree
        ./strip_comments latex_installs.txt | xargs tlmgr --usermode install

While this is running, go to the App Store and download anything needed from
there.
