# Advanced Troubleshooting

This section covers the issues that usually appear after you move past simple onboarding.

## Common Advanced Problems

| Problem | First checks |
|---|---|
| Disk quota exceeded | Which filesystem filled up: `/project`, `/scratch`, or another location? |
| Too many small files | Can you bundle artifacts, cache differently, or reduce per-sample outputs? |
| Job pending too long | Did you over-request GPUs, memory, walltime, or node count? |
| Out of memory | Did the model, dataloader, or preprocessing step exceed memory expectations? |
| GPU underutilization | Is the input pipeline too slow, batch too small, or data on the wrong filesystem? |
| DDP hangs | Check `MASTER_ADDR`, `MASTER_PORT`, rank setup, and per-process GPU binding |
| NCCL or network issues | Reduce complexity, test on one node, then scale back up |
| Dataloader bottlenecks | Match CPU workers to real I/O capacity and avoid tiny-file storms |
| Accidental storage bloat | Find duplicate checkpoints, redundant dataset copies, or uncontrolled logs |
| Python environment conflicts | Confirm the exact interpreter and package set inside the job |
| Module conflicts | Start from a cleaner environment and load only what is needed |
| Permission problems in shared folders | Check group ownership, inherited permissions, and shared conventions |
| Phantom jobs or stray processes | Check whether the work is still tied to a real Slurm allocation or is just a leftover user process |

## Practical Triage Order

1. Confirm the job ran where you thought it ran.
2. Confirm the data path and output path.
3. Confirm the environment and module state.
4. Confirm requested resources vs actual usage.
5. Only then scale or requeue.

## Common DDP Failure Pattern

If a DDP job hangs, the first things to inspect are:

- rank and world-size environment variables
- whether each process got one GPU
- whether `MASTER_ADDR` resolves on all nodes
- whether the rendezvous port is consistent across nodes

## Phantom Jobs and Stray Processes

If something seems to still be running after you thought the work ended:

- check `squeue -u "$USER"` first
- then check `ps -u "$USER" -f`
- if needed, inspect the job with `scontrol show job <job_id>`

Use `scancel` for real Slurm jobs. Use `kill` only for your own stray user processes after confirming they are not part of an active allocation.

## Navigation

Previous: [Monitoring, Quotas, and Cleanup](./08_monitoring_quota_and_cleanup.md)  
Next: [Coding Agents on Clusters](./10_coding_agents_on_clusters.md)  
Back to [Module Overview](./README.md)
