# ComputeCanada from Scratch

The Digital Research Alliance of Canada, previously known as ComputeCanada (CC), provides high-performance computing (HPC) infrastructure to support academic research across Canada. The computing facilities, also known as clusters, are operated by the Digital Research Alliance of Canada through regional partners.

This guide will walk you through the steps to access these cluster machines and run your first script.

## Acknowledging ComputeCanada

If you use CalculQuebec / ComputeCanada resources in a paper or poster, please acknowledge them appropriately. For guidance on how to cite their contributions, refer to the [ComputeCanada Acknowledgment Guidelines](https://alliancecan.ca/en/services/advanced-research-computing/acknowledging-alliance).

## Sponsorship

Access to the ComputeCanada clusters is granted through sponsorship by a Canadian academic. The only criterion is that the sponsoree must have some affiliation (e.g., Student or Collaborator). To obtain sponsorship:

1. **Register for an Account**: Visit the [Compute Canada Database](https://ccdb.alliancecan.ca/security/login) and create an account. When prompted, request your sponsor's ID in the format `www-yyy-zz`.
2. **Approval**: After submitting your request, your sponsor (e.g., Professor Karim) will need to approve and activate your account.

## Access

Once your account is approved, you will have access to most clusters (e.g., Beluga, Cedar). Connect to a cluster via SSH using the command: `ssh USERNAME@CLUSTER_NAME.computecanada.ca`. To view the technical specifications of each cluster, visit [this link](https://alliancecan.ca/en/services/advanced-research-computing/national-services/clusters). You can also watch this [mini webinar](https://www.youtube.com/playlist?list=PLlIsA3IgWjnweFiHlOjBmsF2NTeJ6f5rT) to help you get started.

#### SSH Keys

To avoid entering your password each time you connect, set up [SSH keys](https://docs.alliancecan.ca/wiki/Using_SSH_keys_in_Linux).

#### Accessing Your Folder

To navigate to your main folder, use the command `cd projects/<sponsor_id>/<USERNAME>` in the terminal. There are different types of storage:

- **Home**: For personal use, offering 50 GB of permanent storage.
- **Scratch**: 20 TB of temporary storage with a 90-day expiry on unused data. Ideal for storing large files temporarily.
- **Project**: 1 TB of storage for the entire team. Suitable for securely storing important, large data permanently.

Use the `diskusage_report` command to quickly check the storage status of all disks. For more details, refer to [this link](https://docs.alliancecan.ca/wiki/Storage_and_file_management).

#### Data Transfer

To transfer data from a local system to a cluster or between clusters, use Globus, a graphical user interface tool. For more details, visit the [Globus Documentation](https://docs.globus.org/how-to/).

You can also use other programs like FileZilla or the command-line tool `rsync`.

For automatic synchronization between your local system and the cluster, refer to the [Compute Canada Documentation](https://docs.alliancecan.ca/wiki/Transferring_data#Synchronizing_files).

## Getting Started

#### Resource Request

Before executing any code, request computing resources. This is like asking for a portion of RAM, CPU, GPU, etc., from the server. You can request resources interactively or as batch jobs:

- **Interactive Jobs**: Allows you to access the server interactively through tools like Visual Studio Code. Use the command:
  ```bash
  salloc --time=01:00:00 --mem=4G --cpus-per-task=4 --account=def-kjerbi
  ```

- **Batch Jobs**: Runs computations in the background. Create a shell script with the `.sh` extension (e.g., `jobscript.sh`), and add:
  ```bash
  #!/bin/bash
  #SBATCH --time=01:00:00  # Job duration is 1 hour
  #SBATCH --cpus-per-task=4  # Number of CPU cores
  #SBATCH --mem=4G  # Amount of memory
  #SBATCH --account=def-kjerbi  # Use the sponsor's account

  module load python/3.8  # Load required modules, e.g., Python
  srun python my_script.py  # Execute your script
  ```

  Submit the batch job with:
  ```bash
  sbatch jobscript.sh
  ```

  Monitor the status of your job using:
  ```bash
  squeue -u <USERNAME>  # or simply `sq`
  ```

#### Your first interactive job using jupyter notebooks:
1. **Create a Virtual Environment:**

   Follow the instructions in the [virtual environment documentation](https://docs.alliancecan.ca/wiki/Python#Creating_and_using_a_virtual_environment) to create your virtual environment.

2. **Activate Your Environment:**

   ```bash
   source env/bin/activate
   ```

   Then, install the required packages:

   ```bash
   pip install jupyter
   ```

3. **Set Up a Script to Start Jupyter:**

   Create a script to start Jupyter:

   ```bash
   echo -e '#!/bin/bash\nunset XDG_RUNTIME_DIR\njupyter notebook --ip $(hostname -f) --no-browser' > $VIRTUAL_ENV/bin/notebook.sh
   ```

   Make the script executable:

   ```bash
   chmod u+x $VIRTUAL_ENV/bin/notebook.sh
   ```

4. **Start an Interactive Job:**

   Request an interactive job with the following command:

   ```bash
   salloc --time=2:59:0 --ntasks=10 --nodes=1 --gres=gpu:2 --mem=30G --account=def-kjerbi
   ```

5. **Start the Jupyter Kernel:**

   Run the Jupyter notebook using the script:

   ```bash
   $VIRTUAL_ENV/bin/notebook.sh
   ```

6. **Configure SSH to Keep the Connection Alive:**

   Create or modify your SSH config file to prevent frequent disconnections:

   ```bash
   touch ~/.ssh/config
   chmod 600 ~/.ssh/config
   ```

   Add the following lines to the config file:

   ```
   Host *
       ServerAliveInterval 200
       ServerAliveCountMax 3
   ```

7. **Set Up SSH Tunneling:**

   In a new terminal on your local system, establish an SSH tunnel:

   ```bash
   sshuttle --dns -Nr USERNAME@CLUSTER.computecanada.ca
   ```

   If you encounter an error, try:

   ```bash
   sshuttle --dns -Nr USERNAME@CLUSTER.computecanada.ca -x <ip_in_error_message> 0/0
   ```

8. **Access Jupyter Notebook:**

   Open your browser and navigate to the Jupyter notebook link provided in the cluster terminal. For example:

   ```
   http://NODE.int.CLUSTER.computecanada.ca:8888/?token=d13f5fa60f81548ba966c7ff12928539bbfa23607188ad5a
   ```

9. **You’re Ready to Work:**

   For more details, refer to the [ComputeCanada documentation](https://docs.alliancecan.ca/wiki/JupyterNotebook).


#### Using VSCode for an Interactive Job

If you prefer using text editors like VSCode, you can run your interactive jobs within it. Think of VSCode as the interface through which you interact with your server: when you execute a script, the command is sent over the network and executed on the server nodes. Here’s how you can set it up:

1. **Mount Your Remote Server:**

   Mounting remote server folders to your local machine can be very useful. Follow these steps to mount the remote server:

   **For macOS:**
   ```bash
   brew install sshfs
   mkdir ~/remote
   sshfs username@hostname:/remote/path ~/remote
   ```

   **For Ubuntu:**
   ```bash
   sudo apt-get install sshfs
   mkdir ~/remote
   sshfs username@hostname:/remote/path ~/remote
   ```

   Replace `username`, `hostname`, and `/remote/path` with your actual remote server credentials and directory path.

2. **Configure VSCode:**

   - Open VSCode and load your notebook.
   - Paste the link provided by the server into the kernel configuration of your notebook.

3. **Additional Resources:**

   For detailed instructions on using VSCode with remote servers, refer to the [ComputeCanada documentation](https://docs.alliancecan.ca/wiki/Visual_Studio_Code).


## General Advice and Pro Tips

- **Understand the Job Scheduler:** Familiarity with job scheduling can be very beneficial. Shorter jobs (typically multiples of 3 hours) generally have more opportunities and can receive allocations more quickly. For more details, check the [Job Scheduling Policies](https://docs.alliancecan.ca/wiki/Job_scheduling_policies).

- **Refer to Official Documentation:** The official technical documentation is an invaluable resource and often provides the answers you need. Always check it first.

- **Seek Help When Stuck:** If you encounter issues, you can:
  - Post your question on CoCo Slack.
  - Ask us for assistance.
  - Contact ComputeCanada support at [support@tech.alliancecan.ca](mailto:support@tech.alliancecan.ca).

- **Essential Resource:** The [Technical Documentation](https://docs.alliancecan.ca/wiki/Technical_documentation) is a must-read for comprehensive information.


## Advanced: Parallel Processing with Joblib

For computational tasks that can benefit from parallel execution, you can use the `joblib` library. This section demonstrates how to use `joblib` for parallel processing along with `itertools.product` for handling combinations of parameters.

#### Code Example

```python
from joblib import Parallel, delayed
from itertools import product

# Define your parameter lists here
ELEC_LIST = []  # Replace with your list of electrical parameters
FREQ_LIST = []  # Replace with your list of frequency parameters

def function(elec, freq):
    # Implement your processing code here.
    pass  # Replace this placeholder with your actual function code.

if __name__ == "__main__":
    # Use joblib's Parallel and delayed to parallelize the processing
    Parallel(n_jobs=-1)(
        delayed(function)(elec, freq) for elec, freq in product(ELEC_LIST, FREQ_LIST)
    )
```

#### Explanation

- **Imports:**
  - `Parallel` and `delayed` from `joblib` are used to parallelize the execution of your function.
  - `product` from `itertools` generates Cartesian products of input iterables, which helps in iterating over all combinations of parameters.

- **Parameter Lists:**
  - `ELEC_LIST` and `FREQ_LIST` should be populated with the parameters you want to process.

- **`function(elec, freq)`:**
  - This is a placeholder function where you should implement your actual processing logic. It will be called with each combination of `elec` and `freq`.

- **Parallel Execution:**
  - `Parallel(n_jobs=-1)` runs the `function` in parallel using as many jobs as available CPU cores.
  - `delayed(function)(elec, freq)` wraps the function call so that it can be executed in parallel.
  - `product(ELEC_LIST, FREQ_LIST)` generates all combinations of parameters.

#### Benefits

- **Efficiency:** Parallel processing can significantly speed up computations by leveraging multiple CPU cores.
- **Scalability:** Easily scale your processing by adjusting the number of jobs (`n_jobs`).

## Advanced: Using Array Jobs

Array jobs are a powerful feature available on many job scheduling systems, such as SLURM, that allow you to submit and manage multiple jobs simultaneously. This is particularly useful for tasks that are similar but need to be run with different parameters or datasets.

#### What is an Array Job?

An array job allows you to submit a single job that spawns multiple sub-jobs. Each sub-job runs independently but can share resources and setup. This can be more efficient than submitting many individual jobs, as it reduces overhead and simplifies job management.

#### Example Using SLURM

Here’s an example of how to set up an array job using SLURM:

1. **Create a Job Script:**

   Create a job script (`job_script.sh`) that will be executed for each array job. Include the SLURM directives and the commands you want to run. For example:

   ```bash
   #!/bin/bash
   #SBATCH --job-name=array_job
   #SBATCH --output=output_%A_%a.txt
   #SBATCH --error=error_%A_%a.txt
   #SBATCH --array=0-9  # Array indices from 0 to 9
   #SBATCH --time=01:00:00
   #SBATCH --mem=2G

   # Load any required modules or environments
   module load python/3.8

   # Define the array index
   INDEX=${SLURM_ARRAY_TASK_ID}

   # Execute your command, using INDEX to specify different parameters
   python my_script.py --param $INDEX
   ```

   - `#SBATCH --array=0-9`: Defines the range of array indices. This will create 10 jobs, each with a different index (0 through 9).
   - `SLURM_ARRAY_TASK_ID`: This environment variable holds the current array index and can be used within your script to handle different parameters or input files.

2. **Submit the Array Job:**

   Use the `sbatch` command to submit the array job:

   ```bash
   sbatch job_script.sh
   ```

   This will submit the array job to SLURM, and the scheduler will handle running each sub-job according to the specified array range.

#### Benefits of Array Jobs

- **Efficiency:** Reduces the overhead of submitting and managing multiple individual jobs.
- **Simplicity:** Simplifies job submission and monitoring by grouping related jobs together.
- **Resource Utilization:** Allows better use of computational resources by running similar jobs in parallel.

#### Additional Resources

For more details on array jobs and how to configure them, refer to the [Compute Canada Array Job Documentation](https://docs.alliancecan.ca/wiki/Job_arrays).

## Advanced: Running Multiple Array Jobs with SLURM and Python

Here, you'll learn how to automate the submission of multiple SLURM array jobs using a Python script. 

#### Overview

1. **Python Script:** Generates and submits SLURM array job commands with different parameters.
2. **SLURM Job Script:** Defines job details and executes a command for each array job.

#### Prerequisites

- **SLURM Scheduler:** Ensure access to a SLURM-managed cluster.
- **Python Environment:** Python must be installed along with necessary libraries.
- **SLURM Account:** You need an account with permissions to submit jobs.

#### Step 1: Prepare the Python Script

Create a Python script named `submit_array_jobs.py` to automate job submission. This script will generate SLURM job submissions with different parameters.

```python
import os

# Define toy parameter lists
data_sets = ["data1", "data2"]
algorithms = ["algo1", "algo2"]
hyperparameters = ["0.1", "0.01"]

# Submit SLURM array jobs
for data_set in data_sets:
    for algorithm in algorithms:
        for hyperparameter in hyperparameters:
            os.system(f'sbatch job_script.sh {data_set} {algorithm} {hyperparameter}')
```

#### Step 2: Create the SLURM Job Script

Create a SLURM job script named `job_script.sh`. This script configures the job and runs a toy command for each array job.

```bash
#!/bin/bash

#SBATCH --account=def-kjerbi
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=1:00:00
#SBATCH --mem-per-cpu=2G
#SBATCH --array=0-5
#SBATCH --output=job_output_%A_%a.out
#SBATCH --error=job_error_%A_%a.err
#SBATCH --job-name=example_job_%A_%a

# Load any required modules or environments
module load python/3.8

# Execute a command or script
python /path/to/toy_script.py --data_set $1 --algorithm $2 --hyperparameter $3 --index $SLURM_ARRAY_TASK_ID
```

#### Step 3: Create the Python Execution Script

Create a Python script named `toy_script.py` that performs some toy computation based on the parameters provided.

```python
import argparse

def main():
    parser = argparse.ArgumentParser(description="Toy script")
    parser.add_argument('--data_set', type=str, required=True, help='Name of the data set')
    parser.add_argument('--algorithm', type=str, required=True, help='Algorithm name')
    parser.add_argument('--hyperparameter', type=str, required=True, help='Hyperparameter value')
    parser.add_argument('--index', type=int, required=True, help='Array job index')
    
    args = parser.parse_args()
    
    print(f"Processing data set: {args.data_set}, algorithm: {args.algorithm}, hyperparameter: {args.hyperparameter}, index: {args.index}")

if __name__ == "__main__":
    main()
```

#### Step 4: Run the Python Script to Submit Jobs

Execute the Python script `submit_array_jobs.py` to submit all the array jobs to SLURM:

```bash
python submit_array_jobs.py
```

This command will generate and submit SLURM jobs for all combinations of parameters defined in the `submit_array_jobs.py` script.

## Advanced: Optimizing Computations by Using Node's Temporary Directory (node-local storage)

When running computations on a cluster, using the node’s temporary directory (`$SLURM_TMPDIR`) can significantly speed up your tasks. This directory is local to the node and provides faster read and write speeds compared to scratch/projects storage.

#### Why Use the Node's Temporary Directory?

1. **Speed:** Accessing data from local storage is much faster than accessing data from network-mounted filesystems or shared storage.
2. **Efficiency:** Temporary files created during computations can be stored and processed more efficiently on local disk.
3. **Reduced I/O Bottlenecks:** By using local storage, you minimize the bottleneck associated with network I/O operations, which can be a limiting factor in multi-node computations.

#### How to Use the Node’s Temporary Directory

1. **Modify Your SLURM Job Script**

   You need to modify your SLURM job script to use the node’s temporary directory for storing intermediate files. Below is an example job script, `job_script.sh`, that demonstrates how to set up and use the temporary directory:

   ```bash
   #!/bin/bash

   #SBATCH --account=def-example
   #SBATCH --ntasks=1
   #SBATCH --cpus-per-task=4
   #SBATCH --time=1:00:00
   #SBATCH --mem-per-cpu=2G
   #SBATCH --output=job_output_%A_%a.out
   #SBATCH --error=job_error_%A_%a.err
   #SBATCH --job-name=example_job_%A_%a

    cd $SLURM_TMPDIR
    mkdir work

   # Use the temporary directory for computations
   cp /path/to/input/data work/
   
   # Run your computation using files in the temporary directory
   python /path/to/toy_script.py --input work/data --output work/results
   
   # Move your results to your scratch/projects folder
   cp /results /path/to/your/results/folder

   # Optionally, but recommended, clean up the temporary directory
   rm -rf work
   ```

- **Use Appropriate Paths:** Ensure that paths to the temporary directory and files are correctly specified and handled in both SLURM and Python scripts.


## Acknowledgment 
This tutorial was based on previous materials created by Anirudh ([doc](https://docs.google.com/document/d/1w_qt5vfLQc116Ha8rJ5qDLqSrn5JyHQBeKEv3rby7DI/edit) and [git](https://github.com/anirudhk686/install-setup-instructions/blob/master/cluster%2Bjupyter%2Batom.txt)) and Arthur ([git](https://github.com/arthurdehgan/calQ_examples/tree/master)).