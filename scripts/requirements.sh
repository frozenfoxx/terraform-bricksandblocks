#!/usr/bin/env bash

# Installs all prerequisites

# Variables
TASK_INSTALL_PATH=${TASK_INSTALL_PATH:-'/usr/local/bin'}

# Functions

## Verify we have all required tools
check_commands()
{
  # Check for ansible-playbook
  if ! command -v ansible-playbook &> /dev/null; then
    install_ansible
  fi

  # Check for ansible-galaxy
  if ! command -v ansible-galaxy &> /dev/null; then
    install_ansible_galaxy
  fi

  # Check for git
  if ! command -v git &> /dev/null; then
    install_git
  fi

  # Check for rclone
  if ! command -v rclone &> /dev/null; then
    install_rclone
  fi

  # Check for Task
  if ! command -v task &> /dev/null; then
    install_task
  fi
}

## Install Ansible
install_ansible()
{
  echo "Installing ansible..."
  pyenv activate ansible
  pip3 install ansible
}

## Install Ansible Galaxy
install_ansible_galaxy()
{
  echo "Installing ansible-galaxy..."
  pyenv activate ansible
  pip3 install ansible-galaxy
}

## Install git
install_git()
{
  echo "Installing git..."
  apt-get update
  apt-get install git
}

## Install rclone
install_rclone()
{
  echo "Installing rclone..."
  sudo -v ; curl https://rclone.org/install.sh | sudo bash
}

## Install Task
install_task()
{
  echo "Installing task..."
  sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b ${TASK_INSTALL_PATH}
}

## Display usage
usage()
{
  echo "Usage: [Environment Variables] requirements.sh [options]"
  echo "  Environment Variables:"
  echo "  TASK_INSTALL_PATH  path for installing Task (default: /usr/local/bin)"
  echo "  Options:"
  echo "    -h | --help      display this usage information"
}

# Logic
## Argument parsing
while [[ "$#" > 1 ]]; do
  case $1 in
    -h | --help ) usage
                  exit 0
  esac
  shift
done

check_commands
