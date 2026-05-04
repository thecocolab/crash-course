#!/usr/bin/env bash
# Example CPU preprocessing array job for Fir.

#SBATCH --job-name=fir_cpu_array
#SBATCH --account=rrg-kjerbi
#SBATCH --array=0-4
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --output=fir-array-%A-%a.out

set -euo pipefail

items=(
  subject_001
  subject_002
  subject_003
  subject_004
  subject_005
)

item="${items[$SLURM_ARRAY_TASK_ID]}"

echo "Running CPU preprocessing on Fir"
echo "Task ID: ${SLURM_ARRAY_TASK_ID}"
echo "Item: ${item}"
echo "CPUs: ${SLURM_CPUS_PER_TASK}"

# Replace this with your real preprocessing command.
python - <<'PY'
print("Placeholder preprocessing task completed.")
PY
