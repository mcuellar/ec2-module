output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "instance_arn" {
  description = "The ARN of the EC2 instance"
  value       = aws_instance.this.arn
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.this.public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.this.private_ip
}

output "instance_public_dns" {
  description = "The public DNS name of the EC2 instance"
  value       = aws_instance.this.public_dns
}

output "instance_private_dns" {
  description = "The private DNS name of the EC2 instance"
  value       = aws_instance.this.private_dns
}

output "ami_id" {
  description = "The AMI ID used for the EC2 instance"
  value       = data.aws_ami.selected.id
}

output "ami_name" {
  description = "The name of the AMI used for the EC2 instance"
  value       = data.aws_ami.selected.name
}

output "security_group_id" {
  description = "The ID of the security group created for the instance (if applicable)"
  value       = var.create_security_group && var.security_group_ids == null ? aws_security_group.instance[0].id : null
}

output "vpc_id" {
  description = "The VPC ID where the instance was launched"
  value       = local.vpc_id
}

output "subnet_id" {
  description = "The subnet ID where the instance was launched"
  value       = local.subnet_id
}
