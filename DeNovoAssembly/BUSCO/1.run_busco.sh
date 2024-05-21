#!/usr/bin/env bash
#
#SBATCH -J Busco # A single job name for the array
#SBATCH --ntasks-per-node=6 # one core
#SBATCH -N 1 # on one node
#SBATCH -t 0-05:00 # 5 hours
#SBATCH --mem 20G
#SBATCH -o /scratch/csm6hg/err/busco.out # Standard output
#SBATCH -e /scratch/csm6hg/err/busco.err # Standard error
#SBATCH -p standard
#SBATCH --account berglandlab_standard

# Docker pull busco - run once
module load apptainer
# apptainer pull docker://ezlabgva/busco:v5.4.7_cv1

# Move to data directory
cd /scratch/csm6hg/dros/

# Run Busco
apptainer run /home/csm6hg/sifs/busco_v5.4.7_cv1.sif \
busco \
-i /scratch/csm6hg/dros/dros.contigs.fa \
-c 6 \
--out_path /scratch/csm6hg/dros/ \
-l arthropoda_odb10 \
-o dros_busco \
-m genome
