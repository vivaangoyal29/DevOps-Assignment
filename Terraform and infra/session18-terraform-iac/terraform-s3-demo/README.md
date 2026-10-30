# Terraform S3 Demo

This project uses Terraform to provision an Amazon S3 bucket and its baseline security settings. The bucket name combines a configurable prefix with the AWS account ID, which helps make the name globally unique.

## What it provisions

- One S3 bucket
- An S3 public access block that disables public ACLs and policies
- Default server-side encryption using AES-256

The Terraform configuration also exposes the bucket name, ARN, and AWS region as outputs.

## Project structure

```text
terraform-s3-demo/
├── main.tf           # S3 bucket and security configuration
├── provider.tf       # Terraform and AWS provider requirements
├── variables.tf      # Region and bucket-name prefix
├── outputs.tf        # Bucket name, ARN, and region
├── terraform.tfvars  # Demo values (no AWS credentials)
└── screenshots/      # Execution evidence
```

## Requirements

- Terraform CLI 1.6 or newer
- AWS CLI v2
- An AWS account with permission to create, inspect, and delete the S3 resources in this project
- AWS credentials configured through an approved method, such as an AWS CLI profile or IAM Identity Center

Confirm the AWS identity and account before provisioning:

```powershell
aws sts get-caller-identity
```

For an IAM Identity Center profile:

```powershell
aws sso login --profile YOUR_PROFILE
$env:AWS_PROFILE = "YOUR_PROFILE"
aws sts get-caller-identity
```

## Usage

From the repository root, enter the project directory and run the Terraform workflow:

```powershell
Set-Location ".\Terraform and infra\session18-terraform-iac\terraform-s3-demo"
terraform init
terraform fmt
terraform validate
terraform plan
```

Review the plan, including the selected AWS account, region, bucket name, and resources. Apply only when the proposed changes are expected:

```powershell
terraform apply
```

Terraform asks for confirmation before creating the resources. The bucket name, ARN, and region are available after apply:

```powershell
terraform show
terraform output
terraform output -raw bucket_name
```

The AWS CLI can be used to verify the bucket and its security settings:

```powershell
$bucket = terraform output -raw bucket_name
aws s3api head-bucket --bucket $bucket
aws s3api get-public-access-block --bucket $bucket
aws s3api get-bucket-encryption --bucket $bucket
```

## Cleanup

This demo can incur AWS charges. Do not store important data in the bucket. Terraform does not delete bucket objects automatically, so remove any objects created for this demo before destroying the resources.

Review the destroy plan, then confirm the operation:

```powershell
terraform plan -destroy
terraform destroy
```

The local Terraform state and provider files should remain private. They are excluded by `.gitignore`; do not commit or share the state file, which can include infrastructure details.

## Screenshots

The screenshots below document a successful run of the project.

| Stage | Evidence |
|---|---|
| Initialization | ![Terraform initialization](screenshots/Screenshot%202026-10-30%20052657.png) |
| Formatting and validation | ![Terraform format and validate](screenshots/Screenshot%202026-10-30%20052716.png) |
| Plan | ![Terraform plan](screenshots/Screenshot%202026-10-30%20052736.png) |
| Apply | ![Terraform apply](screenshots/Screenshot%202026-10-30%20052831.png) |
| State inspection | ![Terraform state inspection](screenshots/Screenshot%202026-10-30%20052922.png) |
| Outputs | ![Terraform outputs](screenshots/Screenshot%202026-10-30%20052931.png) |
| AWS verification | ![AWS CLI verification of the bucket and security settings](screenshots/Screenshot%202026-10-30%20052957.png) |
| Destroy | ![Terraform destroy](screenshots/Screenshot%202026-10-30%20053126.png) |

## Troubleshooting

- **Bucket name is unavailable:** Change `bucket_name_prefix` in `terraform.tfvars`, then run `terraform plan` again.
- **Credentials are missing or expired:** Re-authenticate with the configured AWS profile and confirm the identity with `aws sts get-caller-identity`.
- **Access is denied:** Check with an AWS administrator that the identity has the permissions required for the S3 resources. Do not use administrator credentials to bypass an access denial.
- **Destroy fails because the bucket is not empty:** Remove only the objects created for this demo, then run `terraform destroy` again.
