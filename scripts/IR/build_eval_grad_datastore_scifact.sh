#!/bin/bash

#SBATCH --partition=gpu_h100
#SBATCH --gpus=1
#SBATCH --job-name=eval_grad_datastore
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gpus-per-node=1
#SBATCH --time=24:00:00
#SBATCH --output=slurm_output/build_eval_grad_scifact_%A.out

module purge
module load 2023
module load PyTorch/2.1.2-foss-2023a-CUDA-12.1.1

#7b: 422 845 1268 1688 
#13b: 211 422 634 844
#7b: 11,22,34,44

#first-0.5: 62 124 187 248
#msmarco-0.5: 573 1146 1720 2292
# slurm_output/build_eval_grad_first_%A_msmarco_0.05_1146.out

CKPT=62
PERCENTAGE=0.05
DATA_SEED=3
TRAINING_DATA_NAME=scifact
TRAINING_DATA_FILE=data/eval/scifact/scifact_dev.jsonl # when changing data name, change the data path accordingly
GRADIENT_TYPE="sgd"
JOB_NAME="llama2-7b-p${PERCENTAGE}-lora-seed${DATA_SEED}-first"


TASK="scifact"
DATA_DIR="data"
MODEL_PATH=/scratch-shared/ir2-less/out/${JOB_NAME}/checkpoint-${CKPT}
OUTPUT_PATH=/scratch-shared/ir2-less/grads/${JOB_NAME}/${TRAINING_DATA_NAME}-ckpt${CKPT}-${GRADIENT_TYPE}
DIMS="8192"

# bash less/scripts/get_info/grad/get_eval_lora_grads.sh "$TASK" "$DATA_DIR" "$MODEL_PATH" $OUTPUT_PATH "$DIMS"

bash less/scripts/get_info/grad/get_train_lora_grads.sh "$TRAINING_DATA_FILE" "$MODEL_PATH" "$OUTPUT_PATH" "$DIMS" "$GRADIENT_TYPE"