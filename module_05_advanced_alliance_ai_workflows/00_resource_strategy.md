# Resource Strategy

This section explains how to spend compute and storage responsibly across `def-kjerbi` and `rrg-kjerbi`.

## Start with the Allocation Distinction

- `def-kjerbi` can still be used for resource-aware work when the job is well matched to the requested resources.
- `rrg-kjerbi` is the higher-priority allocation and should be spent carefully on jobs that make strong use of the CPU or GPU capacity being requested.

## Compute Budgeting at a High Level

Think about every job request as a budget decision:

- CPU cores
- memory
- walltime
- GPUs
- shared storage

Over-requesting makes the queue slower, wastes allocation weight, and makes it harder for other lab members to schedule work.

## What Is a Core-Year or an RGU-Year?

These are yearly accounting units used for allocations.

- `1 core-year` means using `1` CPU core continuously for `1` full year
- `1 RGU-year` means using GPU capacity, measured in `reference GPU units`, over `1` year

Equivalent CPU examples:

- `12` CPU cores for `1` month is about `1 core-year`
- `365` CPU cores for `1` day is also about `1 core-year`

## What Is an RGU?

RGU stands for Resource Group Unit, a scheduling and accounting abstraction used for GPU-oriented allocation planning. Alliance uses `RGU` so different GPU models are charged differently. For example:

- `1` H100-80G = `12.15 RGU`
- `1` A100-40GB = `4.0 RGU`
- `1` V100-16GB = `2.2 RGU`
- `1` P100-12GB = `1.0 RGU`

## What Does 150 RGU-Years Mean in Practice?

Using `1 H100-80G = 12.15 RGU`, a `150 RGU-year` allocation is roughly:

- `12.35` H100-years
- about `12` H100 GPUs running continuously for a full year
- about `24` H100 GPUs for `6` months
- about `48` H100 GPUs for `3` months

If you think in terms of 4-GPU H100 nodes:

- `1` 4-GPU node for `1` year = `48.6 RGU-years`
- `150 RGU-years` is about `3.09` 4-GPU node-years

So a stronger GPU counts more heavily against the yearly allocation than a weaker one used for the same amount of time.

## Bad vs Good Requests

### Bad: GPU requested for a CPU-only preprocessing job

```bash
#SBATCH --account=rrg-kjerbi
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --gres=gpu:1
python extract_features.py
```

### Better: Send the CPU job to Fir without a GPU

```bash
#SBATCH --account=rrg-kjerbi
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
python extract_features.py
```

### Bad: Huge walltime and memory for an untested training script

```bash
#SBATCH --account=rrg-kjerbi
#SBATCH --time=72:00:00
#SBATCH --cpus-per-task=32
#SBATCH --mem=256G
#SBATCH --gres=gpu:4
```

### Better: Small validation run first

```bash
#SBATCH --account=rrg-kjerbi
#SBATCH --time=00:30:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --gres=gpu:1
```

Scale only after you confirm the code, data path, and resource profile.

## When Should I Use Trillium-GPU?

Use Trillium-GPU for jobs that need a full GPU or multi-GPU setup, such as:

- foundation-model training
- large-scale fine-tuning
- distributed training
- multi-GPU experiments
- workloads that genuinely benefit from H100-class resources

In this course, treat Trillium GPU resources as something you reserve for jobs that truly justify that level of hardware.

Do not use Trillium-GPU for:

- light CPU preprocessing
- small shell scripts
- dataset cleanup
- low-utilization tests that can be done elsewhere
- small CNN training runs that could run elsewhere

## Default Strategy

- Plan CPU preprocessing, feature extraction, metrics, and batch conversions on Fir.
- Use Trillium-GPU for actual GPU-heavy model training.
- Avoid duplicating large datasets in several user directories.
- Archive inactive outputs to nearline instead of leaving them in active project space forever.

## Practical Decision Rule

If a job spends most of its time on CPU, send it to Fir first. If it genuinely needs a full GPU or multiple GPUs, plan it for Trillium-GPU.

## Navigation

Next: [Lab Project Structure](./01_lab_project_structure.md)  
Back to [Module Overview](./README.md)
