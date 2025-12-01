variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "terraform-ec2-instance"
}

variable "os_type" {
  description = "Operating system type for the EC2 instance"
  type        = string
  default     = "amazon-linux"

  validation {
    condition     = contains(["ubuntu", "amazon-linux", "redhat-linux"], var.os_type)
    error_message = "The os_type must be one of: ubuntu, amazon-linux, or redhat-linux."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"

  validation {
    condition     = can(regex("^[a-z][0-9]+[a-z]*\\.[a-z0-9]+$", var.instance_type))
    error_message = "The instance_type must be a valid EC2 instance type (e.g., t2.micro, t3.small, m5.large)."
  }
}

variable "vpc_id" {
  description = "VPC ID where the instance will be launched. If not provided, uses the default VPC."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be launched. If not provided, uses the first available subnet in the VPC."
  type        = string
  default     = null
}

variable "key_name" {
  description = "Key pair name for SSH access to the instance"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = true
}

variable "root_volume_size" {
  description = "Size of the root EBS volume in GB"
  type        = number
  default     = 8

  validation {
    condition     = var.root_volume_size >= 8 && var.root_volume_size <= 16384
    error_message = "The root_volume_size must be between 8 and 16384 GB."
  }
}

variable "root_volume_type" {
  description = "Type of root EBS volume"
  type        = string
  default     = "gp3"

  validation {
    condition     = contains(["gp2", "gp3", "io1", "io2", "st1", "sc1"], var.root_volume_type)
    error_message = "The root_volume_type must be one of: gp2, gp3, io1, io2, st1, or sc1."
  }
}

variable "enable_monitoring" {
  description = "Enable detailed monitoring for the instance"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to apply to the EC2 instance"
  type        = map(string)
  default     = {}
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the instance. If not provided, a default security group will be created."
  type        = list(string)
  default     = null
}

variable "create_security_group" {
  description = "Whether to create a security group for the instance"
  type        = bool
  default     = true
}

variable "allowed_ssh_cidr_blocks" {
  description = "List of CIDR blocks allowed to SSH to the instance (only used if create_security_group is true)"
  type        = list(string)
  default     = ["0.0.0.0/0"]

  validation {
    condition     = alltrue([for cidr in var.allowed_ssh_cidr_blocks : can(cidrhost(cidr, 0))])
    error_message = "All elements in allowed_ssh_cidr_blocks must be valid CIDR blocks."
  }
}
