resource "aws_instance" "app" {
  ami           = "ami-0c94855ba95c574c8"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_id
  vpc_security_group_ids = [var.web_sg_id]

  tags = {
    Name = "EC2-Instance"
  }
}
