resource "aws_instance" "Jenkins" {
    ami                    = data.aws_ami.amazon_linux.id
    instance_type          = "t3.micro"
    vpc_security_group_ids = [aws_security_group.Jenkins_SG.id]
    key_name      = "jenkins-key"

    tags = {
    Name = "tf_jenkins_infra"
  }
}

resource "tls_private_key" "Jenkins_RSA" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins-key"
  public_key = tls_private_key.Jenkins_RSA.public_key_openssh
}

resource "local_sensitive_file" "Jenkins_key" {
    content  = tls_private_key.Jenkins_RSA.private_key_pem
    filename = "jenkins-key"
}

resource "aws_security_group" "Jenkins_SG" {
  name        = "Jenkins-SG"
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
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
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
    Name = "Jenkins http/s"
  }
}