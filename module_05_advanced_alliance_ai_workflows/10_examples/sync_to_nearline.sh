#!/usr/bin/env bash
# Safe nearline archive example.
# Nearline is cold/archive storage, not active training storage.

set -euo pipefail

SOURCE_DIR="${1:-${SCRATCH:-/scratch/$USER}/example_project_outputs}"
ARCHIVE_NAME="${2:-example_project_outputs.tar}"
DRY_RUN="${DRY_RUN:-1}"

if [[ ! -d "${SOURCE_DIR}" ]]; then
  echo "Source directory does not exist: ${SOURCE_DIR}" >&2
  exit 1
fi

echo "Preparing to archive: ${SOURCE_DIR}"
echo "Target archive object: \$ARCHIVE/${ARCHIVE_NAME}"
echo "Source data will not be deleted automatically."

if [[ "${DRY_RUN}" == "1" ]]; then
  echo
  echo "Dry-run mode is enabled."
  echo "Review a sample of files first:"
  find "${SOURCE_DIR}" -maxdepth 2 -type f | head -n 20
  echo
  echo "When you are ready on a site that supports HTAR-based nearline access,"
  echo "a typical command shape is:"
  echo "  htar -Humask=0137 -cpf \$ARCHIVE/${ARCHIVE_NAME} -Hcrc -Hverify=1 $(basename "${SOURCE_DIR}")"
  echo
  echo "TODO: Verify the current nearline workflow on your target system before"
  echo "standardizing this for lab-wide use."
  exit 0
fi

if ! command -v htar >/dev/null 2>&1; then
  echo "htar was not found. Keep DRY_RUN=1 until you confirm the site-approved"
  echo "archive tooling for nearline." >&2
  exit 1
fi

if [[ -z "${ARCHIVE:-}" ]]; then
  echo "ARCHIVE is not set. Confirm your nearline environment before running." >&2
  exit 1
fi

parent_dir="$(dirname "${SOURCE_DIR}")"
base_dir="$(basename "${SOURCE_DIR}")"

(
  cd "${parent_dir}"
  htar -Humask=0137 -cpf "${ARCHIVE}/${ARCHIVE_NAME}" -Hcrc -Hverify=1 "${base_dir}"
)

echo "Archive command completed."
echo "Source data remains in place."
