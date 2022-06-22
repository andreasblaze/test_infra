resource "aws_instance" "hrk_01" {
    ami           = "ami-08bdc08970fcbd34a"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.hrk_SG.id]
    //key_name = "hrk-key"
}

resource "tls_private_key" "hrk_RSA" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "hrk_key" {
  key_name   = "hrk-key"
  public_key = tls_private_key.hrk_RSA.public_key_openssh
}

resource "local_sensitive_file" "hrk_key" {
    content  = tls_private_key.hrk_RSA.private_key_pem
    filename = "hrk-key"
}

resource "aws_security_group" "hrk_SG" {
  name        = "hrk-SG"
  description = "for testing"

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTPS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "http/s"
  }
}