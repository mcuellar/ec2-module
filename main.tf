# Data source to get the default VPC if not provided
data "aws_vpc" "default" {
  count   = var.vpc_id == null ? 1 : 0
  default = true
}

# Data source to get VPC details if vpc_id is provided
data "aws_vpc" "selected" {
  count = var.vpc_id != null ? 1 : 0
  id    = var.vpc_id
}

# Get the first available subnet in the VPC if not provided
data "aws_subnets" "available" {
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
}

# Local values
locals {
  vpc_id    = var.vpc_id != null ? var.vpc_id : try(data.aws_vpc.default[0].id, null)
  subnet_id = var.subnet_id != null ? var.subnet_id : try(data.aws_subnets.available.ids[0], null)

  # AMI filters based on OS type
  ami_filters = {
    ubuntu = {
      owners = ["099720109477"] # Canonical
      filter = {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
      }
    }
    amazon-linux = {
      owners = ["amazon"]
      filter = {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
      }
    }
    redhat-linux = {
      owners = ["309956199498"] # Red Hat
      filter = {
        name   = "name"
        values = ["RHEL-9.*_HVM-*-x86_64-*"]
      }
    }
  }

  common_tags = merge(
    {
      Name      = var.instance_name
      ManagedBy = "Terraform"
      OSType    = var.os_type
    },
    var.tags
  )
}

# Data source to lookup the latest AMI based on OS type
data "aws_ami" "selected" {
  most_recent = true
  owners      = local.ami_filters[var.os_type].owners

  filter {
    name   = local.ami_filters[var.os_type].filter.name
    values = local.ami_filters[var.os_type].filter.values
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Security group for the EC2 instance (if create_security_group is true)
resource "aws_security_group" "instance" {
  count       = var.create_security_group && var.security_group_ids == null ? 1 : 0
  name        = "${var.instance_name}-sg"
  description = "Security group for ${var.instance_name}"
  vpc_id      = local.vpc_id

  ingress {
    description = "SSH from allowed CIDR blocks"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr_blocks
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.instance_name}-sg"
    }
  )
}

# EC2 Instance
resource "aws_instance" "this" {
  ami           = data.aws_ami.selected.id
  instance_type = var.instance_type
  subnet_id     = local.subnet_id
  key_name      = var.key_name

  vpc_security_group_ids = var.security_group_ids != null ? var.security_group_ids : (
    var.create_security_group ? [aws_security_group.instance[0].id] : null
  )

  associate_public_ip_address = var.associate_public_ip_address
  monitoring                  = var.enable_monitoring

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true

    tags = merge(
      local.common_tags,
      {
        Name = "${var.instance_name}-root-volume"
      }
    )
  }

  tags = local.common_tags

  lifecycle {
    create_before_destroy = false

    precondition {
      condition     = var.create_security_group || var.security_group_ids != null
      error_message = "Either create_security_group must be true or security_group_ids must be provided."
    }
  }
}
