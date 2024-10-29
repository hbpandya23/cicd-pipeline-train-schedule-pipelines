terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}
resource "aws_security_group" "my-test-sg" {
  name = "my-test-sg"
  tags = {
    "Name" = "my-test-sg"
  }
  ingress  {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

resource "aws_instance" "tf-my-ec2" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  tags = {
    "Name" = "tf-ec2-instance"
  }
  key_name = "my-firstkey"
  vpc_security_group_ids = [aws_security_group.my-test-sg.id]
}

resource "aws_s3_bucket" "new-my-bucket-00023" {
    bucket = "my-new-uniquename-bucket-085"
}

output "tf-ec2-public-ip" {
  value = aws_instance.tf-my-ec2.public_ip
}
