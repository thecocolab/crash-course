# Distributed Training with DDP

This section gives a practical introduction to PyTorch Distributed Data Parallel (DDP) using Princeton's multi-GPU training material as the workflow template and PyTorch's official DDP documentation as the conceptual reference.

## What DDP Does

DDP runs one training process per GPU, keeps a model replica on each process, and synchronizes gradients across processes during training.

In practice, that means:

- each process should bind to one GPU
- each process gets a different shard of the data
- gradients are synchronized before the optimizer step

PyTorch's documentation also emphasizes that DDP does not shard the data for you automatically. You still need a `DistributedSampler`.

## When DDP Is Worth Using

Use DDP when:

- one GPU is too slow
- your model still fits on a single GPU, but you want to scale data-parallel training
- you need multi-GPU or multi-node experiments

DDP is overkill when:

- you have not validated the training loop on one GPU yet
- the job is CPU-bound
- the model and data pipeline are too small to benefit from multiple GPUs

## Recommended Progression

1. Validate the training script on CPU or one GPU.
2. Run a single-node multi-GPU job.
3. Only then consider multi-node scaling.

## Minimal `train_ddp.py` Skeleton

```python
import os
import torch
import torch.distributed as dist
from torch.nn.parallel import DistributedDataParallel as DDP
from torch.utils.data import DataLoader, DistributedSampler, TensorDataset


def main():
    dist.init_process_group(backend="nccl")

    local_rank = int(os.environ["LOCAL_RANK"])
    torch.cuda.set_device(local_rank)
    device = torch.device("cuda", local_rank)

    x = torch.randn(1024, 32)
    y = torch.randint(0, 2, (1024,))
    dataset = TensorDataset(x, y)
    sampler = DistributedSampler(dataset, shuffle=True)
    loader = DataLoader(dataset, batch_size=32, sampler=sampler)

    model = torch.nn.Sequential(
        torch.nn.Linear(32, 64),
        torch.nn.ReLU(),
        torch.nn.Linear(64, 2),
    ).to(device)
    model = DDP(model, device_ids=[local_rank])

    optimizer = torch.optim.Adam(model.parameters(), lr=1e-3)
    loss_fn = torch.nn.CrossEntropyLoss()

    for epoch in range(2):
        sampler.set_epoch(epoch)
        for batch_x, batch_y in loader:
            batch_x = batch_x.to(device)
            batch_y = batch_y.to(device)
            optimizer.zero_grad()
            logits = model(batch_x)
            loss = loss_fn(logits, batch_y)
            loss.backward()
            optimizer.step()

        if dist.get_rank() == 0:
            print(f"epoch={epoch} loss={loss.item():.4f}")

    if dist.get_rank() == 0:
        torch.save(model.module.state_dict(), "checkpoint_rank0.pt")

    dist.destroy_process_group()


if __name__ == "__main__":
    main()
```

## Single-Node Multi-GPU Launch Pattern

For one node with four GPUs:

```bash
torchrun --standalone --nproc_per_node=4 train_ddp.py
```

## Multi-Node Launch Pattern

When you scale to multiple nodes under Slurm, derive the master node from the first hostname in the allocation and choose a stable port:

```bash
MASTER_ADDR=$(scontrol show hostnames "$SLURM_NODELIST" | head -n 1)
MASTER_PORT=${MASTER_PORT:-$((10000 + SLURM_JOB_ID % 50000))}
```

One practical pattern is to let `srun` start one `torchrun` launcher per node:

```bash
srun --ntasks="$SLURM_NNODES" --ntasks-per-node=1 bash -lc '
  torchrun \
    --nnodes="$SLURM_NNODES" \
    --nproc_per_node="$GPUS_PER_NODE" \
    --node_rank="$SLURM_NODEID" \
    --master_addr="'"$MASTER_ADDR"'" \
    --master_port="'"$MASTER_PORT"'" \
    train_ddp.py
'
```

Use one launch pattern consistently inside a given script instead of mixing several partially configured approaches.

## Slurm Multi-GPU Job Example

See [10_examples/trillium_ddp_multigpu_job.sh](./10_examples/trillium_ddp_multigpu_job.sh) for a self-contained example.

## Environment Variable Cheat Sheet

| Variable | Meaning |
|---|---|
| `MASTER_ADDR` | Hostname of the process coordinating rendezvous |
| `MASTER_PORT` | Port used for rendezvous |
| `WORLD_SIZE` | Total number of training processes across all nodes |
| `RANK` | Global rank of the current process |
| `LOCAL_RANK` | Rank of the current process on the current node |
| `SLURM_PROCID` | Slurm task index across the whole allocation |
| `SLURM_LOCALID` | Slurm task index on the current node |
| `SLURM_NTASKS` | Total number of Slurm tasks in the job |

## Warnings

- DDP can hang if networking or rank setup is wrong.
- Each process should bind to one GPU.
- Use `DistributedSampler` for dataset sharding.
- Save checkpoints only from rank 0 unless you intentionally want per-rank artifacts.
- Validate on one GPU before scaling.

## Navigation

Previous: [Trillium GPU Workflows](./04_trillium_gpu_workflows.md)  
Next: [Slurm Optimization](./06_slurm_optimization.md)  
Back to [Module Overview](./README.md)
