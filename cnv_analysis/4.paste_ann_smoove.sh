#!/usr/bin/env bash
#
#SBATCH -J paste_smoove # A single job name for the array
#SBATCH --ntasks-per-node=1 # multi core
#SBATCH -N 1 # on one node
#SBATCH -t 01:00:00 # 
#SBATCH --mem 50G
#SBATCH -o /scratch/csm6hg/err/genotype_smoove.out # Standard output
#SBATCH -e /scratch/csm6hg/err/genotype_smoove.err # Standard error
#SBATCH -p standard
#SBATCH --account berglandlab

# Modules
module load singularity

# Working directory
wd="/scratch/csm6hg"

# GFF
gff=${wd}/ref/Daphnia.aed.0.6.gff.gz

# Pastes sample VCFs 
singularity run /home/csm6hg/smoove_latest.sif \
smoove paste \
--name pulex_euro \
-o ${wd}/smoove_fin/ \
${wd}/smoove_fin/genotype-joint/*.vcf.gz

# Annotate
module load htslib
singularity run /home/csm6hg/smoove_latest.sif \
smoove annotate \
--gff ${gff} \
${wd}/smoove_fin/pulex_euro.smoove.square.vcf.gz | \
bgzip -c > ${wd}/smoove_fin/pulex_euro.smoove.square.ann.vcf.gz

# Filter depth info
module load bcftools
bcftools view \
-i '(SVTYPE = "DEL" & FMT/DHFFC[0] < 0.7) | (SVTYPE = "DUP" & FMT/DHBFC[0] > 1.3)' \
${wd}/smoove_fin/pulex_euro.smoove.square.ann.vcf.gz \
-o ${wd}/smoove_fin/pulex_euro.square.ann.filt.vcf 
bgzip pulex_euro.square.ann.filt.vcf

# Filter out low-quality heterozygotes
bcftools view \
-i '(FMT/SHQ >= 3)' \
${wd}/smoove_fin/pulex_euro.square.ann.filt.vcf.gz