#!/usr/bin/env bash
#
#SBATCH -J run_smoove # A single job name for the array
#SBATCH --ntasks-per-node=4 # multi core
#SBATCH -N 1 # on one node
#SBATCH -t 0-10:00 # 10 hours
#SBATCH --mem 15G
#SBATCH -o /scratch/csm6hg/err/dros_run_smoove.%A_%a.out # Standard output
#SBATCH -e /scratch/csm6hg/err/dros_run_smoove.%A_%a.err # Standard error
#SBATCH -p standard
#SBATCH --account berglandlab_standard

# Working directory: SLURM_ARRAY_TASK_ID=1
wd="/scratch/csm6hg/dros_cnv_smoove"
cd ${wd}
threads=4

# BAMs
bams="/project/berglandlab/alan/individual_remap/bam/*bam"

# Reference genome
#ref="/scratch/csm6hg/dmel-all-chromosome-r6.12.fasta"
ref="/project/berglandlab/Dmel_genomic_resources/References/ref/holo_dmel_6.12.fa"

# Extract sample
samp=$( ls ${bams} | sed -n ${SLURM_ARRAY_TASK_ID}p )
echo ${samp}

# Name of sample
namei=$( echo ${samp} | cut -f7 -d"/" | sed 's/.bam//g' )
echo ${namei}

# Modules
module load apptainer

# Run Lumpy - exclude non-genomic chromosomes
apptainer run /home/csm6hg/sifs/smoove_latest.sif \
smoove call \
${outbam}/${samp} \
--excludechroms ~sim,~Un,~Sac,~211,~Cen,~rDNA,~mapped \
--name ${namei} \
-processes ${threads} \
--fasta ${ref} \
--outdir ${wd}/smoove \
--duphold \
--genotype

# Finish
echo "Finish"
echo ${samp}
date
