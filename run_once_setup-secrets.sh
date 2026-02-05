#!/bin/bash
if [ ! -f ~/.zsh/.secrets.env ]; then
  touch ~/.zsh/.secrets.env
  chmod 600 ~/.zsh/.secrets.env
  echo "~/.zsh/.secrets.env created. Fill in your keys."
fi
