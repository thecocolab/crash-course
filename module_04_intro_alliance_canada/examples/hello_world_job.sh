#!/usr/bin/env bash
# Simple first batch job for module_04.

#SBATCH --job-name=hello_world
#SBATCH --account=def-kjerbi
#SBATCH --time=00:05:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --output=hello_world-%j.out

set -euo pipefail

echo "Hello from Alliance."
echo "Host: $(hostname)"
echo "Date: $(date)"
echo "Working directory: $(pwd)"
