module "ec2_instance" {
  source = "../.."

  instance_name = "basic-example-instance"
  os_type       = "amazon-linux"
  instance_type = "t2.micro"

  tags = {
    Environment = "development"
    Example     = "basic"
  }
}
