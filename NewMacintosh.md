# New Macintosh

Here is the sequence in which I should download things when I get a new Mac,
in an effort to maximize my sanity.


1. App Store: Start with XCode (that will take a while)

2. [Google Chrome](http://www.google.com/chrome/)

3. [Dropbox](https://www.dropbox.com/) (sync will also take a while)

4. [QuickSilver](http://www.qsapp.com/)

5. [iTerm 2](http://www.iterm2.com/)

6. [Source Code Pro](http://www.fontsquirrel.com/fonts/source-code-pro):
   install by drag-n-drop in Font Book

6. [MacPorts](https://www.macports.org/)

        sudo xcodebuild -license
        cd ~ && git clone --recursive http://github.com/dwhswenson/dotfiles.git
        cd dotfiles
        # correct my git config info if $HOME is not /Users/dwhs/
        ./install
        #./defaults_write #TODO
        sudo sh < ports_to_install.txt
        # switch to zsh
        sudo chsh -s /opt/local/bin/zsh
        # Vundle plugins
        vim "+PluginInstall" "+q" "+q"
        # Python install (using MacPorts -- others might prefer conda)
        sudo sh < ports_python.txt


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
