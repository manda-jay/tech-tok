resource "aws_internet_gateway" "amanda-example-igw" {
  vpc_id = aws_vpc.amanda-example-vpc.id
}