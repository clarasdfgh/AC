#!/bin/bash
#Órdenes para el sistema de colas:
#1. Asigna al trabajo un nombre
#SBATCH --job-name=helloOMP
#2. Asignar el trabajo a una cola (partición)
#SBATCH --partition=ac
#2. Asignar el trabajo a un account
#SBATCH --account=ac

#Obtener información de las variables del entorno del sistema de colas:
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


echo ""
echo "SUMAVECTORES SECUENCIAL: "
echo ""
time ./SumaVectores 		16384     >> datos.txt
time ./SumaVectores 		32768     >> datos.txt
time ./SumaVectores 		65536     >> datos.txt
time ./SumaVectores 		131072    >> datos.txt
time ./SumaVectores 		262144    >> datos.txt
time ./SumaVectores 		524288    >> datos.txt
time ./SumaVectores 		1048576   >> datos.txt
time ./SumaVectores 		2097152   >> datos.txt
time ./SumaVectores 		4194304   >> datos.txt
time ./SumaVectores 		8388608   >> datos.txt
time ./SumaVectores 		16777216  >> datos.txt
time ./SumaVectores 		33554432  >> datos.txt
time ./SumaVectores 		67108864  >> datos.txt

echo ""
echo ""
echo "SUMAVECTORES for: "
echo ""
time ./SumaVectoresMod 16384     >> datos.txt
time ./SumaVectoresMod 32768     >> datos.txt
time ./SumaVectoresMod 65536     >> datos.txt
time ./SumaVectoresMod 131072    >> datos.txt
time ./SumaVectoresMod 262144    >> datos.txt
time ./SumaVectoresMod 524288    >> datos.txt
time ./SumaVectoresMod 1048576   >> datos.txt
time ./SumaVectoresMod 2097152   >> datos.txt
time ./SumaVectoresMod 4194304   >> datos.txt
time ./SumaVectoresMod 8388608   >> datos.txt
time ./SumaVectoresMod 16777216  >> datos.txt
time ./SumaVectoresMod 33554432  >> datos.txt
time ./SumaVectoresMod 67108864  >> datos.txt

echo ""
echo ""
echo "SUMAVECTORES sections: "
echo ""
time ./SumaVectoresMod2 16384     >> datos.txt
time ./SumaVectoresMod2 32768     >> datos.txt
time ./SumaVectoresMod2 65536     >> datos.txt
time ./SumaVectoresMod2 131072    >> datos.txt
time ./SumaVectoresMod2 262144    >> datos.txt
time ./SumaVectoresMod2 524288    >> datos.txt
time ./SumaVectoresMod2 1048576   >> datos.txt
time ./SumaVectoresMod2 2097152   >> datos.txt
time ./SumaVectoresMod2 4194304   >> datos.txt
time ./SumaVectoresMod2 8388608   >> datos.txt
time ./SumaVectoresMod2 16777216  >> datos.txt
time ./SumaVectoresMod  33554432  >> datos.txt
time ./SumaVectoresMod2 67108864  >> datos.txt
