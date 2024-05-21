#!/usr/bin/env bash
#
#SBATCH -J run_hicanu # A single job name for the array
#SBATCH --ntasks-per-node=20 # multi core
#SBATCH -N 1 # on one node
#SBATCH -t 3-00:00 # 3 days
#SBATCH --mem 100G
#SBATCH -o /scratch/csm6hg/err/run_hiCanu1.out # Standard output
#SBATCH -e /scratch/csm6hg/err/run_hiCanu1.err # Standard error
#SBATCH -p largemem
#SBATCH --account berglandlab_standard

# Working directory
wd="/scratch/csm6hg/dros"
cd ${wd}

# Modules
module load anaconda/2023.07-py3.11
conda activate hicanu

# Install canu once
# conda create -n hicanu
# module load mamba
# mamba install canu

# Start
echo "Starting HiCanu"
date

# Run HiCanu
canu \
-assemble \
-p dros \
 -d dros_hifi_trim \
 maxThreads=20 \
 maxMemory=100g \
 useGrid=false \
 genomeSize=180m \
 -pacbio-hifi \
 m84104_240208_174910_s1.hifi_reads.bc2040.fq.gz

# Finish
echo "Finish HiCanu"
date
