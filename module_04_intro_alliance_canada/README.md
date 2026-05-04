# Module 04: Intro to Alliance Canada

This beginner module is a practical onboarding guide to the Digital Research Alliance of Canada, formerly Compute Canada. It focuses on getting a new lab member connected, oriented, and able to run safe first jobs on the compute clusters without jumping straight into advanced performance tuning.

## Who This Module Is For

This module is for:

- New users who need Alliance access for the first time
- Students who want to log in, understand storage, and run simple jobs

## Lab Allocation Context

Use these account names consistently when you work through the examples in this repository:

| Account | Role in this course |
|---|---|
| `def-kjerbi` | Normal/default allocation for onboarding and basic job examples in this module |
| `rrg-kjerbi` | Compute allocation with higher priority for more demanding CPU (Fir) and GPU (Trillium) workflows |

## Learning Path

| Step | Topic | What you will learn |
|---|---|---|
| 1 | [Getting Started](./01_getting_started.md) | What Alliance resources are and why the lab uses clusters |
| 2 | [Account Setup](./02_account_setup.md) | How to create an account and join the right lab allocations |
| 3 | [SSH Configuration](./03_ssh_configuration.md) | How to log in safely with SSH keys and host aliases |
| 4 | [Storage Basics](./04_storage_basics.md) | Where code, datasets, temp files, and results should live |
| 5 | [Running Jobs](./05_running_jobs.md) | How Slurm fits between login nodes and compute nodes |
| 6 | [Interactive Jobs with salloc](./06_interactive_jobs_salloc.md) | How to request a short debugging session |
| 7 | [Scheduled Jobs with sbatch](./07_scheduled_jobs_sbatch.md) | How to submit a batch script |
| 8 | [Array Jobs](./08_array_jobs.md) | How to run the same task many times safely |
| 9 | [Development Environments](./09_development_environments.md) | Safe VS Code and notebook workflows |
| 10 | [Monitoring Basics](./10_monitoring_basics.md) | How to inspect running and completed jobs |
| 11 | [Troubleshooting Basics](./11_troubleshooting_basics.md) | First checks for the most common beginner problems |

## Simple Cluster and Storage Decisions (for rrg-kjerbi allocation)

| Need | Recommended resource |
|---|---|
| CPU preprocessing, many small jobs, feature extraction | Fir |
| Active datasets | `/project/rrg-kjerbi/` on Fir or Trillium |
| Large GPU training requiring a full GPU | Trillium-GPU |
| Cold/archive storage | Fir Nearline | 

## What You Will Practice

- Logging in without putting passwords in scripts
- Choosing the right storage location before you start
- Requesting interactive jobs for debugging
- Submitting scheduled jobs and array jobs through Slurm
- Keeping heavy work off login nodes

## When To Move To Module 05

Move on to [Module 05: Advanced Alliance AI Workflows](../module_05_advanced_alliance_ai_workflows/README.md) when you need:

- Shared project folder design for a lab or collaboration
- Resource planning across `def-kjerbi` and `rrg-kjerbi`
- Fir CPU pipelines for preprocessing, feature extraction, or metrics at scale
- Trillium single-GPU or multi-GPU training
- Distributed PyTorch training with `torchrun` and DDP
- Cleanup, quota monitoring, and more advanced Slurm strategy
