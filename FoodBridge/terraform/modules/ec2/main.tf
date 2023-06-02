# A basic EC2 module - please modify to your needs

resource "aws_instance" "app" {
  ami           = "ami-0c94855ba95c574c8"
  instance_type = "t2.micro"

  tags = {
    Name = "EC2-Instance"
  }
}

output "ec2_public_ip" {
  value = aws_instance.app.public_ip
}
