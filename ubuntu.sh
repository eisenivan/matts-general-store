#!/bin/bash

# apt-get packages
sudo apt-get install git-core git-flow build-essentials python-dev python-  pip
curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash
npm config set prefix ~/.local/share/npm
nvm install stable
nvm alias default stable

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

# Install Atom code editor
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get install atom
