# ComputeCanada from scratch

ComputeCanada is a Canadian high-performance computing (HPC) infrastructure, aiming to provide computing and support for academics to advance research. The computing facilities aka Clusters are spread across Canada, and they are run by the Digital Research Alliance of Canada, through regional partners.

The following guides walk you through step by step to be able to access those Cluster machines.

### Sponsorship. 
Access is enabled by sponsorship by a Canadian academic, with the only criterion being the sponsoree should have some sort of affiliation (e.g.: Student or Collaborator). To get a sponsorship,
1. **Register for an Account**: Visit [Compute Canada Database](https://ccdb.alliancecan.ca/security/login) and register. When prompted, use Karim's CCRI: `kif-392-aa`.
2. **Approval**: Once you have submitted your registration, notify Karim to check his email for your approval.

### Access
Getting a sponsorship grants access to all the Compute Canada clusters (e.g.: Beluga, Cedar). Go to the terminal, access the machine in the cluster through `ssh YOUR_NAME@CLUSTER_NAME.computecanada.ca`. 


### Resource demand. 
Once connected, do not execute any code immediately. Instead, you need to request computing resources. You can think of it like you're asking for a piece of RAM, CPU, GPU etc from the giant server. This can be done in two ways: interactive "job", or as batch jobs. The former enables you to access the allocated server in an interactive manner through Visual Studio Code or equivalent. The latter enables you to perform the computation passively (you can think of it like the compute runs in the background).

### Slurm Scheduler. 
SLURM is a workload manager that has been to ask for resources. To ask for an interactive job : go to the terminal, and type `salloc --time=01:00:00 --mem=4G --cpus-per-task=4 --account=def-kjerbi`. As you can expect, each of the parameters has specific significance. `time` - duration for which you need to access the server, `mem` - Memory size for the job, `cpus-per-task` - number of CPU cores, `account` - PI's account through which you access. To run a batch job: you can create an shell script with an extension `.sh` e.g: jobscript.sh, inside which you need to add 

```#!/bin/bash
#SBATCH --time=01:00:00  # Job duration is 1 hour
#SBATCH --cpus-per-task=4  # Number of CPU cores
#SBATCH --mem=4G  # Amount of memory
#SBATCH --account=def-kjerbi  # Use the sponsor's account

module load python/3.8  # Load required modules, e.g., Python
srun python my_script.py  # Execute your script
```

This script basically asks the resource and run the script in the last time. To trigger this, run `sbatch jobscript.sh`. Once the command is run, your request is pushed into the SLURM's queue and you can monitor the status through `squeue`

### Using VScode for an interactive job
This [link](https://prashp.gitlab.io/post/compute-canada-tut/#531-using-jupyter-on-compute-canada) has all the necessary details to properly set up and access the ComputeCanada server nodes right from the VSCode interface. To give you an idea, VScode is like the interface, and when you run a script, the command is transferred over network and the script is run on the server nodes.

In most cases, mounting remote server folders to local machine would be greatly useful,
```
# For macOS
brew install sshfs
# For Ubuntu
sudo apt-get install sshfs
mkdir ~/remote
sshfs username@hostname:/remote/path ~/remote
```

### File System
There are three file systems;
- Home -> For personal use like scripts and small files, offering 50 GB of permanent storage.
- Scratch -> 20 TB of temporary storage with a 90-day expiry on untouched data. Meant to be used for storing massive files temporarily.
- Project -> 1TB for the whole team. Can be regarded as a place for securely storing important (large) data permanently.

`diskusage_report` gives you a quick glance at the storage status of all the disks.

### General advice and Protip
- Understanding about Jobscheduler comes in handy. Shorter (multiples of 3 hours, check https://docs.alliancecan.ca/wiki/Job_scheduling_policies for more) jobs usually have more opportunities, and can get allocations relatively quicker.
- Official technical documentation is second to none, you almost always expect an answer there. 
- If you are stuck, you can either post the question on CoCo Slack, or ask us, or even contact ComputeCanada support line at support@tech.alliancecan.ca.
- *Holy Bible* : https://docs.alliancecan.ca/wiki/Technical_documentation
- For those willing to go the extra mile: https://youtu.be/J9VCHe1ovBg?si=Bx0Xt-7PWoGzGhQU. (You can beat the 3h-long part by going 1.25x or even 1.5x !)

### Advanced Guidelines (Coming Soon)
- Loading and installing packages available ComputeCanada's software stack and the packages that are not
- Handy SLURM commands
- File transfer