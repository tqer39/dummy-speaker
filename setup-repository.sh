#!/bin/bash

# setup brew
if ! type brew > /dev/null 2>&1; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "brew installed."
else
  echo "brew is already installed."
fi
brew -v

# setup pyenv
if ! type pyenv > /dev/null 2>&1; then
  brew install pyenv
  echo "pyenv installed."
else
  echo "pyenv is already installed."
fi
pyenv -v

# install python
pyenv install -s
pyenv global $(pyenv versions --bare)
eval "$(pyenv init -)"
