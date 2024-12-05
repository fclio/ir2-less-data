#!/bin/bash

#SBATCH --partition=gpu_h100
#SBATCH --gpus=1
#SBATCH --job-name=eval_bbh_after_finetuning
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gpus-per-node=1
#SBATCH --time=02:00:00
#SBATCH --output=slurm_output/eval_bbh_after_finetuning_%A.out

# Load necessary modules
module purge
module load 2023
module load PyTorch/2.1.2-foss-2023a-CUDA-12.1.1

# Source the evaluation scripts
source eval.sh
source eval_bbh.sh

# Set the model directory relative to the script's location
MODEL_DIR="/scratch-shared/ir2-less/out/llama2-13b-less-p0.05-lora-seed4-bbh"

# Run the evaluation on bbh dataset
eval_bbh "$MODEL_DIR"

# # Extract and print the evaluation results
RESULT=$(extract_bbh "$MODEL_DIR")
echo "bbh Evaluation Result: $RESULT%"