resource "aws_instance" "Jenkins" {
    ami           = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"
    //key_name      = "jenkins-key"

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