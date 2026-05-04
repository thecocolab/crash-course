# Scheduled Jobs with sbatch

This section introduces `sbatch`, the standard way to submit a reproducible scheduled job to Slurm.

## Why Use `sbatch`?

`sbatch` is the right tool when you want:

- A job that runs without keeping your terminal open
- A saved script you can rerun later
- Output logs you can inspect after the job finishes

## Beginner Submission Pattern

```bash
sbatch examples/hello_world_job.sh
```

For a small Python example:

```bash
sbatch examples/basic_python_job.sh
```

## What Is Inside a Batch Script?

The example scripts in `examples/` show the basic structure:

- A shebang such as `#!/usr/bin/env bash`
- `#SBATCH` lines that request resources
- Optional module or environment setup
- The command you actually want to run

## Common `#SBATCH` Directives

| Directive | Purpose |
|---|---|
| `--account=def-kjerbi` | Charges the job to the default lab allocation used in this beginner module |
| `--time=00:10:00` | Maximum walltime |
| `--cpus-per-task=1` | Number of CPU cores for one task |
| `--mem=1G` | Total memory requested |
| `--output=...` | Standard output log file |
| `--error=...` | Standard error log file |
| `--job-name=...` | Short label for the job |

## A Good Beginner Habit

Start with small, realistic requests.

Bad first script:

```bash
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=32
#SBATCH --mem=256G
```

Better first script:

```bash
#SBATCH --time=00:10:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
```

Measure first, then scale.

## Practical Example Files

- [examples/hello_world_job.sh](./examples/hello_world_job.sh)
- [examples/basic_python_job.sh](./examples/basic_python_job.sh)

## Navigation

Previous: [Interactive Jobs with salloc](./06_interactive_jobs_salloc.md)  
Next: [Array Jobs](./08_array_jobs.md)  
Back to [Module Overview](./README.md)
