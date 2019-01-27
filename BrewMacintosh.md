# New Macintosh (using `brew`)

Untested so far, but I think the next Mac I set up will only require
copy-pasting the following script:

        # install my dotfiles
        cd ~ && git clone --recursive http://github.com/dwhswenson/dotfiles.git
        cd dotfiles
        ./install

        # install brew (http://brew.sh)
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew tap caskroom/cask
        brew tap homebrew/cask-fonts
        ./strip_comments brew_cask_fonts.txt | xargs brew cask install
        ./strip_comments brew_cask_installs.txt | xargs brew cask install
        ./strip_comments brew_installs.txt | xargs brew install

        # clean up brew stuff
        ## octave installs gnuplot without aquaterm support
        brew uninstall --ignore-dependencies gnuplot
        brew install gnuplot --with-aquaterm --with-x11 --with-qt

        # install conda
        OS_ARCH=MacOSX-x86_64
        source miniconda_install.sh
        conda config --add channels omnia
        conda config --add channels conda-forge

While this is running, go to the App Store and download anything needed from
there.
