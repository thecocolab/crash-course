# Troubleshooting Basics

This section lists common beginner problems and the first checks that usually help.

## Common Problems

| Problem | First checks |
|---|---|
| Job stays pending | Did you request too much time, memory, CPU, or GPU for a simple test? |
| Permission denied | Are you on the right account, path, and shared directory? |
| `module: command not found` or module missing | Are you on the cluster shell environment you expected? Did you load the right module? |
| `command not found` | Is the tool installed, or did you forget to activate your environment? |
| Out of memory | Lower the workload or increase `--mem` after measuring a small run |
| No space left on device | Check whether `/scratch`, `/project`, or `$SLURM_TMPDIR` filled up |
| Python environment confusion | Confirm which Python interpreter is active before running the job |
| Accidentally running on a login node | Stop the process and move the workload into `salloc` or `sbatch` |

## Quick Commands

```bash
which python
python --version
squeue -u "$USER"
sacct -j <job_id>
df -h
```

## Practical Mindset

When a job fails, do not immediately request larger resources. First ask:

- Did the script run in the intended environment?
- Did the data path exist?
- Did I run this on a compute node?
- Did I over-request or under-request resources?

That habit saves both time and allocation.

## Navigation

Previous: [Monitoring Basics](./10_monitoring_basics.md)  
Next: [Advanced Alliance AI Workflows](../module_05_advanced_alliance_ai_workflows/README.md)  
Back to [Module Overview](./README.md)
