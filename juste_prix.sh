#!/bin/bash

price=$((1000*$RANDOM))
price=$(($price/32767))
echo $price
win=0
while [ $win -eq 0 ]
do
read -p "Devinez le nombre: " nombre
if [ $nombre -eq $price ]; then
	echo "Gagné!"
	win=1
elif [ $nombre -gt $price ]; then
	echo "C'est moins !";
else
	echo "C’est plus !";
fi

done

