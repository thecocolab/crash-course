#!/usr/bin/env bash
# Create a shared lab-friendly skeleton under /project/rrg-kjerbi.
# This script is intentionally non-destructive.

set -euo pipefail

PROJECT_NAME="${1:-example_project}"
PROJECT_ROOT="/project/rrg-kjerbi/projects/${PROJECT_NAME}"

mkdir -p "/project/rrg-kjerbi/datasets/raw"
mkdir -p "/project/rrg-kjerbi/datasets/processed"
mkdir -p "/project/rrg-kjerbi/datasets/external"
mkdir -p "/project/rrg-kjerbi/shared_envs"
mkdir -p "/project/rrg-kjerbi/docs"
mkdir -p "/project/rrg-kjerbi/tmp"

mkdir -p "${PROJECT_ROOT}/code"
mkdir -p "${PROJECT_ROOT}/configs"
mkdir -p "${PROJECT_ROOT}/outputs"
mkdir -p "${PROJECT_ROOT}/checkpoints"
mkdir -p "${PROJECT_ROOT}/logs"

echo "Created project skeleton at: ${PROJECT_ROOT}"
echo "Review group ownership before collaborating broadly."
echo "Optional next steps, after verification:"
echo "  chgrp <shared_group> ${PROJECT_ROOT}"
echo "  chmod g+s ${PROJECT_ROOT}"
echo
echo "Do not run recursive chmod or chgrp commands until you understand the"
echo "current permissions model for your lab and storage space."
