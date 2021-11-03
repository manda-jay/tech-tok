data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical: publisher of ubuntu
}

resource "aws_instance" "aws_example_ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.amanda-example-kp.key_name
  subnet_id              = aws_subnet.amanda-example-subnet.id
  vpc_security_group_ids = [aws_security_group.amanda_example_sg.id]

  user_data = <<-EOF
 #!/bin/bash
 echo "Hello, World" > index.html
 nohup busybox httpd -f -p 8080 &
 EOF

  tags = {
    Name = "amanda_example"
  }
}