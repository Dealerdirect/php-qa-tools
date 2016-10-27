#!/usr/bin/env bash
# ==============================================================================
#
# Dealerdirect PHP QA Tools Installer
#
# Installs Composer and the Dealerdirect PHP Quality Assurance tools
# globally on your system.
#
# ==============================================================================
# MIT License
#
# Copyright (c) 2016 Dealerdirect B.V.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
# ==============================================================================
set -o errexit  # Exit script when a command exits with non-zero status
set -o nounset  # Exit script on use of an undefined variable
set -o pipefail # Return exit status of the last command in the pipe that failed

# ==============================================================================
# GLOBALS
# ==============================================================================
readonly EX_OK=0	            # Successful termination
readonly EX_PHP_NOT_FOUND=3   # PHP was not found
readonly EX_GIT_NOT_FOUND=4   # GIT not found
readonly EX_CURL_NOT_FOUND=5  # curl not found
readonly EX_NET_ERR=6         # Something went wrong during a file download
readonly EX_SIG_MISMATCH=7    # Composer installer signature mismatch
readonly EX_SETUP_ERR=8       # Composer setup failure

# Temporary directory for storing the Composer setup script
readonly COMPOSER_TMPDIR=$(mktemp -d "/tmp/composer.XXXXXXXXXXXX")

# ==============================================================================
# UTILITY
# ==============================================================================

# ------------------------------------------------------------------------------
# Displays a status message
# Globals:
#   None
# Arguments:
#   $* Status message to display
# Returns:
#   None
# ------------------------------------------------------------------------------
display_status_message() {
  local status=$*

  echo
  echo "-----> $*"
  echo
}

# ------------------------------------------------------------------------------
# Displays a notice
# Globals:
#   None
# Arguments:
#   $* Notice message to display
# Returns:
#   None
# ------------------------------------------------------------------------------
display_notice_message() {
  local status=$*

  echo
  echo "NOTICE: $*"
  echo
}

# ------------------------------------------------------------------------------
# Displays a error message and is able to terminate te script execution
# Globals:
#   None
# Arguments:
#   $1 Error message
#   $2 Exitcode, script will continue execution when omitted
# Returns:
#   None
# ------------------------------------------------------------------------------
display_error_message() {
  local status=$1
  local exitcode=${2:-0}

  echo >&2
  echo " !     ERROR: $status" >&2
  echo >&2

  if [[ $exitcode -ne 0 ]]; then
    exit "$exitcode"
  fi
}

# ==============================================================================
# SCRIPT LOGIC
# ==============================================================================

# ------------------------------------------------------------------------------
# Check if required tools for this script are installed.
# Globals:
#   EX_CURL_NOT_FOUND
#   EX_GIT_NOT_FOUND
#   EX_PHP_NOT_FOUND
#   UID
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
check_runtime_requirements() {
  type php > /dev/null 2>&1 || display_error_message \
      'PHP is not found, installation aborted!' $EX_PHP_NOT_FOUND
  type git > /dev/null 2>&1 || display_error_message \
      'GIT is not found, installation aborted!' $EX_GIT_NOT_FOUND
  type curl > /dev/null 2>&1 || display_error_message \
      'curl is not found, installation aborted!' $EX_CURL_NOT_FOUND
}

# ------------------------------------------------------------------------------
# Install composer on this system
# Globals:
#   COMPOSER_TMPDIR
#   EX_SETUP_ERR
#   EX_SIG_MISMATCH
#   EX_NET_ERR
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
install_composer() {
  local composer_filename="composer"
  local composer_setup="$COMPOSER_TMPDIR/composer-setup.php"
  local composer_temp="$COMPOSER_TMPDIR/$composer_filename"
  local composer_dest="/usr/local/bin/$composer_filename"

  display_status_message 'Downloading Composer setup'
  command curl -o "$composer_setup" 'https://getcomposer.org/installer' ||
    display_error_message 'Failed downloading Composer installer' $EX_NET_ERR

  display_status_message 'Checking Composer setup signature'

  if [ \
      "$(command curl -S https://composer.github.io/installer.sig)" != \
      "$(command php -r "echo hash_file(\"SHA384\", \"$composer_setup\");")" \
  ]; then
      display_error_message \
        'Invalid composer installer signature' $EX_SIG_MISMATCH
  fi

  display_status_message 'Running Composer setup'
  command php "$composer_setup" --quiet --filename="$composer_filename" \
    --install-dir="$COMPOSER_TMPDIR" || display_error_message \
    'Error occured while running Composer setup' $EX_SETUP_ERR

  display_notice_message \
    'Installing Composer globally. Administrator privileges will be required...'
  sudo mv "$composer_temp" "$composer_dest" ||
    display_error_message \
      "Failed moving Composer to $composer_dest" $EX_SETUP_ERR

  display_status_message 'Composer has been installed.'
}

# ------------------------------------------------------------------------------
# Updates a shell profile with extra environment variables.
# Globals:
#   COMPOSER_TMPDIR
#   HOME
# Arguments:
#   $1 Profile file to update
# Returns:
#   None
# ------------------------------------------------------------------------------
update_profile() {
  local profile="$HOME/$1"

  display_status_message "Updating profile file '$profile'"

  if [[ ! -f "$profile" ]]; then
    command touch "$profile"
  fi

  update_profile_export "COMPOSER_HOME" "$HOME/.composer" "$profile"
  update_profile_export "PATH" "\$PATH:\$COMPOSER_HOME/vendor/bin" "$profile"
}

# ------------------------------------------------------------------------------
# Helper function for ensuring an enviroment variable is exported profile file
# Globals:
#   None
# Arguments:
#   $1 Enviroment variable name to export
#   $2 Value of enviroment variable to export
#   $3 Profile file to update
# Returns:
#   None
# ------------------------------------------------------------------------------
update_profile_export() {
  local export_line="export ${1}=${2}"
  local profile=$3

  if ! grep -q -F "${export_line}" "$profile"; then
    echo "$export_line" >> "$profile"
  fi
}

# ------------------------------------------------------------------------------
# Uses Composer to install the QA tools
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
install_qa_tools() {
  display_status_message \
    'Installing Composer Prestissimo in order to speed up next steps'
  command composer global require 'hirak/prestissimo:^0.3'

  display_status_message 'Installing Dealerdirect PHP QA Tools'
  command composer global require 'dealerdirect/qa-tools:*'

  display_status_message 'Removing local Prestissimo dependency'
  command composer global remove 'hirak/prestissimo'
}

# ------------------------------------------------------------------------------
# Runs Composer updating the QA tools
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
update_qa_tools() {
  display_status_message 'Updating Dealerdirect PHP QA Tools'
  command composer global update 'dealerdirect/qa-tools'
}

# ------------------------------------------------------------------------------
# Cleanup function after execution is of the script is stopped. (trap)
# Globals:
#   COMPOSER_TMPDIR
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
cleanup() {
  command rm -f -r "$COMPOSER_TMPDIR"
}

# ==============================================================================
# RUN LOGIC
# ------------------------------------------------------------------------------
# Globals:
#   EX_OK
#   HOME
#   SHELL
# Arguments:
#   None
# Returns:
#   None
# ------------------------------------------------------------------------------
main() {
  trap cleanup ERR
  trap cleanup EXIT

  check_runtime_requirements
  type composer > /dev/null 2>&1 || install_composer

  update_profile '.profile'
  if [[ "$(basename "$SHELL")" = 'zsh' ]]; then
    update_profile '.zprofile'
  fi

  if ! grep -q -F "dealerdirect/qa-tools" \
   "$HOME/.composer/composer.json" > /dev/null 2>&1;
  then
    install_qa_tools
  else
    update_qa_tools
  fi

  display_status_message 'Installation completed.'

  display_notice_message \
    'Your shell enviroment might have been changed.' \
    'Please restart your terminal session.'

  exit $EX_OK
}
main
