# Account Setup

This section covers the minimum account setup steps a new lab member needs before using any of the clusters.

## High-Level Workflow

At a high level, onboarding usually looks like this:

1. Create your Alliance account in CCDB.
2. Ask to be added to the relevant lab allocation or project.
3. Wait for approval.
4. Confirm that you can log in to the systems you actually need.

Start here:

- CCDB login and registration: [https://ccdb.alliancecan.ca/security/login](https://ccdb.alliancecan.ca/security/login)
- Official Alliance documentation: [https://docs.alliancecan.ca](https://docs.alliancecan.ca)

Exact approval screens and renewal steps may change, so always check the current official documentation if the interface looks different from older screenshots or notes.

## Which Lab Accounts Matter Here?

For this course, keep these two examples in mind:

- `def-kjerbi`: the normal/default lab allocation.
- `rrg-kjerbi`: the compute allocation with higher priority, used for more resource-aware Fir and Trillium workflows.

Depending on your project, you may need access to one or both.

## Project Membership

An Alliance login is not enough by itself. You also need membership in the lab allocation or project space that will pay for your jobs and give you access to shared storage.

Examples:

- You may be added to `def-kjerbi` for general onboarding and smaller workflows.
- You may also need `rrg-kjerbi` for advanced compute usage on Fir or Trillium.

If you are unsure which allocation to request first, ask the lab member or PI managing access for your project.

## Checklist

- [ ] I created an Alliance account
- [ ] I requested the correct project membership or sponsor relationship
- [ ] I know whether I should use `def-kjerbi`, `rrg-kjerbi`, or both
- [ ] I completed MFA if the current workflow requires it
- [ ] I confirmed access to Fir, Trillium, or Trillium-GPU as applicable

## Practical Example Questions To Ask Early

Before you start moving data or writing job scripts, make sure you know:

- Which account should I submit beginner jobs under?
- Which shared `/project` directory should I use?
- Do I need Trillium GPU access right now, or only later?

Getting those answers early prevents a lot of avoidable storage and permission problems.

## Navigation

Previous: [Getting Started](./01_getting_started.md)  
Next: [SSH Configuration](./03_ssh_configuration.md)  
Back to [Module Overview](./README.md)
