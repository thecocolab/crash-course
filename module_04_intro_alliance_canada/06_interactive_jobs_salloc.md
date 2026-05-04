# Interactive Jobs with salloc

This section explains when to use `salloc` and how to request a short interactive session safely.

## When To Use `salloc`

Use `salloc` when you want to:

- Debug a script on a compute node
- Test imports or environment setup
- Run a coding agent on a compute node instead of on the login node
- Check how much CPU, memory, or GPU a small test actually needs

Interactive jobs are meant for short hands-on work, not long production runs. A request around 3 hours is often reasonably fast to allocate for interactive use, but this still depends on the cluster and the resources you ask for.

Do not use `salloc` as a substitute for a long production run. If the work should continue after you disconnect, or if it will run for a long time unattended, write a batch script and use `sbatch`.

## Example: Quick CPU Debugging Session

```bash
salloc --account=def-kjerbi --time=00:30:00 --cpus-per-task=2 --mem=4G
srun --pty bash -l
```

After the shell opens on the compute node, you can run a short test such as:

```bash
python my_script.py --small-test
```

You can also use that allocated shell to run a coding agent safely on the compute node instead of on the login node.

## Example: Quick GPU Debugging Session

Only request a GPU if you actually need one.

```bash
salloc --account=def-kjerbi --time=00:30:00 --cpus-per-task=4 --mem=16G --gres=gpu:1
srun --pty bash -l
```

Typical quick checks:

```bash
nvidia-smi
python train.py --tiny-batch --max-steps 10
```

## Important Habits

- Keep interactive tests short.
- Use interactive jobs for debugging, iteration, or short coding-agent sessions, not for unattended long jobs.
- Measure what you need before asking for larger resources.
- Exit when finished.

To leave the interactive session:

```bash
exit
```

## Practical Example File

See [examples/interactive_session_example.sh](./examples/interactive_session_example.sh) for a printable reminder of the basic commands.

## Navigation

Previous: [Running Jobs](./05_running_jobs.md)  
Next: [Scheduled Jobs with sbatch](./07_scheduled_jobs_sbatch.md)  
Back to [Module Overview](./README.md)
