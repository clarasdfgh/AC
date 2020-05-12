#!/bin/bash

echo "N = 250"
for ((N=1;N<5;N=N+1))
do
	export OMP_NUM_THREADS=$N
	echo "threads = $N"
	./pmm-open 250
	echo ""
done

echo ""

echo "tamanio = 1250"
for ((N=1;N<5;N=N+1))
do
	export OMP_NUM_THREADS=$N
	echo "threads = $N"
	./pmm-open 1250
	echo ""
done
