#!/bin/bash

#Órdenes para el sistema de colas
#SBATCH --job-name=HelloOMP   # Asigna un nombe al trabajo
#SBATCH --partition=ac        # Asigna una cola (partición)
#SBATCH --account=ac          # Asigna un account
#SBATCH --ntasks=1            # Procesos por nodo
#SBATCH --cpus-per-task=12    # Número de hebras por proceso
#SBATCH --hint=nomultithread  # Solo una hebra por core físico
#SBATCH --exclusive           # No se comparte el cluster con otros trabajos de la cola
#SBATCH --output=HelloOMP.log # Nombre del fichero de salida

#Obtención de información de las variables del entorno del sistema de colas:
echo "# Id. usuario del trabajo: $SLURM_JOB_USER"
echo "# Id. del trabajo: $SLURM_JOBID"
echo "# Nombre del trabajo especificado por usuario: $SLURM_JOB_NAME"
echo "# Directorio de trabajo (en el que se ejecuta el script): $SLURM_SUBMIT_DIR"
echo "# Cola: $SLURM_JOB_PARTITION"
echo "# Nodo que ejecuta este trabajo: $SLURM_SUBMIT_HOST"
echo "# Nº de nodos asignados al trabajo: $SLURM_JOB_NUM_NODES"
echo "# Nodos asignados al trabajo: $SLURM_JOB_NODELIST"
echo "# CPUs por nodo: $SLURM_JOB_CPUS_PER_NODE"

#Instrucciones del script para ejecutar código:
echo -e "\n 1. Ejecución de helloOMP una vez sin cambiar el número de threads (valor por defecto):\n"
srun ./HelloOMP2
echo -e "\n 2. Ejecución de helloOMP varias veces con distinto número de threads:\n" 
for ((P=12;P>0;P=P/2))
do
   export OMP_NUM_THREADS=$P
   echo -e "\n  - Para $P threads:"
   srun ./HelloOMP2
done
