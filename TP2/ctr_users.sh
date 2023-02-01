#!/bin/bash

if [ $# -eq 0 ]
then

  echo "Utilisation: $0 $USER"
  exit 1
fi

if id "$1" >/dev/null 2>&1
then
  echo "L'utilisateur $1 existe"
else
  echo "L'utilisateur $1 n'existe pas"
fi
