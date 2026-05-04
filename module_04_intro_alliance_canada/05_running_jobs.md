# Running Jobs

This section introduces Slurm, the scheduler used on Alliance clusters, and the difference between logging in and actually running compute work.

## Slurm in One Sentence

Alliance clusters use Slurm to decide when and where your jobs run on compute nodes.

That means you normally:

1. Log in to a login node
2. Prepare files or scripts
3. Submit work through Slurm

## Login Node vs Compute Node

| Node type | Use it for | Do not use it for |
|---|---|---|
| Login node | Editing, light shell work, job submission | Long Python runs, heavy preprocessing, training jobs, or coding agents that launch substantial work |
| Compute node | Actual CPU or GPU computation | Persistent interactive file management after your allocation ends |

## Three Job Styles You Will See Often

| Job type | Command | Good for |
|---|---|---|
| Interactive job | `salloc` | Short debugging or testing sessions |
| Scheduled batch job | `sbatch` | Reproducible jobs that run in the queue |
| Array job | `sbatch --array=...` | Repeating the same task across files, subjects, or parameters |

Continue to:

- [Interactive Jobs with salloc](./06_interactive_jobs_salloc.md)
- [Scheduled Jobs with sbatch](./07_scheduled_jobs_sbatch.md)
- [Array Jobs](./08_array_jobs.md)

## Minimal Command Overview

| Command | What it does |
|---|---|
| `squeue` | Show queued and running jobs |
| `scancel` | Cancel a job |
| `sacct` | Inspect completed job history and resource usage |

## Practical Example

```bash
sbatch examples/hello_world_job.sh
squeue -u "$USER"
```

This is the smallest useful pattern for a first scheduled job.

## Navigation

Previous: [Storage Basics](./04_storage_basics.md)  
Next: [Interactive Jobs with salloc](./06_interactive_jobs_salloc.md)  
Back to [Module Overview](./README.md)
