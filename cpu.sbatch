#!/usr/bin/bash
#SBATCH -J cpu-mpi
#SBATCH -o %x.o%j
#SBATCH -N 1
#SBATCH -n 8
#SBATCH --hint=nomultithread
 
source ~/.bashrc
conda activate cpu-mpi
module load gnu13 openmpi5

mpirun -n $SLURM_NTASKS python mpi.py
