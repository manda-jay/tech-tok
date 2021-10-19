resource "aws_security_group" "aws_example_instance" {
  name = "aws-example-sg"
  ingress {

    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
