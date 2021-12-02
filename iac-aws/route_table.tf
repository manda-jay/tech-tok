resource "aws_route_table" "amanda-example-route-table_2" {
  vpc_id = aws_vpc.amanda-example-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.amanda-example-igw.id
  }

}
resource "aws_route_table_association" "amanda-example-route-table-association" {
  provider = aws
  route_table_id = aws_route_table.amanda-example-route-table.id
  subnet_id = aws_subnet.amanda-example-subnet.id
}