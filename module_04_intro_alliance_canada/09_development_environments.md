# Development Environments

This section covers two beginner-friendly ways to work with Alliance resources while keeping heavy computation on compute nodes instead of login nodes.

## Option 1: VS Code

VS Code with Remote SSH is a practical option when you want:

- a familiar editor
- terminal access on the cluster
- lightweight file browsing

Important reminder:

Heavy code must still run through Slurm, even if you opened the folder in VS Code.

The same rule applies to coding agents. You can run a coding agent from the CLI or from a VS Code terminal, but it should run inside an interactive job or another compute allocation, not on the login node.

### Basic VS Code Workflow

1. Install VS Code on your local machine.
2. Install the `Remote - SSH` extension.
3. Make sure your `~/.ssh/config` is set up first.

See [SSH Configuration](./03_ssh_configuration.md) for the copy-paste SSH config template and compute-node jump-host examples.

### Open VS Code on a Login Node

1. Open VS Code.
2. Open the Command Palette.
3. Run `Remote-SSH: Connect to Host...`
4. Choose a login alias such as:
   - `fir`
   - `narval`
   - `trillium-cpu`
   - `trillium-gpu`
5. Once connected, open only the folder you actually need instead of your whole home directory.

Important practical advice:

- do not open your entire `$HOME`
- do not open a huge dataset directory
- do not open the whole `/project` tree

Opening a very large home or data folder can make the remote connection slow and unresponsive because VS Code will try to index and watch far too many files.

Good uses for the login-node connection:

- editing code
- checking files
- preparing job scripts
- submitting `salloc` or `sbatch`

Do not use the login-node VS Code terminal to run heavy scripts, long training jobs, or coding agents that will do substantial work.

### Open VS Code on a Specific Compute Node After `salloc`

This is the safer workflow when you want to debug code, run a notebook server, or use a coding agent on a compute node.

#### Step 1: Connect to the Login Node

First open VS Code on the login node, or use a normal terminal and connect there:

```bash
ssh fir
```

#### Step 2: Request an Interactive Job

Example:

```bash
salloc --account=def-kjerbi --time=03:00:00 --cpus-per-task=4 --mem=16G
srun --pty bash -l
```

A roughly 3-hour interactive request is often a practical starting point for development work. Keep it short enough to be easy to schedule, and do not use this as a replacement for a long unattended batch job.

#### Step 3: Find the Compute Node Name

Once the interactive job starts, record the compute node:

```bash
hostname
echo "$SLURM_NODELIST"
```

Example output might look like:

```bash
fir12
```

#### Step 4: Make Sure SSH Can Reach That Node

If your `~/.ssh/config` already contains the compute-node `ProxyJump` pattern from [SSH Configuration](./03_ssh_configuration.md), you can usually connect directly from your local machine:

```bash
ssh fir12
```

If not, use an explicit jump host:

```bash
ssh -J fir fir12
```

#### Step 5: Reopen VS Code on That Compute Node

From your local VS Code:

1. Open the Command Palette.
2. Run `Remote-SSH: Connect to Host...`
3. Choose the compute-node hostname, such as `fir12`, if it is recognized in your SSH config.
4. If it is not listed, add the matching host pattern first in `~/.ssh/config`, then retry.

Once connected, you are editing and running terminal commands on the allocated compute node, not on the login node.

#### Step 6: Work Only Inside the Live Allocation

This matters:

- if the interactive job ends, the compute-node session is no longer valid
- if you disconnect for too long or the job is cancelled, you need a new allocation
- if the work needs to continue unattended, move it into `sbatch`

### Example Development Pattern

1. Connect to `fir` in VS Code.
2. Open your project folder.
3. Start an interactive job in the VS Code terminal.
4. Record the compute-node name.
5. Open a second VS Code window directly on that compute node.
6. Run the heavier debug session, notebook server, or coding agent there.

That pattern keeps the login node light while still giving you an interactive development environment.

### Coding Agents

If you want to use a coding agent such as Codex from the command line or from a VS Code terminal:

- start from an interactive job or another compute allocation
- run it on the compute node, not on the login node
- keep it for development, debugging, and short interactive work
- move long unattended work into `sbatch`

See [Coding Agents on Clusters](../module_05_advanced_alliance_ai_workflows/10_coding_agents_on_clusters.md) for a step-by-step workflow.

## Option 2: Jupyter Notebooks

Notebooks can be useful for exploration, but they should run inside an allocated job, not directly on a login node.

### Safe Pattern

1. Request an interactive job.
2. Start Jupyter on the compute node.
3. Forward the port from your local machine.

Example:

```bash
salloc --account=def-kjerbi --time=01:00:00 --cpus-per-task=4 --mem=16G
srun --pty bash -l
jupyter lab --no-browser --ip=127.0.0.1 --port=8888
```

From your local machine, use a forwarding command shaped like:

```bash
ssh -N -L 8888:<compute_node>:8888 <username>@<login_host>
```

The exact forwarding pattern depends on the current cluster setup and how your interactive session is exposed.

TODO: Verify whether the current Trillium or Fir workflow recommends Open OnDemand or another cluster-specific Jupyter path for your lab before standardizing notebook instructions.

## Practical Advice

- Use VS Code and notebooks for development, debugging, and exploration.
- Move stable pipelines into scripts you can rerun with `sbatch`.
- If a notebook, terminal workflow, or coding agent starts consuming significant CPU, memory, or GPU time, run it inside an interactive allocation or convert it into a batch job.
- Open the smallest project folder that actually contains the code or config you need.

## Navigation

Previous: [Array Jobs](./08_array_jobs.md)  
Related: [Coding Agents on Clusters](../module_05_advanced_alliance_ai_workflows/10_coding_agents_on_clusters.md)  
Next: [Monitoring Basics](./10_monitoring_basics.md)  
Back to [Module Overview](./README.md)
