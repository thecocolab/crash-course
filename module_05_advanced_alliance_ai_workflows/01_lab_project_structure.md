# Lab Project Structure

This section suggests a practical way to organize shared work under `/project/rrg-kjerbi`. The main idea is simple:

- use BIDS for datasets whenever the dataset type supports it
- keep code in GitHub as the main source of truth
- use `/project` mainly for shared data, configs, outputs, checkpoints, and logs

This is a recommendation, not a strict rule. The goal is to make shared work easier to understand, reuse, and maintain.

## Core Principles

For this module, the most useful default is:

- datasets follow BIDS when possible
- code lives in GitHub
- cluster storage holds data and runtime artifacts

That separation helps because:

- new lab members can understand datasets faster
- code history stays in version control
- data and outputs stay in the shared filesystem where collaborators expect them
- projects are easier to reproduce

## Suggested Shared Layout

```text
/project/rrg-kjerbi/
  datasets/
    <dataset_name>/
  projects/
    <project_name>/
      configs/
      outputs/
      checkpoints/
      logs/
  shared_envs/
  docs/
  tmp/
```


## Datasets: Prefer BIDS When It Fits

If a dataset type fits BIDS, BIDS is usually the best starting point.

Why BIDS helps:

- it gives collaborators a shared naming convention
- it gives collaborators a shared folder convention
- it makes datasets easier for new collaborators / future lab members to read
- it improves reproducibility across projects
- many neuroimaging tools already understand BIDS directly


## Example BIDS-Oriented Dataset Layout

```text
/project/rrg-kjerbi/datasets/<dataset_name>/
  README.md
  dataset_description.json
  participants.tsv
  sub-0001/
  sub-0002/
  derivatives/
```

If the dataset is not in BIDS yet, it is still useful to document:

- whether it already follows BIDS
- whether a BIDS conversion exists
- where the raw data lives
- where derivatives or processed outputs are stored

## Code: Prefer GitHub as the Source of Truth

Use GitHub for:

- version control
- collaboration
- pull requests and review
- issue tracking
- release history

Use the cluster for:

- checked-out working copies
- configuration files needed for runs
- outputs, checkpoints, and logs

In practice, a project often looks like this:

- code repository on GitHub
- cluster checkout in `/home/<username>/...` or another small working directory
- shared runtime artifacts in `/project/rrg-kjerbi/projects/<project_name>/...`

## Suggested Per-Project Runtime Layout

```text
/project/rrg-kjerbi/projects/<project_name>/
  configs/
  outputs/
  checkpoints/
  logs/
```

This keeps shared project storage focused on the things that are large, collaborative, or expensive to reproduce.

## What To Document

### Dataset README

Each shared dataset should have a short `README.md` that covers:

- data source
- owner/contact
- date added
- license or access constraints
- whether the dataset follows BIDS
- preprocessing or conversion steps
- expected size
- downstream projects

### Project README

Each shared project folder can have a short `README.md` that covers:

- project goal
- owner
- collaborators
- GitHub repository
- datasets used
- environment
- main scripts or entrypoints
- output locations

## Naming Guidance

- Use lowercase with underscores or hyphens consistently.
- Prefer descriptive names such as `eeg_pretraining_2026` over `project_final_v2`.
- Put dates in `YYYY-MM-DD` or `YYYYMMDD` format.
- Keep dataset names stable once collaborators depend on them.
- Keep project names stable once shared outputs or scripts depend on them.

## Practical Example

A common pattern is:

```bash
mkdir -p /project/rrg-kjerbi/projects/<project_name>/{configs,outputs,checkpoints,logs}
git clone https://github.com/<org>/<repo>.git
```

That keeps shared outputs in `/project` while the code remains in GitHub.

The companion setup script is in [10_examples/setup_project_folders.sh](./10_examples/setup_project_folders.sh).

## Navigation

Previous: [Resource Strategy](./00_resource_strategy.md)  
Next: [Storage and Data Lifecycle](./02_storage_and_data_lifecycle.md)  
Back to [Module Overview](./README.md)
