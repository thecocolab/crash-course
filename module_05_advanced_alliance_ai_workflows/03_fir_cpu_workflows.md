# Fir CPU Workflows

This section covers the kinds of AI-lab tasks that should default to Fir instead of consuming GPU resources.

## What Fir Should Be Used For

Fir should be the default for:

- feature extraction
- image preprocessing
- dataset conversion
- metrics computation
- file integrity checks
- many small or medium CPU-only jobs

Do not use a GPU allocation for these tasks unless you have evidence that the workload is actually GPU-bound.

## Single CPU Job Example

```bash
#!/usr/bin/env bash
#SBATCH --job-name=feature_extract
#SBATCH --account=rrg-kjerbi
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --output=fir-feature-%j.out

python extract_features.py --input /project/rrg-kjerbi/datasets/raw/<dataset_name>
```

## Multi-Core Job Example

```bash
#!/usr/bin/env bash
#SBATCH --job-name=dataset_convert
#SBATCH --account=rrg-kjerbi
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --output=fir-convert-%j.out

python convert_dataset.py --workers "${SLURM_CPUS_PER_TASK}"
```

## Job Array Example

Use arrays when the workload is naturally split across many similar units:

- files
- subjects
- parameter sweeps

Arrays are often better than one long serial shell loop because:

- each task can run independently
- failed items are easier to rerun
- logs stay easier to inspect
- the scheduler can place many small CPU jobs more flexibly than one monolithic job

The usual pattern is:

- one array task handles one file, one subject, or one parameter setting
- `SLURM_ARRAY_TASK_ID` selects which unit of work the current task should process
- each task should request only the CPU, memory, and time needed for that one unit

For example:

- one subject per task
- one input file per task
- one preprocessing configuration per task

This works especially well on Fir when you have many CPU-only jobs that do not need to communicate with each other.

Keep the array tasks simple:

- write outputs to distinct filenames or directories
- avoid making all tasks overwrite the same file
- test one or two items first before launching a large array

If needed, you can also limit how many array tasks run at once with a pattern like:

```bash
#SBATCH --array=0-999%50
```

That means:

- task IDs go from `0` to `999`
- at most `50` tasks run at the same time

See [10_examples/fir_cpu_array_job.sh](./10_examples/fir_cpu_array_job.sh).

## Directive Guide

| Directive | Why it matters |
|---|---|
| `--account=rrg-kjerbi` | Charges the compute allocation used in this module |
| `--time` | Shorter realistic requests improve scheduling |
| `--cpus-per-task` | Match this to your true parallel CPU usage |
| `--mem` | Request enough memory without guessing wildly high |
| `--output` | Keep logs easy to find |

## Practical Guidance

- Use arrays instead of one giant serial script when possible.
- Measure runtime and memory on a small sample first.
- Save reusable outputs once, then avoid repeating expensive preprocessing.

## Navigation

Previous: [Storage and Data Lifecycle](./02_storage_and_data_lifecycle.md)  
Next: [Trillium GPU Workflows](./04_trillium_gpu_workflows.md)  
Back to [Module Overview](./README.md)
