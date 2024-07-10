#!/bin/bash

# setup brew
if ! type brew > /dev/null 2>&1; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "brew installed."
else
  echo "brew is already installed."
fi
