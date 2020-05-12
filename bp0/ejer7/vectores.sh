#!/bin/bash
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
echo "Directorio de trabajo (en el que se ejecuta el script): $SLURM_SUBMIT_DIR"
echo "Cola: $SLURM_JOB_PARTITION"
echo "Nodo que ejecuta este trabajo:$SLURM_SUBMIT_HOST"
echo "Nº de nodos asignados al trabajo: $SLURM_JOB_NUM_NODES"
echo "Nodos asignados al trabajo: $SLURM_JOB_NODELIST"
echo "CPUs por nodo: $SLURM_JOB_CPUS_PER_NODE"
#Instrucciones del script para ejecutar código:

srun ./SumaVectores 65536
echo ""
echo ""

srun ./SumaVectores 131072
echo ""
echo ""

srun ./SumaVectores 262144
echo ""
echo ""

srun ./SumaVectores 524288
echo ""
echo ""

srun ./SumaVectores 1048576
echo ""
echo ""

srun ./SumaVectores 2097152
echo ""
echo ""

srun ./SumaVectores 4194304
echo ""
echo ""

srun ./SumaVectores 8388608
echo ""
echo ""

srun ./SumaVectores 16777216
echo ""
echo ""

srun ./SumaVectores 33554432
echo ""
echo ""

srun ./SumaVectores 67108864
echo ""
echo ""

