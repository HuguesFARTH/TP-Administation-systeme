#!/bin/bash

function is_number()
{
re='^[+-]?[0-9]+([.][0-9]+)?$'
if ! [[ $1 =~ $re ]] ; then
return 1
else
return 0
fi
}


for param in $*; do
	is_number $param
	if [ $? -eq 0 ] ; then
		echo "$param -> est un nombre"
	else
		echo "$param -> n'est pas un nombre"
	fi
done
