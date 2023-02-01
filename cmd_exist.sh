#!/bin/bash

if $1 >/dev/null 2>&1 
then
	echo "La commande $1 existe"
else
	echo "La commande $1 n'existe pas"
fi
