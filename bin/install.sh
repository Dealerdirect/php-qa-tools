#!/usr/bin/env bash
set -eu

# Ensure PHP is installed
if ! command -v php > /dev/null 2>&1; then
  echo "PHP is not found, installation aborted!"
  exit 1
fi

# Ensure Composer is installed/updated
if ! command -v composer > /dev/null 2>&1; then
  echo "*** Installing Composer ***"
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

  if [ \
      "$(curl -S https://composer.github.io/installer.sig)" = \
      "$(php -r \"echo hash_file\('SHA384', 'composer-setup.php'\);\")" \
  ]; then
      php composer-setup.php --quiet --filename=composer
      sudo mv composer /usr/local/bin/composer
      rm composer-setup.php
  else
      >&2 echo 'ERROR: Invalid composer installer signature'
      rm composer-setup.php
      exit 1
  fi
fi

echo "*** Updating shell profiles ***"
# Add Composer's Global Bin to ~/.profile path
if [[ ! -f "$HOME/.profile" ]]; then
  touch "$HOME/.profile"
fi
if grep -q -F "export COMPOSER_HOME=$HOME/.composer" "$HOME/.profile"; then
  echo "export COMPOSER_HOME=$HOME/.composer" >> "$HOME/.profile"
fi
if grep -q -F "export PATH=$PATH:\$COMPOSER_HOME/vendor/bin" "$HOME/.profile"; then
  echo "export PATH=$PATH:\$COMPOSER_HOME/vendor/bin" >> "$HOME/.profile"
fi

# Source the .profile to pick up changes
# shellcheck source=/dev/null
source "$HOME/.profile"

# Test if ZSH is installed
if command -v zsh > /dev/null 2>&1; then
  # Add Composer's Global Bin to ~/.zprofile path
  if [[ ! -f "$HOME/.zprofile" ]]; then
    touch "$HOME/.zprofile"
  fi
  if grep -q -F "export COMPOSER_HOME=$HOME/.composer" "$HOME/.zprofile"; then
    echo "export COMPOSER_HOME=$HOME/.composer" >> "$HOME/.zprofile"
  fi
  if grep -q -F "export PATH=$PATH:$COMPOSER_HOME/vendor/bin" "$HOME/.zprofile"; then
    echo "export PATH=$PATH:$COMPOSER_HOME/vendor/bin" >> "$HOME/.zprofile"
  fi

  # Source the .zprofile to pick up changes
  # shellcheck source=/dev/null
  source "$HOME/.zprofile"
fi

# Ensure Dealerdirect PHP QA tools are installed globally
echo "*** Installing Dealerdirect PHP QA Tools ***"
composer global require "dealerdirect/qa-tools:@dev"

echo "*** Updating Dealerdirect PHP QA Tools ***"
composer global update "dealerdirect/qa-tools:@dev"
