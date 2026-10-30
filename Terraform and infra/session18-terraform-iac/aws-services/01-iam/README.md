# IAM - Identity and Access Management

## What is IAM?

AWS Identity and Access Management (IAM) controls authentication (who or what can sign in) and authorization (which AWS actions are allowed on which resources). IAM is a global AWS service: identities and policies are used across regions.

## Core concepts

- **Users:** An identity for a person or legacy workload that needs long-lived credentials. Prefer federation or IAM roles for people and workloads instead of creating access keys.
- **Groups:** Collections of IAM users. Attach permissions to a group to manage common access consistently. Groups cannot contain other groups and cannot be assumed like roles.
- **Roles:** Identities with permissions that are assumed temporarily by a trusted principal, such as a federated user, an EC2 instance, or another AWS account. Roles avoid distributing long-lived credentials.
- **Policies:** JSON documents that define permissions. Identity-based policies attach to users, groups, or roles. Resource-based policies attach to resources such as S3 buckets. A role trust policy defines who may assume that role.
- **Permissions:** The allowed or denied actions against resources, optionally under conditions. AWS evaluates applicable policies together; an explicit deny overrides an allow. Permissions boundaries, service control policies, and session policies can further limit effective permissions.
- **Least privilege:** Grant only the actions and resources needed for a task, for only as long as needed. Start narrow, observe access requirements, and expand deliberately rather than granting broad administrator access.

## IAM best practices

1. Require multi-factor authentication (MFA), especially for privileged users and the root user.
2. Protect the root user; do not use it for everyday work and do not create root access keys.
3. Prefer IAM Identity Center/federation for workforce access and IAM roles with temporary credentials for AWS workloads.
4. Avoid embedding access keys in source code, Terraform files, images, or logs. Rotate or revoke credentials that may have been exposed.
5. Use groups and roles to assign job-based permissions; avoid attaching broad policies directly to individual users.
6. Apply least privilege, scope resources and actions, and add conditions where appropriate.
7. Review access with IAM Access Analyzer and credential reports; remove unused identities, permissions, and keys.
8. Use separate accounts and organizational guardrails for production and non-production environments.

## Common use cases

- Give developers scoped access to development resources without production administration.
- Let an EC2 application read a specific S3 bucket by attaching an instance role.
- Allow a CI/CD system to assume a deployment role for a limited duration.
- Federate employee identities from a corporate identity provider.
- Grant a trusted external AWS account time-limited, auditable access through role assumption.

## Remember

Authentication alone does not grant access. A valid identity still needs an applicable allow, and an explicit deny or organization-level control may prevent the action.
