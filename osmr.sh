#!/bin/bash
#SBATCH --account=def-daveea
#SBATCH --partition=compute_full_node
#SBATCH --ntasks-per-node=32
#SBATCH --gpus-per-node=4
#SBATCH --mail-user=mitch3@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --time=1-00
#SBATCH --nodes=4

module use $HOME/local/modules
module --force purge
module load MistEnv/2021a cmake/3.21.4 cuda/11.7.1 gcc/11.4.0 openmpi/5.0.5
export PATH=$HOME/local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/local/lib64:$LD_LIBRARY_PATH

export CUDA_MPS_PIPE_DIRECTORY=~/scratch/mps
export CUDA_MPS_LOG_DIRECTORY=~/scratch/mps
nvidia-cuda-mps-control -d

srun lmp_kk -k on g 4 -sf kk -pk kokkos neigh half -in osmr.in
