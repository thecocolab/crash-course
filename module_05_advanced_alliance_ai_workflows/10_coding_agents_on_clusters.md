# Coding Agents on Clusters

This page shows a simple way to run coding agents on Alliance systems without putting that load on the login node.

## Main Rule

Do not run coding agents on login nodes.

If you want to use a coding agent such as Codex from the CLI or from a VS Code terminal, first request an interactive job and run the agent from the allocated compute node.

## When This Is Appropriate

Use this workflow when you want to:

- inspect code
- edit files
- run short development commands
- debug on a compute node

Do not use this as a substitute for a long unattended production job.

## CLI Workflow

### Step 1: Connect to the Cluster

Example:

```bash
ssh fir
```

### Step 2: Request an Interactive Job

Example:

```bash
salloc --account=def-kjerbi --time=03:00:00 --cpus-per-task=4 --mem=16G
srun --pty bash -l
```

A roughly 3-hour interactive request is often a practical starting point for development work, but it is still meant for short interactive use rather than long unattended jobs.

### Step 3: Confirm You Are on the Compute Node

```bash
hostname
echo "$SLURM_NODELIST"
```

### Step 4: Start the Coding Agent

From that compute-node shell, start the coding agent the same way you normally would from the command line.

The exact command depends on the tool you use, but the important point is where you run it:

- good: inside the allocated compute-node shell
- not allowed: directly on the login node

## VS Code Workflow

### Step 1: Connect VS Code to the Login Node

Open VS Code and connect with `Remote-SSH` to a login alias such as `fir`.

### Step 2: Start an Interactive Job

In the VS Code terminal:

```bash
salloc --account=def-kjerbi --time=03:00:00 --cpus-per-task=4 --mem=16G
srun --pty bash -l
```

### Step 3: Record the Compute Node Name

```bash
hostname
```

Example:

```bash
fir12
```

### Step 4: Reconnect VS Code to That Compute Node

If your SSH config includes the compute-node jump pattern, open a new VS Code window and connect directly to that node.

Example:

```bash
ssh fir12
```

Or, if needed:

```bash
ssh -J fir fir12
```

From VS Code:

1. Open the Command Palette.
2. Run `Remote-SSH: Connect to Host...`
3. Choose the compute-node hostname.

### Step 5: Run the Coding Agent in the Compute-Node Terminal

Open a terminal in that compute-node VS Code session and run the coding agent there.

## Good Habits

- keep coding-agent sessions short and interactive
- use `salloc` for hands-on development and debugging
- use `sbatch` for long unattended runs
- store important outputs in the right filesystem
- exit the session when you are finished

## Related Pages

- [SSH Configuration](../module_04_intro_alliance_canada/03_ssh_configuration.md)
- [Interactive Jobs with salloc](../module_04_intro_alliance_canada/06_interactive_jobs_salloc.md)
- [Development Environments](../module_04_intro_alliance_canada/09_development_environments.md)
- [Slurm Optimization](./06_slurm_optimization.md)

## Navigation

Previous: [Advanced Troubleshooting](./09_troubleshooting_advanced.md)  
Next: [References](./11_references.md)  
Back to [Module Overview](./README.md)
