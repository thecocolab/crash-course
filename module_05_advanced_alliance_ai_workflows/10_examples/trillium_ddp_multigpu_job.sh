#!/usr/bin/env bash
# Example multi-GPU DDP job for Trillium using torchrun.

#SBATCH --job-name=trillium_ddp
#SBATCH --account=rrg-kjerbi
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --gres=gpu:4
#SBATCH --time=04:00:00
#SBATCH --output=trillium-ddp-%j.out

set -euo pipefail

# If a current Trillium example for your exact queue or hardware path includes
# an extra partition, QoS, or constraint flag, follow that documented example.

module load python/3.12

# Activate an environment that already contains torch with distributed support.
# Example:
# source /project/rrg-kjerbi/shared_envs/<env_name>/bin/activate

GPUS_PER_NODE="${GPUS_PER_NODE:-4}"
MASTER_ADDR="$(scontrol show hostnames "${SLURM_NODELIST}" | head -n 1)"
MASTER_PORT="${MASTER_PORT:-$((10000 + SLURM_JOB_ID % 50000))}"
RUN_ROOT="${SLURM_TMPDIR:-/tmp}/ddp_example_run"

mkdir -p "${RUN_ROOT}"

cat > "${RUN_ROOT}/train_ddp.py" <<'PY'
import os
import time
from pathlib import Path

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
    out_dir = Path(os.environ["RUN_ROOT"])

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
        time.sleep(0.5)

    if dist.get_rank() == 0:
        torch.save(model.module.state_dict(), out_dir / "checkpoint_rank0.pt")

    dist.destroy_process_group()


if __name__ == "__main__":
    main()
PY

export RUN_ROOT
export MASTER_ADDR MASTER_PORT

torchrun \
  --nnodes=1 \
  --nproc_per_node="${GPUS_PER_NODE}" \
  --master_addr="${MASTER_ADDR}" \
  --master_port="${MASTER_PORT}" \
  "${RUN_ROOT}/train_ddp.py"

echo "DDP example finished. For multi-node scaling, derive MASTER_ADDR from"
echo "the first host in SLURM_NODELIST and launch one torchrun context per node."
