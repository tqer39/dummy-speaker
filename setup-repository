#!/bin/bash -ue

echo "========================================"
echo "setup start."
echo "========================================"

# setup brew
if command -v brew ; then
  echo "skip brew installation."
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "brew installed."
fi
brew -v

# setup pyenv
if command -v pyenv; then
  echo "skip pyenv installation."
else
  brew install pyenv
  echo "pyenv installed."
fi
pyenv -v

# install python
pyenv install -s
pyenv global "$(pyenv versions --bare)"
eval "$(pyenv init -)"

if command -v python; then
  echo "python is already installed."
else
  echo "python not found."
fi
python -V

# setup pip
if command -v pip; then
  echo "skip pip installation."
else
  python -m pip install --upgrade pip
  echo "pip installed."
fi
pip -V

# install poetry
pip install -r requirements-poetry.txt
poetry -V

# install pre-commit
if command -v pre-commit; then
  echo "skip pre-commit installation."
else
  brew install pre-commit
  echo "pre-commit installed."
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
