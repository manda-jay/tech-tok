resource "aws_subnet" "amanda-example-subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.amanda-example-vpc.id
    map_public_ip_on_launch = false
    }