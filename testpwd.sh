#!/bin/bash
PASSWORD="petitpassword"
read -s -p "Saisir le mot de passe: " PASSWORD_TEST
if [[ $PASSWORD == $PASSWORD_TEST ]] ; then
echo "Mot de passe correcte"
else
echo "Mot de passe incorrecte"
fi


