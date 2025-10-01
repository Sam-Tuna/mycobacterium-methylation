#!/bin/bash
#SBATCH -p gpu_p
#SBATCH -q gpu
#SBATCH --mem=128G
#SBATCH -t 48:00:00
#SBATCH --qos gpu_long
#SBATCH --partition=gpu_p
#SBATCH --nice=10000
#SBATCH --mail-type=ALL
#SBATCH --gres=gpu:2
#SBATCH --job-name=dorado
#SBATCH -c 2
#SBATCH --mail-user=samir.vargas@helmholtz-munich.de

WAY='.'
INPUT_DIR=$WAY/pod5
kit=SQK-RBK114-96

echo "Running dorado basecaller..."
${DORADO_BIN} basecaller sup,4mC_5mC,6mA $INPUT_DIR --kit-name $kit --no-trim > $WAY/basecalled.bam

echo "Running dorado demux..."
mkdir -p $WAY/demux
${DORADO_BIN} demux --output-dir $WAY/demux/ --kit-name $kit $WAY/basecalled.bam
