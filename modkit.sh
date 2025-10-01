#!/bin/bash
#SBATCH --mem=64G
#SBATCH -t 18:00:00
#SBATCH --qos cpu_normal
#SBATCH --partition=cpu_p
#SBATCH --cpus-per-task=16
#SBATCH --nice=10000
#SBATCH --mail-type=ALL
#SBATCH --job-name=modkit
#SBATCH --mail-user=samir.vargas@helmholtz-munich.de


WAY='.'
BIN="~/modkit-0.5.1/modkit"
output=modkit
alins=alins
mkdir -p $output $alins

for pond in $WAY/raw_reads/*.bam
do
        name=$(echo "${pond##*/}"| cut  -d'.' -f 1);
	samtools faidx polished_assembly/"$name".fasta
	$DORADO_BIN aligner polished_assembly/"$name".fasta $pond > $alins/"$name".bam
	samtools sort $alins/"$name".bam -o $alins/"$name"_sorted.bam
	samtools index $alins/"$name"_sorted.bam
	$BIN summary $alins/"$name"_sorted.bam > $output/summary-"$name".tsv
	$BIN pileup $alins/"$name"_sorted.bam $output/"$name".bed --ref polished_assembly/"$name".fasta --threads 16 --log-filepath $output/"$name"-pileup.log
done

