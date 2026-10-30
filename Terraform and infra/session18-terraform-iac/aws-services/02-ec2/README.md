# EC2 - Elastic Compute Cloud

## What is EC2?

Amazon Elastic Compute Cloud (EC2) provides configurable virtual servers, called instances, in AWS. You choose the operating system image, CPU/memory profile, storage, network placement, and security controls, then manage the software running on the instance.

## Core concepts

- **AMI (Amazon Machine Image):** A regional template for launching an instance. It specifies the operating system and may include preinstalled software and configuration. AMIs can be AWS-provided, marketplace-provided, or privately shared.
- **Instance types:** Hardware profiles that provide different balances of vCPU, memory, storage, and network performance. Families target general purpose, compute, memory, storage, or accelerated workloads. Select based on measured needs and cost.
- **Key pairs:** Public/private cryptographic keys used for supported operating-system login methods. AWS keeps the public key for launch; the private key must be protected by the owner. Key pairs are not a substitute for IAM authorization or secure network rules.
- **Security Groups:** Stateful virtual firewalls attached to network interfaces. Inbound and outbound allow rules control traffic; responses to allowed traffic are automatically permitted. Start with only required ports and trusted sources.
- **EBS (Elastic Block Store):** Persistent block storage volumes for EC2. Volumes exist independently of the instance lifecycle depending on their settings, can be snapshotted, and should be encrypted when appropriate. Instance store is different: it is temporary host-local storage.
- **Public vs private IP:** A public IPv4 address can be reachable from the internet only when routing and security rules allow it. A private IP is used for communication on private networks and is not directly internet-routable. Public IPv4 assignment and addresses may incur charges.
- **Instance lifecycle:** Common states include pending, running, stopping/stopped, shutting-down, and terminated. Stop/start generally preserves EBS-backed data but may change an auto-assigned public IPv4 address. Termination ends the instance; EBS deletion behavior depends on volume configuration.

## Common use cases

- Host a web application, API, or development/test environment.
- Run batch processing, build agents, or scheduled jobs.
- Operate self-managed software that requires operating-system control.
- Run a bastion or administrative host only when a managed access option is not suitable.
- Support legacy applications while planning modernization.

## Operational reminders

Use IAM roles for instance credentials rather than placing access keys on disk. Keep operating systems patched, use Systems Manager or another approved management path, restrict inbound rules, encrypt storage, monitor the instance, and stop or terminate unused resources.
