# Slurm Optimization

This section collects the more advanced scheduling guidance.

## Core Principles

- Prefer arrays over monolithic scripts when the work is naturally parallel.
- Right-size CPU, memory, GPU, and walltime requests.
- Test short jobs before launching expensive long ones.
- Name jobs and logs clearly enough that collaborators can audit them later.

## Arrays vs Monolithic Jobs

Use arrays when:

- tasks are independent
- inputs are many and similarly sized
- you want cleaner retries and logging

Use a monolithic job when:

- tasks must coordinate tightly
- startup cost dominates
- the workload is truly one coupled pipeline

## Right-Sizing CPU, Memory, and Time

- `--cpus-per-task` should match real multithreaded work, including dataloader workers when relevant.
- `--mem` requests total memory.
- `--mem-per-cpu` is useful when memory scales with CPU count.
- `--time` should include a cushion, but not a fantasy estimate.

## Modules and Environments

- Check for cluster-provided software before building your own environment.
- Use `module spider <name>` to discover available modules and versions.
- Use `module load <name>/<version>` when a suitable module already exists.
- Create or update large virtual environments inside an interactive job or another compute allocation if installation is heavy or compile-intensive.

Example:

```bash
module spider python
module spider cuda
module load python/3.12
```

## Dependencies and Requeue

Useful patterns:

- `--dependency=afterok:<job_id>` for staging pipelines
- checkpointing long training jobs so they can resume cleanly
- requeue only if the code is restart-safe

### Sequential Job Launching Example

Use sequential launching when one stage should start only after the previous stage finishes successfully.

Example:

```bash
prep_job=$(sbatch --parsable prep_features.sh)
train_job=$(sbatch --parsable --dependency=afterok:${prep_job} train_model.sh)
eval_job=$(sbatch --parsable --dependency=afterok:${train_job} evaluate_model.sh)
```

That pattern is useful when:

- preprocessing must finish before training starts
- training must finish before evaluation starts
- each stage has its own logs, resource requests, and retry logic

### Requeue Example

Requeue is useful only if the job can restart safely from a checkpoint or from a clean intermediate state.

Example directive:

```bash
#SBATCH --requeue
```

Typical checkpoint-aware pattern:

```bash
python train.py --checkpoint-dir /project/rrg-kjerbi/projects/<project_name>/checkpoints
```

If the workflow supports restart, a requeued job can continue from the latest saved checkpoint instead of starting from scratch.

Do not use requeue for jobs that:

- overwrite outputs unsafely
- cannot restart cleanly
- would corrupt state if launched again automatically

## Queue-Friendly Habits

- Use shorter test jobs before long jobs.
- Avoid over-requesting GPUs.
- Avoid asking for many more CPUs than your dataloader or preprocessing code can use.
- Split sweeps into arrays instead of one long shell loop.
- Do not build large environments or compile heavy software stacks on login nodes.

## Job Names and Logs

Prefer explicit names such as:

```bash
#SBATCH --job-name=trillium_finetune_lora
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err
```

## Common Directives

| Directive | Purpose |
|---|---|
| `--account` | Allocation to charge |
| `--time` | Maximum walltime |
| `--cpus-per-task` | CPU cores for one task |
| `--mem` | Total memory |
| `--mem-per-cpu` | Memory per CPU core |
| `--nodes` | Number of nodes |
| `--ntasks` | Total tasks |
| `--ntasks-per-node` | Tasks per node |
| `--gres` | Common GPU request pattern on many Slurm clusters |
| `--array` | Job array definition |
| `--dependency` | Job dependency |
| `--output` | Standard output log |
| `--error` | Standard error log |
| `--mail-type` | Email trigger |
| `--mail-user` | Email destination |

For Trillium-facing examples in this repository, use `--gres=gpu:<n>` as the default GPU request pattern. The current accessible Trillium Quickstart guidance emphasizes the Slurm workflow, the CPU and GPU login nodes, and writable storage such as `$SCRATCH`, but it does not surface an additional always-required GPU partition, QoS, or constraint flag in the basic pattern shown here. If a current Trillium example for your exact queue or hardware path includes extra selectors, mirror that documented example rather than inventing one.

## Navigation

Previous: [Distributed Training with DDP](./05_distributed_training_ddp.md)  
Next: [Collaboration and Permissions](./07_collaboration_permissions.md)  
Back to [Module Overview](./README.md)
