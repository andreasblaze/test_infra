data "aws_ami" "amazon_linux" {
  most_recent = true

    filter {
    name   = "Amazon Linux 2"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220426.0-x86_64-gp2"]
  }

}