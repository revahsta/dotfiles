#!/bin/bash

# Install neovim and the vim-plug plugin manager

# Warn if vim is present
if command -v vim &> /dev/null
then
    echo "Vim is already installed, you may have to run update-alternatives or similar to set neovim to the default."
fi

# Install neovim
if command -v nvim &> /dev/null
then
    echo "Neovim is already installed, skipping..."
else
    sudo apt-get install neovim
fi

if command -v curl &> /dev/null
then
    echo "curl is already installed, skipping..."
else
    sudo apt-get install curl
fi

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

