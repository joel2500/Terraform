resource "aws_instance" "my_vm" {
  count         = 3
  ami           = "ami-0e670eb768a5fc3d4"
  instance_type = "t2.micro"
  key_name      = "kube"

  tags = {
    Name = "My-EC2-instance-${count.index + 1}",
  }
}
output "instance_ip" {
  value = [for instance in aws_instance.my_vm : instance.public_ip]
}
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
resource "aws_security_group" "allow_ssh" {
  name        = "allow-ssh"
  description = "Allow SSH traffic from all IP addresses"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}