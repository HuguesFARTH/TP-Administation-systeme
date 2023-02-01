#!/bin/bash

function is_number()
{
	re='^[+-]?[0-9]+)?$'
	if ! [[ $1 =~ $re ]] ; then
		return 1
	else
		return 0
	fi
}

if [ $# -eq 0 ]; then
echo "Vous n'avez pas mis de paramètre: entrez-les maintenant et écrivez \"FIN\" une fois fini"
tab=()
index=0
read -p ">" entry
while [[entry!="FIN"]]; do
read -p ">" entry
done
echo tab
exit 0
sum=0
for param in $*; do
	is_number $param
	if ! [ $? -eq 0 ] ; then
		echo "$param -> n'est pas un nombre"
		exit 0
	fi
	sum=$(($sum+$param))
done

echo "Moyenne: " $(($sum/$#))