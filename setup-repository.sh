#!/bin/bash

echo "========================================"
echo "setup start."
echo "========================================"

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
pyenv global "$(pyenv versions --bare)"
eval "$(pyenv init -)"

if ! type python > /dev/null 2>&1; then
  echo "python not found."
else
  echo "python is already installed."
fi
python -V

# setup pip
if ! type pip > /dev/null 2>&1; then
  python -m pip install --upgrade pip
  echo "pip installed."
else
  echo "pip is already installed."
fi
pip -V

# install poetry
pip install -r requirements-poetry.txt
poetry -V

# install pre-commit
if ! type pre-commit > /dev/null 2>&1; then
  brew install pre-commit
  echo "pre-commit installed."
else
  echo "pre-commit is already installed."
fi
pre-commit --version
pre-commit install

echo "========================================"
echo "setup completed."
echo "========================================"
brew -v
pyenv -v
python -V
pip -V
poetry -V
pre-commit --version
