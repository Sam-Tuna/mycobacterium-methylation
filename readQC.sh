#!/bin/bash
#SBATCH -p cpu_p
#SBATCH --mem=16G
#SBATCH -t 24:00:00
#SBATCH --qos cpu_normal
#SBATCH --partition=cpu_p
#SBATCH --cpus-per-task=8
#SBATCH --nice=10000
#SBATCH --mail-type=ALL
#SBATCH --job-name=Chopper
#SBATCH --mail-user=samir.vargas@helmholtz-munich.de

eval "$(conda shell.bash hook)"
conda activate chopper

WAY='.' 
mkdir -p $WAY/filtered

for raw_reads in $WAY/raw/*.fastq
do
    readsname=$(echo "${raw_reads##*/}"| cut  -d'.' -f 1);
    cat $raw_reads | chopper -q 9 -l 500 > "$WAY/filtered/$readsname.fastq"
done

