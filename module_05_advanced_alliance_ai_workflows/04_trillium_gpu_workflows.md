# Trillium GPU Workflows

This section explains how to use Trillium-GPU responsibly for AI workloads, using the current Trillium Quickstart as the main operational reference.

## What Trillium-GPU Is For

Use Trillium-GPU for jobs that genuinely need high-end GPU capacity, such as:

- foundation-model training
- large-scale fine-tuning
- distributed training
- multi-GPU experiments
- workloads that strongly use H100-class GPU memory or throughput

Do not treat Trillium-GPU as the default place for every training job. It is high-value H100 capacity and should be reserved for jobs that really justify it.

## Key Quickstart Facts

The current Trillium Quickstart states that:

- Trillium uses Slurm
- the CPU login node is `trillium`
- the GPU login node is `trillium-gpu`
- GPU nodes have `96` CPU cores
- GPU nodes have `768 GB` RAM per node
- jobs should be prepared and submitted from login nodes
- `$HOME` may be read-only on compute nodes, so active job workflows should rely on `$SCRATCH` and other appropriate writable storage

Reference: [Trillium Quickstart](https://docs.alliancecan.ca/wiki/Trillium_Quickstart)


## Login and Submission Pattern

A typical workflow looks like this:

1. Connect to the GPU login node.
2. Move to your working directory in `$SCRATCH` or another appropriate writable location.
3. Prepare your job script.
4. Submit with `sbatch`.

Example:

```bash
ssh <username>@trillium-gpu.scinet.utoronto.ca
cd "$SCRATCH"
sbatch train_job.sh
```

## Why `$SCRATCH` Matters

The Quickstart warns that `$HOME` may be read-only on compute nodes.

That matters because training jobs often need to:

- write checkpoints
- create logs
- store temporary caches
- unpack or stage datasets

So a safer pattern is:

- keep small config or reference files in your normal working space
- copy active job data to `$SCRATCH` or `$SLURM_TMPDIR` when needed
- write checkpoints and logs somewhere writable
- copy important final outputs back to `/project`

The same logic applies to Python environments:

- activating an existing environment on the login node is fine for light setup work
- creating a large virtual environment or compiling many packages should be done inside an interactive allocation or another compute allocation
- avoid heavy `pip install` or build-heavy environment creation on login nodes

## Single-GPU Training Pattern

See [10_examples/trillium_single_gpu_job.sh](./10_examples/trillium_single_gpu_job.sh) for a template.

A common starting point is:

```bash
#SBATCH --account=rrg-kjerbi
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --gres=gpu:1
```

Use this only when one GPU is enough for the workload. If you need multiple GPUs or a larger distributed setup, scale after validating the job on a smaller run first.

## When Trillium Is a Good Choice

Trillium-GPU is a good choice when:

- one GPU still gives high utilization
- multiple GPUs are needed for the same job
- the model size, batch size, or throughput target really benefits from H100-class hardware
- you are running a distributed training experiment that would be awkward or wasteful elsewhere

## When Trillium Is a Bad Choice

Trillium-GPU is a poor choice when:

- the job is mostly CPU preprocessing
- the training job is small and lightly uses the GPU
- the dataset pipeline is not ready yet and the GPU would mostly sit idle
- the same workload could run reasonably on a less expensive system

## Best Practices

- Test on a small sample first.
- Check whether a cluster-provided module already exists before installing a package stack yourself.
- Use `module spider <name>` to search for available software and versions.
- Monitor GPU utilization with `nvidia-smi`.
- Checkpoint regularly.
- Avoid excessive small-file reads from shared storage during training.
- Copy active data to `$SLURM_TMPDIR` when that improves throughput.
- use `sbcast` to copy the dataset to all compute nodes in the job, this way you will have the same data in the same location on every node
- Save your checkpoints on `$SLURM_TMPDIR` to avoid IO bottleneck with /project filesystem.
- Copy important final checkpoints and results back to `/project`.

## Practical Example

```bash
module spider python
module load python/3.12
nvidia-smi
cp -r /project/rrg-kjerbi/datasets/processed/<dataset_name> "$SLURM_TMPDIR"/
python train.py --data "$SLURM_TMPDIR/<dataset_name>"
```

## More Detailed Examples

For cluster-specific details, examples, and current operational notes, use the official Quickstart:

- [Trillium Quickstart](https://docs.alliancecan.ca/wiki/Trillium_Quickstart)

## Navigation

Previous: [Fir CPU Workflows](./03_fir_cpu_workflows.md)  
Next: [Distributed Training with DDP](./05_distributed_training_ddp.md)  
Back to [Module Overview](./README.md)
