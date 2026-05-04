# Storage Basics

This section explains the main storage locations on Alliance systems and where to put code, datasets, temporary files, and results.

## Main Storage Locations

| Location | Use it for |
|---|---|
| `/home` | Small code, shell config, environments, and personal settings |
| `/project` | Long-term storage and important results you want to keep |
| `/scratch` | Large temporary working files, caches, and intermediate outputs |
| `$SLURM_TMPDIR` | Temporary files created during a running job; often the fastest place for per-job reads and writes |
| `/nearline` | Archive storage for inactive completed work |

## The Main Rule for `/project`

`/project` is usually tied to an allocation such as:

- `/project/def-kjerbi/`
- `/project/rrg-kjerbi/`

TamIA is separate from those regular Alliance project spaces. It uses `aip-...` accounts, and the TamIA workflow should use the shared folder already associated with that TamIA allocation instead of building a parallel `rrg-kjerbi` layout there.

Inside that space, you have:
- personal subfolders such as `/project/<account>/<username>/`

You may also setup other folders for shared data preprocessing and analysis, such as:
- `/project/rrg-kjerbi/datasets/`

Use them differently:

- Shared datasets and shared project outputs go in agreed shared folders.
- Large personal results that need to stay in project storage can go in your own subfolder when the CoCoLab project space uses that convention.
- Small code repos and shell config should still stay in `/home`.

## Before Copying a Dataset

Check whether the dataset already exists in shared project storage.

Look in places such as:

- `/project/def-kjerbi/datasets/`
- `/project/rrg-kjerbi/datasets/`
- another shared lab folder

If the dataset already exists:

- reuse it
- read its `README.md` first
- do not make another private copy unless you really need one

When you add a new dataset in the shared project area, you should make it readable by every member of the group.

## How To Make a Folder Shared with the Lab

If you want a folder under `/project/rrg-kjerbi/` to be shared by lab members, you can start with this example:

Example target:

```bash
mkdir -p /project/rrg-kjerbi/projects/<project_name>/
```

If everyone needs access, use the project group directly. For a folder under `/project/rrg-kjerbi`, that usually means `rrg-kjerbi`:

```bash
mkdir -p /project/rrg-kjerbi/projects/<project_name>/
chgrp rrg-kjerbi /project/rrg-kjerbi/projects/<project_name>/
chmod g+rwx /project/rrg-kjerbi/projects/<project_name>/
chmod g+s /project/rrg-kjerbi/projects/<project_name>/
```

What that does:

- `chgrp` changes the folder group to the project group
- `chmod g+rwx` gives the group read, write, and execute access
- `chmod g+s` makes new files and folders inherit the directory group

Check the result with:

```bash
ls -ld /project/rrg-kjerbi/projects/<project_name>/
```

If that is not enough, Alliance documentation also describes ACL-based sharing. A simple next step is:

```bash
setfacl -m g:rrg-kjerbi:rwx /project/rrg-kjerbi/projects/<project_name>/
setfacl -d -m g:rrg-kjerbi:rwx /project/rrg-kjerbi/projects/<project_name>/
```

That makes the group permission explicit and sets the default ACL for new files created inside the folder.

You can inspect it with:

```bash
getfacl /project/rrg-kjerbi/projects/<project_name>/
```

For more detail on shared data and data-sharing groups, check:

- Alliance sharing guide: [https://docs.alliancecan.ca/wiki/Sharing_data](https://docs.alliancecan.ca/wiki/Sharing_data)
- Alliance storage guide: [https://docs.alliancecan.ca/wiki/Storage_and_file_management](https://docs.alliancecan.ca/wiki/Storage_and_file_management)
- Mila DRAC storage guide: [https://docs.mila.quebec/technical_reference/clusters/external/](https://docs.mila.quebec/technical_reference/clusters/external/)

## Sharing with Specific People

If only a specific subset of people should access a folder, use a data-sharing group or user-specific ACLs

Alliance documentation describes data-sharing groups as a way to target specific users. The usual workflow is:

1. Request the data-sharing group from Alliance technical support and ask to manage it.
2. Add only the specific users you want through CCDB Services.
3. Use that group on the folder with `chgrp`, or grant that group access with `setfacl`.

Typical pattern after the group exists:

```bash
chgrp <data_sharing_group> /project/rrg-kjerbi/projects/<project_name>/
chmod g+rwx /project/rrg-kjerbi/projects/<project_name>/
chmod g+s /project/rrg-kjerbi/projects/<project_name>/
```

Or, if you want to keep the main folder group but grant access to a specific sharing group:

```bash
setfacl -m g:<data_sharing_group>:rwx /project/rrg-kjerbi/projects/<project_name>/
setfacl -d -m g:<data_sharing_group>:rwx /project/rrg-kjerbi/projects/<project_name>/
```

Keep this beginner rule in mind:

- do not run recursive permission changes on a large shared folder unless you understand exactly who owns the existing files

## Simple Placement Guide

| Item | Recommended location |
|---|---|
| Git repo or small scripts | `/home/<username>/...` |
| Shared raw dataset | `/project/<account>/datasets/<dataset_name>/...` |
| Shared final outputs | `/project/<account>/projects/<project_name>/...` |
| Large personal result folder kept inside project storage | `/project/<account>/<username>/...` |
| Temporary preprocessing outputs | `/scratch/<username>/...` |
| Temporary files for one job (Needs to be moved after job completion) | `$SLURM_TMPDIR` |
| Old inactive outputs to be archived for record-keeping | `/nearline/...` |

## One Useful Note

Some environments expose project storage through `~/projects` or `$HOME/projects`.

If you see that path, treat it as another way to reach group project storage, not as a private folder.

## Practical Example

```bash
cp /project/rrg-kjerbi/datasets/<dataset_name>/metadata.csv "$SLURM_TMPDIR"/
python preprocess.py \
  --input /project/rrg-kjerbi/datasets/<dataset_name>/raw \
  --output /scratch/<username>/<run_name>
```

If you need to keep a larger user-specific result in project storage:

```bash
mkdir -p /project/rrg-kjerbi/<username>/<project_name>/
cp summary.tsv /project/rrg-kjerbi/<username>/<project_name>/
```

## Navigation

Previous: [SSH Configuration](./03_ssh_configuration.md)  
Next: [Running Jobs](./05_running_jobs.md)  
Back to [Module Overview](./README.md)
