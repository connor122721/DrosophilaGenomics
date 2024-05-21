#!/usr/bin/env bash
#
#SBATCH -J run_hicnv # A single job name for the array
#SBATCH --ntasks-per-node=1 # multi core
#SBATCH -N 1 # on one node
#SBATCH -t 0-05:00 # 5 hours
#SBATCH --mem 10G
#SBATCH -o /scratch/csm6hg/err/run_cnv.%A_%a.out # Standard output
#SBATCH -e /scratch/csm6hg/err/run_cnv.%A_%a.err # Standard error
#SBATCH -p standard
#SBATCH --account berglandlab_standard

# Working directory: SLURM_ARRAY_TASK_ID=9
wd="/scratch/csm6hg/dros_cnv"
cd ${wd}
threads=1

# BAMs
bams="/project/berglandlab/alan/individual_remap/bam/*bam"

# Reference genome
#ref="/scratch/csm6hg/dmel-all-chromosome-r6.12.fasta"
ref="/project/berglandlab/Dmel_genomic_resources/References/ref/holo_dmel_6.12.fa"

# Extract sample
samp=$( ls ${bams} | sed -n ${SLURM_ARRAY_TASK_ID}p )
echo ${samp}

# Start
echo "Starting HiCNV"
date

# Run HiCanu - 
/home/csm6hg/hificnv-v1.0.0-x86_64-unknown-linux-gnu/hificnv \
--ref ${ref} \
--bam ${samp} \
--threads ${threads}

# Finish
echo "Finish HiCanu"
date
