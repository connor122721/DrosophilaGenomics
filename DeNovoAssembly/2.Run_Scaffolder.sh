#!/usr/bin/env bash
#
#SBATCH -J run_scaffold # A single job name for the array
#SBATCH --ntasks-per-node=10 # multi core
#SBATCH -N 1 # on one node
#SBATCH -t 0-10:00 # 10 hours
#SBATCH --mem 20G
#SBATCH -o /scratch/csm6hg/err/run_scaffold.out # Standard output
#SBATCH -e /scratch/csm6hg/err/run_scaffold.err # Standard error
#SBATCH -p largemem
#SBATCH --account berglandlab_standard

# Working directory
wd="/scratch/csm6hg/dros"
cd ${wd}

# Download longstitch - run once
module load apptainer
# apptainer pull docker://themariya/longstitch

# Start
echo "Starting LongStitch"
date

# Run HiCanu
apptainer run /home/csm6hg/sifs/longstitch_latest.sif \
longstitch run \
draft=dros.contigs \
reads=m84104_240208_174910_s1.hifi_reads.bc2040 \
t=10 \
G=1.97e8 \
longmap=hifi

# Finish
echo "Finish HiCanu"
date
