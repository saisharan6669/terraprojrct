provider "aws" {
region = "ap-south-1"
access_key = "AKIA34X4X3ITFEE6HAFO"
secret_key = "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"
}

resource "aws_instance" "one" {
ami = "ami-05afd67c4a44cc983"
instance_type ="t2.micro"
vpc_security_group_ids = [aws_security_group.three.id]
availability_zone = "ap-south-1a"
user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by saisharan server-1" > /var/www/html/index.html
EOF
tags ={
Name = "server-1"
}
}
resource "aws_instance" "two" {
  ami             = "ami-0d81306eddc614a45"
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "ap-south-1b"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by saisharan server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "server-2"
  }
}

resource "aws_security_group" "three" {
  name = "elbsai"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_s3_bucket" "four" {
  bucket ="saisharan123456"
}

resource "aws_iam_user" "nine" {
name = "nani6669"
}
resource "aws_ebs_volume" "six" {
 availability_zone = "ap-south-1b"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
