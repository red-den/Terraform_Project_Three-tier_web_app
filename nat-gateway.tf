
#7. Create Elastic IP Address (EIP 1) & Create Elastic IP Address (EIP 2)
# terraform aws allocate elastic ip

resource "aws_eip" "eip_for_nat_gateway_1" {
  vpc = true

  tags = {
    Name = "EIP 1"
  }

}

resource "aws_eip" "eip_for_nat_gateway_2" {
  vpc = true

  tags = {
    Name = "EIP 2"
  }

}

#8. Create NAT gateway for Public Subnet 1 & Public Subnet 2
resource "aws_nat_gateway" "nat_gateway_1" {
  allocation_id = aws_eip.eip_for_nat_gateway_1.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "NAT Gateway Public 1"
  }

}

resource "aws_nat_gateway" "nat_gateway_2" {
  allocation_id = aws_eip.eip_for_nat_gateway_2.id
  subnet_id     = aws_subnet.public_subnet_2.id

  tags = {
    Name = "NAT Gateway Public 2"
  }

}

#9. Create Private Route Table 1 and Add route through NAT Gateway 1 in Public 1
resource "aws_route_table" "private_route_table_1" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1.id
  }
  tags = {
    Name = "Private Route Table 1"
  }

}

#Associate Private Route Table 1 to Private Subnet App 1 and Private Subnet Db 1
resource "aws_route_table_association" "private_subnet_app_1_route_table_association" {
  subnet_id      = aws_subnet.private_subnet_app_1.id
  route_table_id = aws_route_table.private_route_table_1.id

}

resource "aws_route_table_association" "private_subnet_db_1_route_table_association" {
  subnet_id      = aws_subnet.private_subnet_db_1.id
  route_table_id = aws_route_table.private_route_table_1.id

}

#10. Create Private Route Table 2 and Add route through NAT Gateway 2 in Public 2
resource "aws_route_table" "private_route_table_2" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_2.id
  }
  tags = {
    Name = "Private Route Table 2"
  }

}
#Associate Private Route Table 2 to Private Subnet App 2 and Private Subnet Db 2
resource "aws_route_table_association" "private_subnet_app_2_route_table_association" {
  subnet_id      = aws_subnet.private_subnet_app_2.id
  route_table_id = aws_route_table.private_route_table_2.id

}

resource "aws_route_table_association" "private_subnet_db_2_route_table_association" {
  subnet_id      = aws_subnet.private_subnet_db_2.id
  route_table_id = aws_route_table.private_route_table_2.id

}


