resource "aws_instance" "prometheus" {
    ami           = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.Prometheus_SG.id]
    key_name      = "prometheus-key"

    tags = {
    Name = "tf_prometheus_infra"
  }
}

resource "tls_private_key" "Prometheus_RSA" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "prometheus_key" {
  key_name   = "prometheus-key"
  public_key = tls_private_key.Prometheus_RSA.public_key_openssh
}

resource "local_sensitive_file" "prometheus_key" {
    content  = tls_private_key.Prometheus_RSA.private_key_pem
    filename = "prometheus-key"
}