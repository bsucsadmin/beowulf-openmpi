#!/usr/bin/bash
#SBATCH -J testmpi
#SBATCH -o %x.o%j
#SBATCH -n 8
#SBATCH -N 1
#SBATCH -t 60
#SBATCH --hint=nomultithread

module load gnu13 openmpi5 lammps/6.27.2024

mpirun /opt/ohpc/pub/apps/lammps/6-27-2024/bin/lmp < in.inputfile
