#!/usr/bin/env bash
# Beginner Python batch job example for module_04.

#SBATCH --job-name=basic_python
#SBATCH --account=def-kjerbi
#SBATCH --time=00:10:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --output=basic_python-%j.out

set -euo pipefail

# Adjust the module version to what is available on your target cluster.
module load python/3.12

# If your lab uses virtual environments, activate one here instead of relying
# on the base interpreter.
python - <<'PY'
import os
import platform
import sys

print("Python job is running.")
print("Python executable:", sys.executable)
print("Platform:", platform.platform())
PY
