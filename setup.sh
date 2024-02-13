#!/bin/zsh

# Script to install dotfiles automatically. This checks if a file
# with the same name already exists, but it CAN DELETE EXISITNG DOTFILES.
# Use at your own risk!

# Function used by the script to test for existing files and then
# make links if appropriate. Takes up to four arguments, but only the
# first is required:
#   #1: The name of the file -as it is stored in this folder-
#   #2: The path in which the file is to be placed (defaults to the home
#       directory)
#   #3: The prefix that should be prepended to the filename (if this
#       argument is "0", no prefix is added; otherwise, it defaults to '.')
#   #4: The suffix to be appended to the filename (defaults to no suffix)
check_and_copy () {
    dotfile_path=""
    prefix=""
    suffix=""
    response1=""
    response2=""

    # Check if a filename was given
    if [ -z $1 ]
    then
        echo "Error: No filename specified"
        return
    fi

    # Check if a path is given, if not, use the home directory
    if [ ! -z $2 ]
    then
        dotfile_path=$2
    else
        dotfile_path=~/
    fi

    # Check if a prefix is given, if not, use '.'
    if [ ! -z $3 ]
    then
        # Don't use a prefix if '0' is the given prefix. Sorry if you
        # need a prefix of '0' :(
        if [ $3 = 0 ]
        then
            prefix=""
        else
            prefix=$3
        fi
    else
        prefix="."
    fi

    # Check if a suffix is given
    if [ ! -z $4 ]
    then
        suffix=$4
    else
        suffix=""
    fi

    # Build filename
    filename=$prefix$1$suffix

    # Check if the path already exists
    if [ ! -e $dotfile_path ]
    then
        echo -n "Path $dotfile_path doesn't exist. Create?(y/N):"
        read response1
        if [ "$response1" = "y" ]
        then
            echo "Okay, creating path..."
            mkdir -p $dotfile_path
        else
            echo "Not creating path..."
        fi
    fi

    # Check if the final file already exists
    if [ -e $dotfile_path$filename ]
    then
        echo -n "Pre-existing $filename detected, overwrite?(y/N):"
        read response2
    fi

    # Make a link if the file doesn't exist or if we got permission. The path must also exist
    if ( [ "$response2" = "y" ] || [ ! -e $dotfile_path$filename ] ) && [ -e $dotfile_path ]
    then
        echo "Copying $filename..."
        ln -f ./$1 $dotfile_path$filename
    else
        echo "Skipping $filename..."
    fi
}

echo "Copying dotfiles..."
check_and_copy init.vim ~/.config/nvim/ "0"
check_and_copy zshrc
check_and_copy gitconfig
check_and_copy red ~/.oh-my-zsh/custom/themes/ "0" .zsh-theme
check_and_copy red-pop ~/.oh-my-zsh/custom/themes/ "0" .zsh-theme
check_and_copy tmux.conf
echo "Finished."
