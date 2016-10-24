#!/usr/bin/env bash

# Ensure PHP is installed
php -v > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
  echo "PHP is not found, installation aborted!"
  exit 1
fi

# Check if Composer is already globally available
composer -v > /dev/null 2>&1

# Ensure Composer is installed/updated
if [[ $? -ne 0 ]]; then
  echo "*** Installing Composer ***"

  EXPECTED_SIGNATURE=$(wget https://composer.github.io/installer.sig -O - -q)
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

  if [ "$EXPECTED_SIGNATURE" = "$ACTUAL_SIGNATURE" ]
  then
      php composer-setup.php --quiet --filename=composer
      RESULT=$?
      if [[ $? -eq 0 ]]; then
        sudo mv composer /usr/local/bin/composer
        RESULT=$?
      fi
      rm composer-setup.php
      if [[ RESULT -ne 0 ]]; then
        exit $RESULT
      fi
  else
      >&2 echo 'ERROR: Invalid composer installer signature'
      rm composer-setup.php
      exit 1
  fi
else
  echo "*** Updating Composer ***"
  composer selfupdate > /dev/null 2>&1
  if [[ $? -ne 0 ]]; then
    composer global update "composer/composer"
  fi
fi

echo "*** Updating shell profiles ***"
# Add Composer's Global Bin to ~/.profile path
if [[ ! -f "~/.profile" ]]; then
  touch ~/.profile
fi
grep -q -F 'export COMPOSER_HOME="~/.composer"' ~/.profile || echo 'export COMPOSER_HOME="~/.composer"' >> ~/.profile
grep -q -F 'export PATH=$PATH:$COMPOSER_HOME/vendor/bin' ~/.profile || echo 'export PATH=$PATH:$COMPOSER_HOME/vendor/bin' >> ~/.profile

# Source the .profile to pick up changes
. ~/.profile

# Test if ZSH is installed
zsh --version > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
  # Add Composer's Global Bin to ~/.zprofile path
  if [[ ! -f "~/.zprofile" ]]; then
    touch ~/.zprofile
  fi
  grep -q -F 'export COMPOSER_HOME="~/.composer"' ~/.zprofile || echo 'export COMPOSER_HOME="~/.composer"' >> ~/.zprofile
  grep -q -F 'export PATH=$PATH:$COMPOSER_HOME/vendor/bin' ~/.zprofile || echo 'export PATH=$PATH:$COMPOSER_HOME/vendor/bin' >> ~/.zprofile

  # Source the .zprofile to pick up changes
  . ~/.zprofile
fi

# Ensure Dealerdirect PHP QA tools are installed globally
echo "*** Installing Dealerdirect PHP QA Tools ***"
composer global require "dealerdirect/qa-tools:@dev"

echo "*** Updating Dealerdirect PHP QA Tools ***"
composer global update "dealerdirect/qa-tools:@dev"
