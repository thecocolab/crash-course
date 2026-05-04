# Collaboration and Permissions

This section covers the practical conventions that make shared storage usable by the lab instead of turning it into a pile of private folders.

## Shared Folder Basics

Good collaboration usually depends on:

- shared data folders
- group-readable or group-writable directories where appropriate
- clear READMEs
- documented provenance

## Safe Collaboration Conventions

- Put shared datasets in agreed lab locations, not personal ad hoc copies.
- Keep project READMEs current.
- Record who owns each dataset and who can answer questions about it.
- Do not store private credentials or unrelated personal files in shared project folders.
- Avoid duplicating the same dataset in several project directories.

## Useful Commands

Optional commands you may use, depending on site policy and support:

- `chgrp`
- `chmod`
- `umask`
- `setfacl` if available

## Safe Setup Pattern

```bash
mkdir -p /project/rrg-kjerbi/projects/<project_name>/{code,configs,outputs,logs}
chgrp <shared_group> /project/rrg-kjerbi/projects/<project_name>
chmod g+s /project/rrg-kjerbi/projects/<project_name>
```

Why this helps:

- `mkdir -p` creates the expected structure without deleting anything
- `chgrp` points the directory at the shared group
- `chmod g+s` helps new files inherit the directory group

Only use those commands after you understand the group and permission model for your project.

## Responsible Cleanup

- Do not delete shared files without checking ownership and project context.
- Keep old outputs documented before moving or archiving them.
- If a dataset is deprecated, note that in its README instead of silently removing it.

## Navigation

Previous: [Slurm Optimization](./06_slurm_optimization.md)  
Next: [Monitoring, Quotas, and Cleanup](./08_monitoring_quota_and_cleanup.md)  
Back to [Module Overview](./README.md)
