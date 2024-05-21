#!/usr/bin/env bash
#
#SBATCH -J geno_smoove # A single job name for the array
#SBATCH --ntasks-per-node=1 # multi core
#SBATCH -N 1 # on one node
#SBATCH -t 0-05:00 # 5 hours
#SBATCH --mem 50G
#SBATCH -o /scratch/csm6hg/err/genotype_smoove.out # Standard output
#SBATCH -e /scratch/csm6hg/err/genotype_smoove.err # Standard error
#SBATCH -p standard
#SBATCH --account berglandlab

# Modules
module load singularity

# Working directory
wd="/scratch/csm6hg"

# Reference genome
ref=${wd}/ref/totalHiCwithallbestgapclosed.fa

# Merge samples - this will create ./merged.sites.vcf.gz
singularity run /home/csm6hg/smoove_latest.sif \
smoove merge \
--name mega \
-f ${ref} \
--outdir ${wd}/smoove_fin \
${wd}/smoove_fin/genotype_sep/*.genotyped.vcf.gz