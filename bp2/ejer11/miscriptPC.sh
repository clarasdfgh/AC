#!/bin/bash

echo "Id. usuario del trabajo: $SLURM_JOB_USER"
echo "Id. del trabajo: $SLURM_JOBID"
echo "Nombre del trabajo especificado por usuario: $SLURM_JOB_NAME"
echo "Directorio de trabajo (en el que se ejecuta el script):"
echo "$SLURM_SUBMIT_DIR"
echo "Cola: $SLURM_JOB_PARTITION"
echo "Nodo que ejecuta este trabajo:$SLURM_SUBMIT_HOST"
echo "No de nodos asignados al trabajo: $SLURM_JOB_NUM_NODES"
echo "Nodos asignados al trabajo: $SLURM_JOB_NODELIST"
echo "CPUs por nodo: $SLURM_JOB_CPUS_PER_NODE"
export OMP_DYNAMIC=FALSE

export OMP_NUM_THREADS=1
echo -e "1 thread:"
./matrizopena 5000
./matrizopena 20000

export OMP_NUM_THREADS=2
echo -e "2 threads:"
./matrizopena 5000
./matrizopena 20000

export OMP_NUM_THREADS=3
echo -e "3 threads:"
./matrizopena 5000
./matrizopena 20000

export OMP_NUM_THREADS=1
echo -e "4 threads:"
./matrizopena 5000
./matrizopena 20000

