resource "aws_instance" "example" {
  ami                 = "ami-0220d79f3f480ecf5"
  instance_type       = "t3.micro"
  vpc_security_groups_ids = [aws_security_group.allow_tls.id]

  tags = {
    Name    = "terraform-state-demo"
    project = "Roboshop"
  }
}

resource "aws_security_group" "allow_tls" {
  Name        = "allow-all-terraform-changes"
  description = "allow all inbound and outbiund traffic"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "Allow-all-terraform"
  }
  lifecycle {
    create_before_destroy = true
  }
}