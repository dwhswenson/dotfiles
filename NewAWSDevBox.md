# New AWS DevBox setup

1. Install a few things via package manager:

   Ubuntu

        sudo apt install zsh nodejs

   Amazon Linux
  
        sudo yum install git zsh util-linux-user

2. NVM and Node:

        sudo yum install libatomic
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
        . ~/.nvm/nvm.sh
        nvm install node

2. Set zsh as the default shell:

        sudo chsh -s $(which zsh) $(whoami)

2. Install dotfiles:

        cd ~ && git clone --recursive https://github.com/dwhswenson/dotfiles.git
        cd dotfiles && ./install

3. Install oh-my-zsh:

        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        mv .zshrc.pre-oh-my-zsh .zshrc

4. Add `.zshenv` for the DevBox:

        echo 'source ${HOME}/dotfiles/shell/zshenv/devbox' > .zshenv

5. Add direnv

   Ubuntu

       sudo apt install direnv

   Amazon Linux

       curl -sfL https://direnv.net/install.sh | bash


5. Install `pixi` and/or `uv`:

        curl -fsSL https://pixi.sh/install.sh | sh

        curl -LsSf https://astral.sh/uv/install.sh | sh

6. If desired, install miniforge:

        curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
        bash Miniforge3-Linux-x86_64.sh


