# Custom VPC Example

This example demonstrates using the EC2 module with a custom VPC and subnet.

## Usage

```bash
terraform init
terraform plan
terraform apply
```

## What This Example Does

- Creates a custom VPC and subnet
- Provisions an EC2 instance in the custom VPC
- Uses Ubuntu 22.04 as the operating system
- Uses t3.small instance type
- Allows SSH access only from a specific CIDR block

## Cleanup

```bash
terraform destroy
```
