terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

}

provider "aws" {
  region = "us-east-1"
}



#Start Here:

#1. Create VPC
resource "aws_vpc" "project_vpc" {
  cidr_block = var.vpc_cidr #used variable. Look for the value in the variable file

  tags = {
    Name = "Project-VPC"
  }
}


#2. Create Internet Gateway and attach it to VPC

resource "aws_internet_gateway" "project_igw" {
  vpc_id = aws_vpc.project_vpc.id

  tags = {
    Name = "Project-IGW"
  }
}

#3. Create two public subnets in separate Availability Zones
#Replace the CIDR blocks and availability zones as needed
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.project_vpc.id
  cidr_block              = var.public-subnet1_cidr # Replace with your desired subnet CIDR block. #used variable. Look for the value in the variable file
  availability_zone       = "us-east-1a"            # Replace with your desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.project_vpc.id
  cidr_block              = var.public-subnet2_cidr # Replace with your desired subnet CIDR block. #used variable. Look for the value in the variable file
  availability_zone       = "us-east-1b"            # Replace with your desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-2"
  }
}

#4. Create Route Table and add public route

#PUBLIC
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project_igw.id
  }
  tags = {
    Name = "Public Route Table"
  }

}

#5. Associate Public Route Table to Public Subnets
resource "aws_route_table_association" "public-subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public-subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}




#6. Create four private subnets (app1, app2, db1, db2)
# Replace the CIDR blocks and availability zones as needed
resource "aws_subnet" "private_subnet_app_1" {
  vpc_id                  = aws_vpc.project_vpc.id
  cidr_block              = var.private-app1_cidr # used variable. Look for the value in the variable file
  availability_zone       = "us-east-1a"          # Replace with your desired availability zone
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-Subnet-App1"
  }
}

resource "aws_subnet" "private_subnet_app_2" {
  vpc_id                  = aws_vpc.project_vpc.id
  cidr_block              = var.private-app2_cidr # used variable. Look for the value in the variable file
  availability_zone       = "us-east-1b"          # Replace with your desired availability zone
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-Subnet-App2"
  }
}

resource "aws_subnet" "private_subnet_db_1" {
  vpc_id                  = aws_vpc.project_vpc.id
  cidr_block              = var.private-db1_cidr # used variable. Look for the value in the variable file
  availability_zone       = "us-east-1a"         # Replace with your desired availability zone
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-Subnet-db1"
  }
}

resource "aws_subnet" "private_subnet_db_2" {
  vpc_id                  = aws_vpc.project_vpc.id
  cidr_block              = var.private-db2_cidr # used variable. Look for the value in the variable file
  availability_zone       = "us-east-1b"         # Replace with your desired availability zone
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-Subnet-db2"
  }
}


