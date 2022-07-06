resource "aws_instance" "hrk_01" {
    ami           = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.hrk_SG.id]
    key_name      = "hrk-key"

    tags = {
    Name = "tf_hrk_infra"
  }
}

resource "aws_eip" "eip" {
  vpc = true
  instance         = aws_instance.hrk_01.id
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