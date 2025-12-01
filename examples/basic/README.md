# Basic Example - Using Default VPC and Amazon Linux

This example demonstrates the simplest usage of the EC2 module with default settings.

## Usage

```bash
terraform init
terraform plan
terraform apply
```

## What This Example Does

- Provisions an EC2 instance in the default VPC
- Uses Amazon Linux 2 as the operating system
- Uses t2.micro instance type
- Creates a security group allowing SSH from anywhere (0.0.0.0/0)
- Associates a public IP address

## Cleanup

```bash
terraform destroy
```
