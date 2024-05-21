#!/usr/bin/env bash
#
#SBATCH -J geno_smoove_joint # A single job name for the array
#SBATCH --ntasks-per-node=5 # multi core
#SBATCH -N 1 # on one node
#SBATCH --mem 20G
#SBATCH -o /scratch/csm6hg/err/geno_smoove_j.%A_%a.out # Standard output
#SBATCH -e /scratch/csm6hg/err/geno_smoove_j.%A_%a.err # Standard error
#SBATCH -p standard
#SBATCH --account berglandlab_standard

# Working directory: SLURM_ARRAY_TASK_ID=293
wd="/scratch/csm6hg"
parameterFile="/scratch/csm6hg/data/nam_pulex_samps.csv"
threads=5

# Extract sample
sra=$( sed -n ${SLURM_ARRAY_TASK_ID}p ${parameterFile} | cut -f1 )
samp=$( sed -n ${SLURM_ARRAY_TASK_ID}p ${parameterFile} | cut -f2 )

# Modules
module load apptainer

# Reference genome
ref=${wd}/genomes/pulex_nam/GCF_021134715.1_ASM2113471v1_genomic.fna

# Genotype samples
apptainer run /home/csm6hg/sifs/smoove_latest.sif \
smoove genotype \
-d \
-x \
-p ${threads} \
--name ${samp}-joint \
--outdir ${wd}/smoove_fin/genotype-joint-nam \
--fasta ${ref} \
--vcf ${wd}/smoove_fin/mega.sites.vcf.gz \
${wd}/mapping/bam/${samp}_*_RG.bam
