# Ubuntu instance outputs
output "ubuntu_instance_id" {
  description = "The ID of the Ubuntu EC2 instance"
  value       = module.ec2_ubuntu.instance_id
}

output "ubuntu_instance_public_ip" {
  description = "The public IP address of the Ubuntu EC2 instance"
  value       = module.ec2_ubuntu.instance_public_ip
}

output "ubuntu_ami_name" {
  description = "The name of the Ubuntu AMI used"
  value       = module.ec2_ubuntu.ami_name
}

# Amazon Linux instance outputs
output "amazon_linux_instance_id" {
  description = "The ID of the Amazon Linux EC2 instance"
  value       = module.ec2_amazon_linux.instance_id
}

output "amazon_linux_instance_public_ip" {
  description = "The public IP address of the Amazon Linux EC2 instance"
  value       = module.ec2_amazon_linux.instance_public_ip
}

output "amazon_linux_ami_name" {
  description = "The name of the Amazon Linux AMI used"
  value       = module.ec2_amazon_linux.ami_name
}

# Red Hat Linux instance outputs
output "redhat_instance_id" {
  description = "The ID of the Red Hat Linux EC2 instance"
  value       = module.ec2_redhat.instance_id
}

output "redhat_instance_public_ip" {
  description = "The public IP address of the Red Hat Linux EC2 instance"
  value       = module.ec2_redhat.instance_public_ip
}

output "redhat_ami_name" {
  description = "The name of the Red Hat Linux AMI used"
  value       = module.ec2_redhat.ami_name
}
