#!/bin/bash
tmp=1
for i in $(seq 1 $1); do
	tmp=$(($tmp*$i))
done
echo $tmp
