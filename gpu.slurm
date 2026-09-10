#!/usr/bin/bash
#SBATCH -J gpu-mpi
#SBATCH -o %x.o%j
#SBATCH -N 1
#SBATCH -n 2
#SBATCH -p gpu
#SBATCH --gres=gpu:nvidia_l40:1
#SBATCH --hint=nomultithread
 
source ~/.bashrc
conda activate gpu-mpi
module load nvidia-sdk/nvhpc-hpcx-cuda13-openmpi5

nvidia-smi --query-gpu=index,name --format=csv

mpirun -n $SLURM_NTASKS python mpi.py
