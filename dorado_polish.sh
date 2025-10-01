#!/bin/bash
#SBATCH -p gpu_p
#SBATCH -q gpu_normal
#SBATCH --mem=28G
#SBATCH -t 24:00:00
#SBATCH --nice=10000
#SBATCH --mail-type=ALL
#SBATCH --gres=gpu:1
#SBATCH --job-name=dorado_polishing
#SBATCH -c 16
#SBATCH --mail-user=samir.vargas@helmholtz-munich.de

# Define the absolute path to the dorado binary

WAY='.'
model= #add RG header ID for files
mkdir -p $WAY/polished_assembly
#	dorado polish reads_to_draft.bam draft.fasta > consensus.fasta
for read in $WAY/alins/*_sorted.bam
do
	readsname=$(echo "${read##*/}" | cut -d'_' -f 1,2);
	${DORADO_BIN} polish $read flye_assembly/$readsname/assembly.fasta --RG $model > $WAY/polished_assembly/"$readsname".fasta
done

