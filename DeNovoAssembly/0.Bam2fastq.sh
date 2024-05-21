#!/usr/bin/env bash
#
#SBATCH -J run_hicanu # A single job name for the array
#SBATCH --ntasks-per-node=1 # multi core
#SBATCH -N 1 # on one node
#SBATCH -t 1-00:00 # 1 day
#SBATCH --mem 20G
#SBATCH -o /scratch/csm6hg/err/run_hiCanu.out # Standard output
#SBATCH -e /scratch/csm6hg/err/run_hiCanu.err # Standard error
#SBATCH -p standard
#SBATCH --account berglandlab_standard

# Preparation tasks for assembly and scaffolding from HiFi reads

# Working directory
wd="/scratch/csm6hg/dros"
cd ${wd}

# Modules
module load bedtools

# Convert sequences to fastq format
bedtools bamtofastq \
-i m84104_240208_174910_s1.hifi_reads.bc2040.bam \
-fq m84104_240208_174910_s1.hifi_reads.bc2040.fq

# zip fastq - takes a long time
module load htslib
bgzip m84104_240208_174910_s1.hifi_reads.bc2040.fq

# Create long-read fasta for scaffolding
/home/csm6hg/seqtk/seqtk seq \
m84104_240208_174910_s1.hifi_reads.bc2040.fq.gz > \
m84104_240208_174910_s1.hifi_reads.bc2040.longreads.fasta