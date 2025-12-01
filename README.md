# AWS EC2 Terraform Module

A flexible and reusable Terraform module to provision AWS EC2 instances with support for multiple operating systems and customizable configurations.

## Features

- **Multiple OS Support**: Automatically provisions instances with Ubuntu, Amazon Linux, or Red Hat Linux
- **Smart AMI Lookup**: Uses data sources to fetch the latest AMIs from AWS Marketplace
- **VPC Flexibility**: Works with default VPC or custom VPC configurations
- **Input Validation**: Comprehensive validation for all input parameters
- **Security**: Optional security group creation with configurable SSH access
- **Customizable**: Support for instance type, volume configuration, monitoring, and more

## Usage

### Basic Example

```hcl
module "ec2_instance" {
  source = "github.com/mcuellar/ec2-module"

  instance_name = "my-instance"
  os_type       = "amazon-linux"
  instance_type = "t2.micro"

  tags = {
    Environment = "production"
  }
}
```

### Custom VPC Example

```hcl
module "ec2_instance" {
  source = "github.com/mcuellar/ec2-module"

  instance_name = "my-instance"
  os_type       = "ubuntu"
  instance_type = "t3.small"

  vpc_id    = "vpc-1234567890abcdef0"
  subnet_id = "subnet-1234567890abcdef0"

  allowed_ssh_cidr_blocks = ["10.0.0.0/16"]

  tags = {
    Environment = "production"
  }
}
```

### Different Operating Systems

```hcl
# Ubuntu instance
module "ec2_ubuntu" {
  source = "github.com/mcuellar/ec2-module"

  instance_name = "ubuntu-server"
  os_type       = "ubuntu"
  instance_type = "t2.micro"
}

# Amazon Linux instance
module "ec2_amazon_linux" {
  source = "github.com/mcuellar/ec2-module"

  instance_name = "amazon-linux-server"
  os_type       = "amazon-linux"
  instance_type = "t2.micro"
}

# Red Hat Linux instance
module "ec2_redhat" {
  source = "github.com/mcuellar/ec2-module"

  instance_name = "redhat-server"
  os_type       = "redhat-linux"
  instance_type = "t2.micro"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0 |

## Inputs

| Name | Description | Type | Default | Required | Validation |
|------|-------------|------|---------|----------|------------|
| instance_name | Name tag for the EC2 instance | `string` | `"terraform-ec2-instance"` | no | - |
| os_type | Operating system type (ubuntu, amazon-linux, or redhat-linux) | `string` | `"amazon-linux"` | no | Must be one of: ubuntu, amazon-linux, redhat-linux |
| instance_type | EC2 instance type | `string` | `"t2.micro"` | no | Must be a valid EC2 instance type |
| vpc_id | VPC ID where the instance will be launched | `string` | `null` (uses default VPC) | no | - |
| subnet_id | Subnet ID where the instance will be launched | `string` | `null` (uses first available) | no | - |
| key_name | Key pair name for SSH access | `string` | `null` | no | - |
| associate_public_ip_address | Whether to associate a public IP address | `bool` | `true` | no | - |
| root_volume_size | Size of the root EBS volume in GB | `number` | `8` | no | Must be between 8 and 16384 |
| root_volume_type | Type of root EBS volume | `string` | `"gp3"` | no | Must be one of: gp2, gp3, io1, io2, st1, sc1 |
| enable_monitoring | Enable detailed monitoring | `bool` | `false` | no | - |
| tags | Additional tags to apply | `map(string)` | `{}` | no | - |
| security_group_ids | List of security group IDs | `list(string)` | `null` | no | - |
| create_security_group | Whether to create a security group | `bool` | `true` | no | - |
| allowed_ssh_cidr_blocks | List of CIDR blocks allowed to SSH | `list(string)` | `["0.0.0.0/0"]` | no | Must be valid CIDR blocks |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | The ID of the EC2 instance |
| instance_arn | The ARN of the EC2 instance |
| instance_public_ip | The public IP address of the EC2 instance |
| instance_private_ip | The private IP address of the EC2 instance |
| instance_public_dns | The public DNS name of the EC2 instance |
| instance_private_dns | The private DNS name of the EC2 instance |
| ami_id | The AMI ID used for the EC2 instance |
| ami_name | The name of the AMI used for the EC2 instance |
| security_group_id | The ID of the security group (if created) |
| vpc_id | The VPC ID where the instance was launched |
| subnet_id | The subnet ID where the instance was launched |

## Operating System Details

### Ubuntu
- **Owner**: Canonical (099720109477)
- **AMI Pattern**: ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*
- **Version**: Ubuntu 22.04 LTS (Jammy Jellyfish)

### Amazon Linux
- **Owner**: Amazon
- **AMI Pattern**: amzn2-ami-hvm-*-x86_64-gp2
- **Version**: Amazon Linux 2

### Red Hat Linux
- **Owner**: Red Hat (309956199498)
- **AMI Pattern**: RHEL-9.*_HVM-*-x86_64-*
- **Version**: Red Hat Enterprise Linux 9

## Examples

The `examples/` directory contains sample implementations:

- **[basic](examples/basic/)**: Simple usage with default VPC and Amazon Linux
- **[custom-vpc](examples/custom-vpc/)**: Usage with custom VPC, subnet, and Ubuntu
- **[different-os](examples/different-os/)**: Multiple instances with different operating systems

## Security Considerations

- By default, the module creates a security group allowing SSH access from `0.0.0.0/0`. In production environments, restrict this to specific IP ranges using the `allowed_ssh_cidr_blocks` variable.
- Consider using existing security groups by setting `create_security_group = false` and providing `security_group_ids`.
- Use key pairs for SSH access by setting the `key_name` variable.

## License

This module is provided as-is for use in your Terraform projects.

## Author

mcuellar
