resource "aws_instance" "my_vm" {
  count         = 1
  ami           = "ami-0e670eb768a5fc3d4"
  instance_type = "t2.micro"
  key_name      = "kube"

  tags = {
    Name      = "My-EC2-instance-${count.index + 1}",
    Bootstrap = "true",
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install python",
      "sudo yum install python-pip",
      "sudo yum update -y",
      "sudo yum install -y epel-release",
      "sudo yum install -y ansible",
    ]
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "ap-south-1"
}

output "instance_ip" {
  value = [for instance in aws_instance.my_vm : instance.public_ip]
}