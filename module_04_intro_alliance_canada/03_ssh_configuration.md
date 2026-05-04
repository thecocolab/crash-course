# SSH Configuration

This section gives you a practical SSH setup you can copy into `~/.ssh/config`, then adjust for your username, SSH key path, and any cluster-specific details that need confirmation.

## SSH Basics

SSH is how you connect to Alliance login nodes from your own machine.

The simplest pattern is:

```bash
ssh <username>@<login_host>
```

For repeated use, define host aliases in `~/.ssh/config` so you can type short commands such as `ssh fir`, `ssh narval`, or `ssh trillium-gpu`.

## SSH Keys

Use SSH keys instead of repeatedly typing passwords.

Typical workflow:

```bash
ssh-keygen -t ed25519 -C "<your_email>"
```

Then add the public key to the systems you use, following the current Alliance guidance for SSH keys.

Useful official links:

- Alliance guide: [Using SSH keys in Linux](https://docs.alliancecan.ca/wiki/Using_SSH_keys_in_Linux)
- Alliance CCDB page for uploading authorized keys: [https://ccdb.alliancecan.ca/ssh_authorized_keys](https://ccdb.alliancecan.ca/ssh_authorized_keys)

Practical sequence:

1. Generate the key pair with `ssh-keygen`.
2. Copy the contents of your public key file, usually `~/.ssh/id_ed25519.pub`.
3. Upload that public key in CCDB.
4. Test SSH access to a login node before adding more complex `ProxyJump` rules.

## Copy-Paste SSH Config Template

This template is meant to be practical rather than perfect. Replace:

- `<username>` with your Alliance username
- `~/.ssh/id_ed25519` if you use a different private key path
- any placeholder hostname that still needs confirmation in the current docs

```sshconfig
# Shared defaults
Host *
  ServerAliveInterval 300
  ServerAliveCountMax 2
  ControlMaster auto
  ControlPersist 10m
  ControlPath ~/.ssh/cm-%r@%h:%p

# Login nodes
Host fir
  HostName fir.alliancecan.ca
  User <username>
  IdentityFile ~/.ssh/id_ed25519

Host nibi
  HostName nibi.alliancecan.ca
  User <username>
  IdentityFile ~/.ssh/id_ed25519

Host narval
  HostName narval.alliancecan.ca
  User <username>
  IdentityFile ~/.ssh/id_ed25519

Host rorqual
  HostName rorqual.alliancecan.ca
  User <username>
  IdentityFile ~/.ssh/id_ed25519

Host trillium-cpu
  HostName <trillium_cpu_login_host>
  User <username>
  IdentityFile ~/.ssh/id_ed25519

Host trillium-gpu
  HostName <trillium_gpu_login_host>
  User <username>
  IdentityFile ~/.ssh/id_ed25519

Host tamia
  HostName <tamia_login_host>
  User <username>
  IdentityFile ~/.ssh/id_ed25519

# Optional compute-node shortcuts
# Keep only the patterns that match the node names you actually see from Slurm.

# Narval compute-node patterns often look like nc12345, ng00001, nl00001.
Host nc????? ng????? nl?????
  ProxyJump narval
  User <username>
  IdentityFile ~/.ssh/id_ed25519

# Fir compute nodes
Host fir[0-9]*
  ProxyJump fir
  User <username>
  IdentityFile ~/.ssh/id_ed25519

# Nibi compute nodes
Host nibi[0-9]*
  ProxyJump nibi
  User <username>
  IdentityFile ~/.ssh/id_ed25519

# Rorqual compute nodes
Host rorqual[0-9]*
  ProxyJump rorqual
  User <username>
  IdentityFile ~/.ssh/id_ed25519

# TamIA internal node example.
# Replace the internal domain if your docs or support team specify a different one.
Host tc*
  ProxyJump tamia
  HostName %h.<tamia_internal_domain>
  User <username>
  IdentityFile ~/.ssh/id_ed25519

# Trillium compute-node names vary by site and queue.
# If your node names look like trillium123 or trillium-gpu123, adapt these examples.
Host trillium[0-9]*
  ProxyJump trillium-cpu
  User <username>
  IdentityFile ~/.ssh/id_ed25519

Host trillium-gpu[0-9]*
  ProxyJump trillium-gpu
  User <username>
  IdentityFile ~/.ssh/id_ed25519
```

## Common Login Commands

Once your config is in place, these become short and readable:

```bash
ssh fir
ssh nibi
ssh narval
ssh rorqual
ssh trillium-cpu
ssh trillium-gpu
ssh tamia
```

## SSH to a Specific Compute Node

This is useful when:

- you already started an interactive job with `salloc`
- you want a second shell on the same compute node
- you want to connect VS Code to that node instead of the login node

### Step 1: Find the Node Name

After your interactive job starts, record the actual node name:

```bash
hostname
echo "$SLURM_NODELIST"
```

You can also check from another shell:

```bash
squeue -j <job_id> -o "%N"
```

### Step 2: SSH to That Node from Your Local Terminal

If your `~/.ssh/config` compute-node pattern matches the hostname, you can often connect directly:

```bash
ssh <compute_node_name>
```

If you do not have a matching shortcut, use an explicit jump host:

```bash
ssh -J fir <compute_node_name>
ssh -J narval <compute_node_name>
ssh -J trillium-cpu <compute_node_name>
ssh -J trillium-gpu <compute_node_name>
```

Choose the jump host that matches the cluster where the allocation is running.

### Step 3: Connect VS Code to the Compute Node

From VS Code:

1. Open the Command Palette.
2. Run `Remote-SSH: Connect to Host...`
3. Pick the compute-node hostname directly if it is defined in `~/.ssh/config`.

If it is not defined, first add a matching `Host` rule or a `ProxyJump` rule in `~/.ssh/config`. VS Code will use the same SSH config file as the terminal.

## SSH from One Cluster to Another

Sometimes you are already logged into one cluster and need to reach another login node or a compute node elsewhere.

### Login Node to Another Login Node

Example:

```bash
ssh nibi
ssh trillium-cpu
ssh rorqual
```

That works if your SSH config and keys are available in that environment.

### One Cluster to a Compute Node on Another Cluster

Example shape:

```bash
ssh -J trillium-cpu <trillium_compute_node>
ssh -J fir <fir_compute_node>
```

If you are already on a different cluster login node, the command still uses the matching login node as the jump host for the destination cluster.

### Practical Advice

- When possible, connect from your local machine rather than chaining many remote hops.
- Use cluster-to-cluster SSH for access and debugging, not as a workaround for running heavy work on login nodes.
- Keep track of which cluster owns the compute node you are trying to reach.

## Security Guidance

- Do not put passwords in shell scripts.
- Do not paste API tokens into shared shell history on a public machine.
- Use SSH keys and environment variables instead of hard-coding secrets.

## Troubleshooting

### Permission denied

Check:

- Are you using the right private key?
- Did you upload the matching public key?
- Did your account approval finish?

### Wrong username

If the cluster rejects your login immediately, confirm the username tied to your Alliance account.

### Host key warning

If the host key changed, stop and verify the change before deleting old entries. A changed host key can be legitimate after maintenance, but it should never be ignored blindly.

### Cannot reach a compute node

Check:

- Is the job still running?
- Are you using the right jump host for that cluster?
- Does your `Host` pattern actually match the node name Slurm returned?

### SSH from one cluster to another fails

Check:

- Is your private key available on the source system?
- Does that remote environment have the same `~/.ssh/config` entries?
- Would it be simpler to start the connection from your local machine instead?

### VPN or network issues

If a connection works on one network but not another, test from a different network and check whether your institution requires VPN access for off-campus connections.

## Practical Example

After editing `~/.ssh/config`, test the login aliases one at a time:

```bash
ssh fir
ssh narval
ssh trillium-cpu
```

Then test the compute-node workflow only after you actually have an interactive allocation.

## Navigation

Previous: [Account Setup](./02_account_setup.md)  
Next: [Storage Basics](./04_storage_basics.md)  
Back to [Module Overview](./README.md)
