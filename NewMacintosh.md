# New Macintosh

Here is the sequence in which I should download things when I get a new Mac,
in an effort to maximize my sanity.


1. App Store: Install XCode. Once installed, run:

        sudo xcodebuild -license
        sudo xcode-select --install

2. [Google Chrome](http://www.google.com/chrome/)

3. [Dropbox](https://www.dropbox.com/) (sync will also take a while)

4. [QuickSilver](http://www.qsapp.com/)

5. [iTerm 2](http://www.iterm2.com/)

6. [Source Code Pro](http://www.fontsquirrel.com/fonts/source-code-pro):
   install by drag-n-drop in Font Book

6. [MacPorts](https://www.macports.org/)

        cd ~ && git clone --recursive http://github.com/dwhswenson/dotfiles.git
        cd dotfiles
        # (a) Install my dotfiles
        # correct my git config info if $HOME is not /Users/dwhs/
        ./install
        #./defaults_write #TODO
        # (b) Install most MacPorts packages
        sudo sh < ports_to_install.txt
        # (c) Install python MacPorts packages (others might prefer conda)
        sudo sh < ports_python.txt
        # (d) Miscellaneous post-MacPorts cleanup
        # switch to zsh
        sudo chsh -s /opt/local/bin/zsh
        sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        # Vundle plugins
        vim "+PluginInstall" "+q" "+q"


7. [YouCompleteMe](https://github.com/Valloric/YouCompleteMe): should be
   downloaded by Vundle, but need to compile

        cd ~/.vim/bundle/YouCompleteMe
        ./install.py --clang-completer

8. App Store: get what you need

9. [OmniFocus]()

10. [OmniGraffle]() (old version needs to be installed from disk)

12. [Adium](https://adium.im/)

12. [f.lux]()

13. [Papers]()

14. [OmniPlan]()

15. [Grace]()

16. [Sage](http://www.sagemath.org/)

18. [OpenMM](http://openmm.org/)

19. Link various things to `~/bin/`:

        mkdir ~/bin && cd ~/bin
        ln -s /opt/local/bin/ggdb gdb
        # VMD
        # grace?
        ln -s /Applications/SageMath*.app/Contents/Resources/sage/sage sage
        # bin also has flatex and pyclewn stuff... might be useful
        # latexrevise, too. And a nice nbstripout (only old style ipynbs?)
