# Storage and Data Lifecycle

This section maps common AI research artifacts to the right storage location at each stage of a project.

## Storage Roles

| Location | Best use |
|---|---|
| `/home` | Small code, shell config, and environment files |
| `/project` | Shared and personal active datasets and important outputs |
| `/scratch` | Temporary working space, caches, and large intermediate results |
| `$SLURM_TMPDIR` | Node-local temporary files during a running job |
| `/nearline` | Cold/archive storage for inactive completed work |

## Recommended Lifecycle

| Data stage | Recommended location |
|---|---|
| Raw data | `/project` |
| Processed data reused by multiple jobs | `/project` |
| Processed data needed only for a specific run | `/scratch` |
| Training cache | `/scratch` |
| Job temp files | `$SLURM_TMPDIR` |
| Final checkpoints and results | `/project` |
| Inactive completed project | `/nearline` |

## Example: Image Dataset Preprocessing

- Keep the shared raw dataset in `/project`.
- Run CPU preprocessing on Fir.
- Write temporary shards or caches to `/scratch`.
- Keep the reusable processed dataset in `/project` only if several jobs or collaborators will use it.

## Example: EEG or MEG Feature Extraction

- Store raw recordings and key metadata in `/project`.
- Run large CPU feature extraction jobs on Fir.
- Place intermediate scratch outputs in `/scratch`.
- Save the cleaned shared feature tables back to `/project` if the lab will reuse them.

## Example: Model Training with Checkpoints

- Keep the stable dataset in `/project`.
- Copy hot subsets or caches into `$SLURM_TMPDIR` or `/scratch` when it improves performance.
- Save important checkpoints and selected final metrics back to `/project`.

## Example: Archiving Old Checkpoints

Once a project is inactive:

- keep the final report, key checkpoints, and README in `/project` if still needed often
- move older or bulky archives to `/nearline`
- do not leave inactive checkpoint forests in active project storage forever

## Practical Example

```bash
cp -r /project/rrg-kjerbi/datasets/processed/<dataset_name> "$SLURM_TMPDIR"/
python train.py --data "$SLURM_TMPDIR/<dataset_name>" --output "/scratch/$USER/<run_name>"
```

## Navigation

Previous: [Lab Project Structure](./01_lab_project_structure.md)  
Next: [Fir CPU Workflows](./03_fir_cpu_workflows.md)  
Back to [Module Overview](./README.md)
