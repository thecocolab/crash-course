# Monitoring, Quotas, and Cleanup

This section focuses on efficiency, storage health, and safe cleanup for active collaborative projects.

## Useful Commands

| Command | Purpose |
|---|---|
| `squeue -u "$USER"` | View active jobs |
| `sacct -j <job_id>` | Inspect completed jobs |
| `scontrol show job <job_id>` | Show detailed job configuration |
| `seff <job_id>` | Estimate efficiency if available |
| `sstat -j <job_id>` | Inspect running job stats if available |
| `du -sh <path>` | Measure directory size |
| `find <path> -type f -size +1G` | Find large files |
| `find <path> -type f | wc -l` | Rough count of file count explosion |
| `nvidia-smi` | Inspect GPU utilization inside a GPU job |

## Inspecting Job Efficiency

After a job finishes, a simple review loop is:

1. check whether the job completed, failed, or timed out
2. inspect the output and error logs
3. inspect resource usage with `sacct` or `seff`
4. compare what you requested with what the job actually used

### Example: Basic Post-Job Checks

```bash
sacct -j <job_id>
seff <job_id>
tail -n 50 logs/<job_name>-<job_id>.out
tail -n 50 logs/<job_name>-<job_id>.err
```

Useful things to look for:

- did the job finish with `COMPLETED`, `FAILED`, or `TIMEOUT`
- did the output log show the expected training or preprocessing progress
- did the error log show out-of-memory, missing-file, or environment problems
- did the resource report show major underuse

### Example: More Detailed `sacct` Query

```bash
sacct -j <job_id> --format=JobID,JobName,State,Elapsed,TotalCPU,AllocCPUS,MaxRSS
```

That helps answer:

- how long the job actually ran
- how many CPUs were allocated
- how much total CPU time was used
- the largest observed memory footprint

After a training or preprocessing run, ask:

- Did I use the CPUs I requested?
- Did memory stay far below my request?
- Was the GPU actually busy?
- Did walltime run far shorter than requested?

### How To Answer Those Questions

#### Did I use the CPUs I requested?

Check:

- `AllocCPUS` from `sacct`
- `TotalCPU` from `sacct`
- `CPU Efficiency` from `seff` if available

Interpretation:

- if CPU efficiency is high, the requested CPUs are probably reasonable
- if CPU efficiency is very low, you may have requested too many CPUs
- if the workload is I/O-bound, dataloader-bound, or mostly waiting, extra CPUs may not be helping

#### Did memory stay far below my request?

Check:

- `MaxRSS` from `sacct`
- memory efficiency from `seff` if available

Interpretation:

- if `MaxRSS` is much smaller than requested memory, you may be over-requesting RAM
- if the job failed with out-of-memory, you requested too little
- if memory use is close to the limit, keep a safety margin but do not inflate it excessively

#### Was the GPU actually busy?

Check:

- `nvidia-smi` during the run if you are in an interactive session
- training logs for step time and throughput
- whether the GPU job spent long periods waiting on data loading or preprocessing

Interpretation:

- high utilization usually means the GPU request makes sense
- low utilization often means the bottleneck is elsewhere, such as I/O, dataloading, batch size, or CPU preprocessing
- if a very expensive GPU sits mostly idle, the workload likely belongs on another system or needs pipeline fixes first

#### Did walltime run far shorter than requested?

Check:

- requested walltime in the script
- actual elapsed time from `sacct`

Interpretation:

- if the job finishes much earlier than requested, shorten future walltime requests
- shorter realistic walltimes often help scheduling
- if jobs regularly time out, increase the request or add checkpointing and requeue logic

### Example Interpretation

Suppose:

- you requested `16` CPUs and `64G` memory
- `seff` shows low CPU efficiency
- `MaxRSS` is only `11G`
- the logs show the job finished in `25` minutes even though you asked for `4` hours

A better next submission might be:

- fewer CPUs
- less memory
- shorter walltime

That feedback loop improves future submissions.

## Finding Storage Bloat

Examples:

```bash
du -sh /project/rrg-kjerbi/projects/<project_name>/*
find /project/rrg-kjerbi/projects/<project_name> -type f -size +5G
find /project/rrg-kjerbi/projects/<project_name> -type f | wc -l
```

Too many small files can be as damaging operationally as a few very large files.

## Safe Cleanup Rules

- Never delete shared files without checking ownership and the project README.
- Prefer moving inactive outputs to nearline over blind deletion.
- Dry-run transfers or archives first when possible.

## Stray Processes and Phantom Jobs

Sometimes the problem is not a queued batch job but a leftover interactive process or a tool that was started and forgotten.

Useful checks:

```bash
squeue -u "$USER"
ps -u "$USER" -f
scontrol show job <job_id>
```

Use them to answer:

- is this still a real Slurm job
- is it tied to an active allocation
- is it just a leftover user process from an interactive session

Clean up safely:

- use `scancel <job_id>` for Slurm jobs
- use `kill <pid>` only for your own stray processes
- re-check with `squeue` or `ps` after cleanup

Try to avoid phantom work by:

- exiting interactive sessions when you are done
- not leaving background processes running without checking them
- making sure notebook servers, coding agents, and helper scripts are attached to a real allocation

## Moving Inactive Data to Nearline

Nearline is cold/archive storage. It is not active training storage and should not be used as if it were a fast shared filesystem.

See [10_examples/sync_to_nearline.sh](./10_examples/sync_to_nearline.sh) for a cautious example based on an archive-first workflow.

## Navigation

Previous: [Collaboration and Permissions](./07_collaboration_permissions.md)  
Next: [Advanced Troubleshooting](./09_troubleshooting_advanced.md)  
Back to [Module Overview](./README.md)
