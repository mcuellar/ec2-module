# Ubuntu EC2 instance
module "ec2_ubuntu" {
  source = "../.."

  instance_name = "ubuntu-instance"
  os_type       = "ubuntu"
  instance_type = "t2.micro"

  tags = {
    Environment = "development"
    Example     = "different-os"
    OS          = "Ubuntu"
  }
}

# Amazon Linux EC2 instance
module "ec2_amazon_linux" {
  source = "../.."

  instance_name = "amazon-linux-instance"
  os_type       = "amazon-linux"
  instance_type = "t2.micro"

  tags = {
    Environment = "development"
    Example     = "different-os"
    OS          = "Amazon-Linux"
  }
}

# Red Hat Linux EC2 instance
module "ec2_redhat" {
  source = "../.."

  instance_name = "redhat-linux-instance"
  os_type       = "redhat-linux"
  instance_type = "t2.micro"

  tags = {
    Environment = "development"
    Example     = "different-os"
    OS          = "RedHat-Linux"
  }
}
