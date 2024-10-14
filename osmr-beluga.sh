#!/bin/bash
#SBATCH --account=def-tperkins
#SBATCH --ntasks=160
#SBATCH --ntasks-per-node=40
#SBATCH --gpus-per-node=4
#SBATCH --mail-user=mitch3@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --time=1:00:00
#SBATCH --nodes=4

module --force purge
module use $HOME/local/modules
module load StdEnv/2023
module unload openmpi imkl flexiblas
module load cuda/12.2 pmix/5.0.2 prrte/3.0.5 openmpi/5.0.5
export PATH=$HOME/local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/local/lib64:$LD_LIBRARY_PATH

export CUDA_MPS_PIPE_DIRECTORY=~/scratch/mps
export CUDA_MPS_LOG_DIRECTORY=~/scratch/mps
nvidia-cuda-mps-control -d

srun lmp_kk -k on g 4 -sf kk -pk kokkos neigh half -in osmr.in
