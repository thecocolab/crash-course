# Monitoring Basics

This section introduces the core commands you will use to see whether a job is queued, running, finished, or failed.

## Core Commands

### `squeue`

Show queued and running jobs:

```bash
squeue -u "$USER"
```

### `scancel`

Cancel a job you no longer want:

```bash
scancel <job_id>
```

### `sacct`

Inspect completed jobs:

```bash
sacct -j <job_id>
```

## Reading Output Files

Many batch jobs create `.out` and `.err` logs, or a combined output file named by the `--output` setting.

Useful commands:

```bash
ls -lh
tail -n 50 hello_world-<job_id>.out
```

## Basic Status Meanings

| Status | Meaning |
|---|---|
| `PENDING` | The job is waiting in the queue |
| `RUNNING` | The job is currently executing |
| `COMPLETED` | The job finished successfully |
| `FAILED` | The job exited with an error or failed resource condition |

## Practical Example

A small monitoring loop for a newly submitted job:

```bash
sbatch examples/hello_world_job.sh
squeue -u "$USER"
```

Then inspect the output file after completion.

## Navigation

Previous: [Development Environments](./09_development_environments.md)  
Next: [Troubleshooting Basics](./11_troubleshooting_basics.md)  
Back to [Module Overview](./README.md)
