#!/bin/bash

# apt-get packages
sudo apt-get install build-essential curl git git-core zsh m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev

# Install Oh-My-ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install HomeBrew for Linux
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"

# Write these lines to .zshrc file
echo ' ' >> ~/.zshrc
echo 'export PATH="$HOME/.linuxbrew/bin:$PATH"' >> ~/.zshrc
echo 'export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"' >> ~/.zshrc
echo 'export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"' >> ~/.zshrc

brew update

# Install node.js
brew install node

# Install Atom code editor
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get install atom
