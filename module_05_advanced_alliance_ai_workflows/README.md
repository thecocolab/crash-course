# Module 05: Advanced Alliance AI Workflows

This module is for those who already know how to log in, use shared storage, and submit basic jobs. It focuses on using Fir and Trillium efficiently for AI research workflows without wasting compute, storage, or queue time.

## Allocation Context

Both `def-kjerbi` and `rrg-kjerbi` can be used for resource-aware workflows. The main difference is that `rrg-kjerbi` has higher priority, so the lab should use it deliberately and make the most of it.

| Account | Role in this module |
|---|---|
| `def-kjerbi` | General lab allocation that can be used for both short and large workflows when the job is well matched to the resource |
| `rrg-kjerbi` | Higher-priority allocation that should be spent carefully on jobs that make strong use of the allocated CPU or GPU capacity |

Practical framing for this module:

- Use both accounts responsibly.
- Use Fir for CPU jobs that genuinely make good use of the requested cores and memory.
- Use Trillium-GPU for jobs that really justify the full GPU node, such as large-model training, large-scale fine-tuning, distributed training, or other workloads that will heavily use the available GPU.
- Do not spend high-priority Trillium resources on light jobs that only use a small fraction of the node, such as a small CNN training run that could reasonably fit elsewhere.

Current planning context for `rrg-kjerbi`:

| Resource | Allocation context |
|---|---|
| Fir compute | 715 core-years |
| Fir `/project` storage | 50 TB |
| Fir `/nearline` storage | 299 TB |
| Trillium GPU | 150 RGU-years |
| Trillium `/project` storage | 150 TB |

## Decision Guide

| Need | Recommended choice |
|---|---|
| CPU preprocessing, feature extraction, dataset conversion, metrics, many small jobs | Fir |
| Shared active datasets and important collaborative outputs | `/project` |
| Full-GPU or multi-GPU model training | Trillium-GPU |
| Inactive completed project outputs | `/nearline` |

## What This Adds Beyond Module 04

Compared with `module_04`, this module adds:

- Allocation-aware resource planning
- Shared lab folder design
- Fir CPU pipeline patterns
- Trillium GPU workflow guidance
- Distributed PyTorch training with DDP
- Coding-agent workflows on compute nodes
- Advanced Slurm optimization
- Collaboration, permissions, quota monitoring, and cleanup

## Reading Order

| Step | Topic | Why it matters |
|---|---|---|
| 0 | [Resource Strategy](./00_resource_strategy.md) | Decide how to use `def-kjerbi` and `rrg-kjerbi` responsibly across Fir, Trillium, CPU, and GPU workloads |
| 1 | [Lab Project Structure](./01_lab_project_structure.md) | Keep shared project storage organized and reproducible |
| 2 | [Storage and Data Lifecycle](./02_storage_and_data_lifecycle.md) | Place raw data, caches, checkpoints, and archives correctly |
| 3 | [Fir CPU Workflows](./03_fir_cpu_workflows.md) | Use Fir as the default target for CPU-heavy jobs |
| 4 | [Trillium GPU Workflows](./04_trillium_gpu_workflows.md) | Use Trillium-GPU for jobs that actually need a full GPU |
| 5 | [Distributed Training with DDP](./05_distributed_training_ddp.md) | Scale PyTorch across multiple GPUs safely |
| 6 | [Slurm Optimization](./06_slurm_optimization.md) | Reduce queue waste and right-size jobs |
| 7 | [Collaboration and Permissions](./07_collaboration_permissions.md) | Share data safely across the lab |
| 8 | [Monitoring, Quotas, and Cleanup](./08_monitoring_quota_and_cleanup.md) | Keep jobs efficient and storage healthy |
| 9 | [Advanced Troubleshooting](./09_troubleshooting_advanced.md) | Diagnose the problems that show up after the basics |
| 10 | [Coding Agents on Clusters](./10_coding_agents_on_clusters.md) | Run coding agents on compute nodes instead of login nodes |
| 11 | [References](./11_references.md) | Review the official and supporting sources behind this module |

## Example Files

See [10_examples/](./10_examples/) for reusable script templates:

- `setup_project_folders.sh`
- `fir_cpu_array_job.sh`
- `trillium_single_gpu_job.sh`
- `trillium_ddp_multigpu_job.sh`
- `sync_to_nearline.sh`
