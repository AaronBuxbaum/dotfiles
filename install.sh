#!/bin/bash

# copy files over
rsync -r files/ $HOME
rsync -r scripts/ $HOME/scripts

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install AWS CLI
# install Docker
# install VSCode
# install GraphQL Playground
# Install iTerm2

# iTerm zsh integration
curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

# add homebrew to PATH
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Homebrew
brew install git zsh zsh-completions starship poetry pgcli pre-commit python pyenv pyenv-virtualenv kubernetes-cli aws-iam-authenticator postgresql redis gh volta rust pipx openssl
brew install fd fzf jq rg  # helpful shell tools

# Powerline fonts
git clone https://github.com/powerline/fonts.git && cd fonts && ./install.sh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" --unattended

# homebrew services
brew services start redis
brew services start postgresql

# Volta
volta setup

# Compilers
# xcode-select --install

# pip
pip3 install pykubectl ipython

# Python libraries
pipx install black
pipx install cookiecutter
pipx install fourmat
pipx install howdoi
pipx install httpie
pipx install ipython
pipx install --include-deps jupyter
pipx install markdown
pipx install poetry
pipx install pyupgrade
pipx install tox

# PyEnv
# pyenv install 3.9-dev
# pyenv global 3.9-dev
# pyenv local 3.9-dev  # for each repository
# poetry config virtualenvs.in-project true  # for each repository
