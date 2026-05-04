# Array Jobs

This section shows how to use job arrays for repeating the same task across many files, subjects, or parameter settings.

## Why Job Arrays?

Job arrays are a clean way to launch many similar jobs without copying the same script over and over.

Typical use cases:

- Process many files
- Process many subjects
- Run many parameter settings

## The Key Variable

Inside an array job, Slurm sets:

```bash
$SLURM_ARRAY_TASK_ID
```

That value changes for each task in the array, so your script can choose which file, subject, or parameter to work on.

## Example Submission

```bash
sbatch examples/simple_array_job.sh
```

## Example Pattern

```bash
subjects=(sub-001 sub-002 sub-003)
subject="${subjects[$SLURM_ARRAY_TASK_ID]}"
echo "Processing ${subject}"
```

That pattern is easier to maintain than a long serial shell script.

## Practical Example File

See [examples/simple_array_job.sh](./examples/simple_array_job.sh).

## Navigation

Previous: [Scheduled Jobs with sbatch](./07_scheduled_jobs_sbatch.md)  
Next: [Development Environments](./09_development_environments.md)  
Back to [Module Overview](./README.md)
