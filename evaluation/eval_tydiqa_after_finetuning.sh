#!/bin/bash

#SBATCH --partition=gpu_h100
#SBATCH --gpus=1
#SBATCH --job-name=eval_tydiqa_after_finetuning
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gpus-per-node=1
#SBATCH --time=02:00:00
#SBATCH --output=slurm_output/eval_tydiqa_after_finetuning_%A.out

# Load necessary modules
module purge
module load 2023
module load PyTorch/2.1.2-foss-2023a-CUDA-12.1.1

# pip install vllm --force-reinstall

# Source the evaluation scripts
source eval.sh
source eval_tydiqa.sh

# Set the model directory relative to the script's location
MODEL_DIR="/scratch-shared/ir2-less/out/llama2-13b-less-p0.05-lora-seed4-tydiqa"

# Run the evaluation on tydiqa dataset
eval_tydiqa "$MODEL_DIR"

# Extract and print the evaluation results
RESULT=$(extract_tydiqa "$MODEL_DIR")
echo "tydiqa Evaluation Result: $RESULT%"