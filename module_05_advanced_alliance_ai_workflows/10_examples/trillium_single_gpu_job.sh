#!/usr/bin/env bash
# Example single-GPU training job for Trillium.

#SBATCH --job-name=trillium_single_gpu
#SBATCH --account=rrg-kjerbi
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --gres=gpu:1
#SBATCH --output=trillium-single-gpu-%j.out

set -euo pipefail

# If a current Trillium example for your exact queue or hardware path includes
# an extra partition, QoS, or constraint flag, follow that documented example.

module load python/3.12

PROJECT_NAME="${PROJECT_NAME:-example_project}"
RUN_ROOT="${SLURM_TMPDIR:-/tmp}/${PROJECT_NAME}_single_gpu_run"
CHECKPOINT_DIR="${RUN_ROOT}/checkpoints"
FINAL_OUTPUT_DIR="${FINAL_OUTPUT_DIR:-/project/rrg-kjerbi/projects/${PROJECT_NAME}/outputs}"

mkdir -p "${CHECKPOINT_DIR}"
mkdir -p "${FINAL_OUTPUT_DIR}"

echo "GPU visibility check:"
nvidia-smi

cat > "${RUN_ROOT}/train_single_gpu.py" <<'PY'
from pathlib import Path
import os
import time

run_root = Path(os.environ["RUN_ROOT"])
checkpoint_dir = Path(os.environ["CHECKPOINT_DIR"])

print("Starting placeholder single-GPU training job.")
print("CUDA_VISIBLE_DEVICES:", os.environ.get("CUDA_VISIBLE_DEVICES", "<unset>"))

for step in range(3):
    print(f"step={step}")
    time.sleep(1)

(checkpoint_dir / "checkpoint_step3.txt").write_text("replace with a real checkpoint\n")
print("Finished placeholder training.")
PY

export RUN_ROOT CHECKPOINT_DIR
python "${RUN_ROOT}/train_single_gpu.py"

cp -r "${CHECKPOINT_DIR}" "${FINAL_OUTPUT_DIR}/"
echo "Copied example checkpoint output to ${FINAL_OUTPUT_DIR}"
echo "Replace the inline placeholder training script with your real entrypoint."
