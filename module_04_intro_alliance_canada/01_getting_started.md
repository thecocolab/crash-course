# Getting Started with Alliance Clusters

This section explains what the Digital Research Alliance of Canada, formerly Compute Canada, provides and how to think about the main systems you are likely to encounter in the lab.

## What Is Alliance Canada?

Alliance Canada provides shared research computing infrastructure across Canada. In practice, that means access to clusters with more CPUs, more memory, more storage, and stronger GPUs than a typical laptop or workstation.

## Why Use Clusters Instead of a Laptop?

Clusters help when you need to:

- process many files or subjects
- run jobs for hours or days
- use shared lab storage
- train GPU models that do not fit comfortably on a personal machine
- keep work reproducible for collaborators

A laptop is still a good place to write code, inspect small samples, and test ideas before moving heavier work to the cluster.

## Which Systems Should You Know About?

For this course, the main systems are:

- `Fir`
- `Nibi`
- `Rorqual`
- `Trillium`
- `Narval`
- `TamIA`

You will also still see older names in documentation, scripts, or lab habits. Several current systems are successors to older national clusters.

## Cluster Landscape at a Glance

The table below is intentionally practical rather than exhaustive. Hardware details and allocation policies can change, so verify the current official docs before making large workflow decisions.

| System | Access model | Better for | Practical notes |
|---|---|---|---|
| `Fir` | `def-kjerbi` or `rrg-kjerbi`. | Default choice for CPU-heavy preprocessing and many batch jobs with higher priority using `rrg-kjerbi`; also relevant for modern GPU work when your allocation targets it (only on `def-kjerbi`). | Best first target for many CPU-heavy and GPU workflows. 50 Tb of project space available. 300 Tb of Nearline storage |
| `Nibi` | Only `def-kjerbi`. | An alternative to Fir for both CPU and GPU jobs. | Only 1Tb of project space available. |
| `Rorqual` | Only `def-kjerbi`. | Strong GPU-oriented workloads and modern AI jobs. | Compute nodes do not have internet access. |
| `Trillium` |  `def-kjerbi` or `rrg-kjerbi`. | Large node-based jobs, some advanced GPU workflows, and workloads already. Best for Large models (i.e Foundation Models, LLMs, etc.)  | 1 Job allocates the whole node (80Gb VRAM per node). 150 Tb of project space available. |
| `Narval` | Only `def-kjerbi`. | Good when you are already set up there or when an A100-class GPU is sufficient. | Useful, but not the newest hardware. |
| `TamIA` |  Only `aip-kjerbi`. | Dedicated AI jobs. | Special AI cluster. |

## How This Maps to Our Lab

For the purposes of this repository:

- `def-kjerbi` is the normal/default Alliance allocation.
- `rrg-kjerbi` is the compute allocation with higher priority, used for more resource-aware Fir and Trillium workflows

## A Simple Mental Model

If you are deciding quickly where to run something:

| Need | Good first choice |
|---|---|
| CPU preprocessing, feature extraction, dataset conversion, many small jobs | `Fir` |
| Large GPU training requiring a full modern GPU | `Trillium`, `Rorqual`, `Nibi`, or `Fir`, depending on your project and what you job requires. |
| Older but still useful Alliance GPU environment | `Narval` |
| AI-specific PAICE workflow with dedicated access | `TamIA` |

## The Most Important Rule

Do not run heavy workloads or coding agents on login nodes. That includes tools such as Codex, Antigravity, or similar agentic coding workflows that may launch commands, scans, or long-running processes.

Login nodes are for:

- connecting to the cluster
- editing files
- preparing job scripts
- launching jobs through Slurm

If you want to use a coding agent on the cluster, first request an interactive job with `salloc`, then run the agent from that allocated compute node instead of from the login node.

Heavy computation belongs on compute nodes obtained through `salloc` or `sbatch`.

## Practical Example

A safe first workflow still looks like this:

```bash
ssh <username>@<login_host>
cd <your_project_directory>
sbatch examples/hello_world_job.sh
```

That pattern is much safer than logging in and running a long Python script directly on the login node.

## Current Documentation Worth Bookmarking

- Alliance cluster overview: [https://alliancecan.ca/en/services/advanced-research-computing/national-services/clusters](https://alliancecan.ca/en/services/advanced-research-computing/national-services/clusters)
- Mila external/Alliance cluster guide: [https://docs.mila.quebec/technical_reference/clusters/external/](https://docs.mila.quebec/technical_reference/clusters/external/)

## What Comes Next

This module stays beginner-friendly. Advanced resource strategy, Trillium GPU workflows, and distributed PyTorch training are covered in `module_05`.

## Navigation

Next: [Account Setup](./02_account_setup.md)  
Back to [Module Overview](./README.md)
