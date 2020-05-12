#!/bin/bash
echo "Id. usuario del trabajo: $SLURM_JOB_USER"
echo "Id. del trabajo: $SLURM_JOBID"
echo "Nombre del trabajo especificado por usuario: $SLURM_JOB_NAME"
echo "Directorio de trabajo (en el que se ejecuta el script):
$SLURM_SUBMIT_DIR"
echo "Cola: $SLURM_JOB_PARTITION"
echo "Nodo que ejecuta este trabajo:$SLURM_SUBMIT_HOST"
echo "No de nodos asignados al trabajo: $SLURM_JOB_NUM_NODES"
echo "Nodos asignados al trabajo: $SLURM_JOB_NODELIST"
echo "CPUs por nodo: $SLURM_JOB_CPUS_PER_NODE"

echo "n = 250" >> salidaatc
for ((N=2;N<13;N=N+2))
do
	export OMP_NUM_THREADS=$N
	echo "threads = $N" >> salidaatc
	srun ./pmm-open 250 >> salidaatc
	echo "" >> salidaatc
done

echo "n = 1250">> salidaatc
for ((N=2;N<13;N=N+2))
do
	export OMP_NUM_THREADS=$N
	echo "threads = $N" >> salidaatc
	srun ./pmm-open 1250 >> salidaatc
	echo "" >> salidaatc
done
