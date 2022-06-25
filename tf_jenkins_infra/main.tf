resource "aws_instance" "Jenkins" {
    ami           = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"

    tags = {
    Name = "tf_jenkins_infra"
  }
}