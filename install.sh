#!/usr/bin/env bash

set -eux
echo "TEST" > $HOME/test.txt

# copy files over
cp -r files $HOME
cp -r scripts $HOME/scripts

# install homebrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install poetry
# curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -

# install AWS CLI - https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
# install Docker - https://hub.docker.com/editions/community/docker-ce-desktop-mac

# Install iTerm2
# brew cask install iterm2
# curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

# Homebrew
# brew install git zsh zsh-completions pgcli pre-commit python pyenv pyenv-virtualenv kubernetes-cli aws-iam-authenticator postgresql@13 redis github/gh/gh volta rust pipx graphql-playground visual-studio-code openssl

# Powerline fonts
# git clone https://github.com/powerline/fonts.git && cd fonts && ./install.sh

# Install oh-my-zsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" --unattended

# helpful shell tools
# brew install fd fzf jq rg

# homebrew services
# brew services start redis
# brew services start postgresql

# Volta
# volta setup

# Compilers
# xcode-select --install

# Pip
# pip3 install pykubectl ipython

# Python libraries
# pipx install black
# pipx install cookiecutter
# pipx install fourmat
# pipx install howdoi
# pipx install httpie
# pipx install ipython
# pipx install --include-deps jupyter
# pipx install markdown
# pipx install poetry
# pipx install pyupgrade
# pipx install tox

# PyEnv
# pyenv install 3.9-dev
# pyenv global 3.9-dev
# pyenv local 3.9-dev  # for each repository
# poetry config virtualenvs.in-project true  # for each repository
