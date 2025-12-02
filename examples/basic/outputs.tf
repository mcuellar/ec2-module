output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.ec2_instance.instance_id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = module.ec2_instance.instance_public_ip
}

output "instance_public_dns" {
  description = "The public DNS name of the EC2 instance"
  value       = module.ec2_instance.instance_public_dns
}

output "ami_id" {
  description = "The AMI ID used for the instance"
  value       = module.ec2_instance.ami_id
}

output "ami_name" {
  description = "The name of the AMI used"
  value       = module.ec2_instance.ami_name
}
