# S3 - Simple Storage Service

## What is S3?

Amazon Simple Storage Service (S3) is a regional object-storage service designed to store and retrieve data through buckets and objects. It is not a mounted block disk or a traditional hierarchical filesystem, although prefixes make object keys appear folder-like in tools.

## Core concepts

- **Buckets:** Containers for objects. Bucket names are globally unique within an AWS partition, and a bucket is created in a selected region. Access is private by default; policies and settings govern access.
- **Objects:** Data stored with an object key, value, metadata, and (when versioning is enabled) a version ID. Object size and API behavior differ from block storage.
- **Storage classes:** Options trade access frequency, retrieval latency, resilience, and cost. Examples include S3 Standard, Intelligent-Tiering, Standard-IA, One Zone-IA, and Glacier storage classes. Some infrequent-access and archive tiers have retrieval charges, minimum storage durations, or restore delays; choose based on access patterns.
- **Versioning:** Keeps multiple versions of an object key to help recover from overwrites or deletions. It is disabled by default; enabling it changes delete semantics and does not by itself protect against every form of account compromise.
- **Lifecycle policies:** Rules can transition eligible objects between storage classes or expire current/noncurrent versions and incomplete multipart uploads. Review retention requirements before configuring expiration.
- **Encryption:** S3 encrypts new object uploads at rest by default using server-side encryption. Depending on the use case, use SSE-S3 or AWS KMS keys (SSE-KMS); protect key permissions and understand request quotas/costs.
- **Bucket policies:** Resource-based JSON policies that grant or deny access to bucket resources. A policy can enforce conditions such as TLS use, but it works alongside IAM policies, access points, and account-level controls. Block Public Access should remain enabled unless public access is explicitly required and reviewed.

## Common use cases

- Store backups, logs, documents, static website assets, and data lake objects.
- Exchange artifacts between build and deployment workflows.
- Retain application uploads with lifecycle transitions to lower-cost storage.
- Provide durable object storage for analytics and machine-learning pipelines.

## Secure-by-default checklist

Block public access, grant least-privilege access through IAM roles and policies, require TLS, enable versioning where recovery needs justify it, configure retention/lifecycle deliberately, and monitor access. Use replication or backup strategies for recovery requirements beyond a single bucket.
