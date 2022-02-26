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


N=16000

echo ""
echo "STATIC"
export OMP_SCHEDULE="static"
./pmtv-open $N
export OMP_SCHEDULE="static,1"
./pmtv-open $N
export OMP_SCHEDULE="static,64"
./pmtv-open $N

echo ""
echo "DYNAMIC "
export OMP_SCHEDULE="dynamic"
./pmtv-open $N
export OMP_SCHEDULE="dynamic,1"
./pmtv-open $N
export OMP_SCHEDULE="dynamic,64"
./pmtv-open $N

echo ""
echo "GUIDED"
export OMP_SCHEDULE="guided"
./pmtv-open $N
export OMP_SCHEDULE="guided,1"
./pmtv-open $N
export OMP_SCHEDULE="guided,64"
./pmtv-open $N

echo ""


N=36000

echo ""
echo "STATIC"
export OMP_SCHEDULE="static"
./pmtv-open $N
export OMP_SCHEDULE="static,1"
./pmtv-open $N
export OMP_SCHEDULE="static,64"
./pmtv-open $N

echo ""
echo "DYNAMIC "
export OMP_SCHEDULE="dynamic"
./pmtv-open $N
export OMP_SCHEDULE="dynamic,1"
./pmtv-open $N
export OMP_SCHEDULE="dynamic,64"
./pmtv-open $N

echo ""
echo "GUIDED"
export OMP_SCHEDULE="guided"
./pmtv-open $N
export OMP_SCHEDULE="guided,1"
./pmtv-open $N
export OMP_SCHEDULE="guided,64"
./pmtv-open $N

echo ""



