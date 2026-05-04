#!/usr/bin/env bash
# Simple array job example for module_04.

#SBATCH --job-name=simple_array
#SBATCH --account=def-kjerbi
#SBATCH --array=0-2
#SBATCH --time=00:10:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --output=array-%A-%a.out

set -euo pipefail

subjects=(subject_001 subject_002 subject_003)
subject="${subjects[$SLURM_ARRAY_TASK_ID]}"

echo "Array task ID: ${SLURM_ARRAY_TASK_ID}"
echo "Pretending to process: ${subject}"
echo "This is where you would call your real script safely."
