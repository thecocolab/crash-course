# References

This page lists the main references used to shape the guidance in `module_04` and `module_05`.

Compute Canada is now part of the Digital Research Alliance of Canada.

## Official Alliance References

- [Alliance Running Jobs](https://docs.alliancecan.ca/wiki/Running_jobs)  
  Used to ground the statement that Alliance clusters use Slurm and that jobs should be submitted through the scheduler.

- [Alliance Fir Documentation](https://docs.alliancecan.ca/wiki/Fir)  
  Used as the official cluster reference for Fir-oriented CPU workflow guidance.

- [Alliance Trillium Documentation](https://docs.alliancecan.ca/wiki/Trillium)  
  Used as the official cluster reference for Trillium-specific workflow notes.

- [Alliance Trillium Quickstart](https://docs.alliancecan.ca/wiki/Trillium_Quickstart)  
  Used for quickstart-oriented login and job-submission expectations, especially the distinction between CPU and GPU entry points.

- [Alliance Storage and File Management Documentation](https://docs.alliancecan.ca/wiki/Storage_and_file_management)  
  Used to structure the `/home`, `/project`, `/scratch`, and `$SLURM_TMPDIR` guidance.

- [Alliance Nearline Storage Documentation](https://docs.alliancecan.ca/wiki/Using_nearline_storage)  
  Used to reinforce that nearline is archival storage, not active training storage.

## Current Trillium and External-Cluster Context

- [SciNet Trillium Quickstart](https://docs.scinet.utoronto.ca/index.php/Trillium_Quickstart)  
  Used as a current accessible quickstart mirror confirming separate CPU and GPU login nodes and Slurm job submission.

- [Mila DRAC / External Cluster Documentation](https://docs.mila.quebec/technical_reference/clusters/external/)  
  Used for external-cluster access framing, allocation context, storage guidance, and examples of Alliance usage in AI research settings.

- [Mila Storage Documentation](https://docs.mila.quebec/technical_reference/clusters/mila/storage/)  
  Used as an additional filesystem and data-lifecycle reference, especially for the distinction between shared storage, scratch-like storage, and archive-style storage.

- [Mila Distributed Training Examples](https://docs.mila.quebec/examples/distributed/)  
  Used as a practical support reference for GPU and distributed training job patterns on Slurm-based research infrastructure.

- [Mila Multi-GPU Job Example](https://docs.mila.quebec/examples/distributed/multi_gpu/index.html)  
  Used as a supporting reference for one-process-per-GPU job structure and practical Slurm-to-DDP launch patterns.

- [Mila Advanced Slurm Usage and Multiple GPU Jobs](https://docs.mila.quebec/technical_reference/general_theory/multigpu/)  
  Used as a supporting reference for multi-GPU scheduling habits and resource-packing strategy.

## PyTorch and DDP References

- [Princeton multi_gpu_training Repository](https://github.com/PrincetonUniversity/multi_gpu_training)  
  Used as the practical template for the DDP section and for the emphasis on validating single-GPU training before scaling.

- [PyTorch DDP Tutorial Series](https://docs.pytorch.org/tutorials/beginner/ddp_series_intro.html)  
  Used for the `torchrun` and DDP workflow overview.

- [PyTorch DistributedDataParallel Documentation](https://docs.pytorch.org/docs/stable/generated/torch.nn.parallel.DistributedDataParallel.html)  
  Used for the explanation that DDP synchronizes gradients across replicas and still requires the user to shard data, for example with `DistributedSampler`.

- [PyTorch Distributed Overview](https://docs.pytorch.org/tutorials/beginner/dist_overview.html)  
  Used as supporting context for deciding when DDP is the right scaling tool.

## Navigation

Previous: [Coding Agents on Clusters](./10_coding_agents_on_clusters.md)  
Back to [Module Overview](./README.md)
