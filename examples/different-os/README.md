# Different Operating Systems Example

This example demonstrates using the EC2 module with different operating systems: Ubuntu, Amazon Linux, and Red Hat Linux.

## Usage

```bash
terraform init
terraform plan
terraform apply
```

## What This Example Does

- Provisions three EC2 instances, each with a different operating system:
  - Ubuntu 22.04 LTS
  - Amazon Linux 2
  - Red Hat Enterprise Linux 9
- Uses the default VPC
- Uses t2.micro instance type for all instances
- Creates separate security groups for each instance

## Cleanup

```bash
terraform destroy
```
