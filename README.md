# Terraform_Project_Three-tier_web_app

mai.tf
1. Create VPC
2. Create IGW and attach to VPC
3. Create Public Subnets to different Availability zone
   (us-east-1a) Public Subnet 1
   (us-east-1b) Public Subnet 2
4. Create Route Table and add public route (Internet)
5. Associate the two public subnets to public route for both to have internet

6. Create Private Subnets:
   (us-east-1a) Private Subnet App 1
   (us-east-1b) Private Subnet App 2
   (us-east-1a) Private Subnet Db 1
   (us-east-1b) Private Subnet Db 2

nat-gateway.tf
7. Create Elastic IP for NAT Gateway
  EIP 1
  EIP 2
  
Sample Code:

resource "aws_eip" "eip_for_nat_gateway_1" {
  vpc = true

  tags = {
    Name = "EIP 1"
  }

}
  
8. Craete NAT Gateway for Public Subnet 1 and 2
  Nat Gateway Public 1
  Nat Gateway Public 2

Sample Code:

resource "aws_nat_gateway" "nat_gateway_1" {
  allocation_id = aws_eip.eip_for_nat_gateway_1.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "NAT Gateway Public 1"
  }

}


10. Create Private Route Table 1 and 2
    Route throuth NAT Gateway Public 1 and 2 (For Priavate subnets to have Internet thorugh Public NAT gateway)

Sample Code:

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

11. Associate Private Route table to the private subnets

Sample Code:

resource "aws_route_table_association" "private_subnet_app_1_route_table_association" {
  subnet_id      = aws_subnet.private_subnet_app_1.id
  route_table_id = aws_route_table.private_route_table_1.id

}


