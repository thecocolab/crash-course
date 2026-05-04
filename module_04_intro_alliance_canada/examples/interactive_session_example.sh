#!/usr/bin/env bash
# This file is a reminder of common interactive-session commands.
# It is not meant to be submitted with sbatch.

set -euo pipefail

echo "CPU debugging session:"
echo "  salloc --account=def-kjerbi --time=00:30:00 --cpus-per-task=2 --mem=4G"
echo "  srun --pty bash -l"
echo
echo "GPU debugging session:"
echo "  salloc --account=def-kjerbi --time=00:30:00 --cpus-per-task=4 --mem=16G --gres=gpu:1"
echo "  srun --pty bash -l"
echo
echo "When you are done, exit the shell so the allocation is released."
