# New AWS DevBox setup

1. Install dotfiles:

        cd ~ && git clone --recursive https://github.com/dwhswenson/dotfiles.git
        cd dotfiles && ./install

2. apt-install a few things:

   Ubuntu

        sudo apt install zsh direnv nodejs

   Amazon Linux
  
        sudo yum install git 

2. Install oh-my-zsh:

        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        mv .zshrc.pre-oh-my-zsh .zshrc

3. Add `.zshenv` for the DevBox:

        echo 'source ${HOME}/dotfiles/shell/zshenv/devbox' > .zshenv

4. Install `pixi` and/or `uv`:

        curl -fsSL https://pixi.sh/install.sh | sh

        curl -LsSf https://astral.sh/uv/install.sh | sh

5. If desired, install miniforge:

        curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
        bash Miniforge3-Linux-x86_64.sh


