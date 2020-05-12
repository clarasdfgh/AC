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

export OMP_NUM_THREADS=3
echo -e "3 threads:"
srun ./matrizopena 5000
srun ./matrizopena 20000

export OMP_NUM_THREADS=6
echo -e "6 threads:"
srun ./matrizopena 5000
srun ./matrizopena 20000

export OMP_NUM_THREADS=9
echo -e "9 threads:"
srun ./matrizopena 5000
srun ./matrizopena 20000

export OMP_NUM_THREADS=12
echo -e "12 threads:"
srun ./matrizopena 5000
srun ./matrizopena 20000

