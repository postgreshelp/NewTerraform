resource "aws_internet_gateway" "lab03_igw" {
  vpc_id = aws_vpc.lab03_vpc.id

  tags = {
    Name = "LAB03-IGW"
  }
}

resource "aws_subnet" "lab03_public_subnet" {
  vpc_id                  = aws_vpc.lab03_vpc.id
  cidr_block              = "10.30.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "LAB03-Public-Subnet"
  }
}

resource "aws_subnet" "lab03_test_subnet" {
  vpc_id                  = aws_vpc.lab03_vpc.id
  cidr_block              = "10.30.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "LAB03-TEST-Public-Subnet"
  }
}

resource "aws_subnet" "lab03_prod_subnet" {
  vpc_id                  = aws_vpc.lab03_vpc.id
  cidr_block              = "10.30.3.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "LAB03-PROD-Public-Subnet"
  }
}

resource "aws_route_table" "lab03_public_rt" {
  vpc_id = aws_vpc.lab03_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab03_igw.id
  }

  tags = {
    Name = "LAB03-Public-RT"
  }
}

resource "aws_route_table_association" "lab03_public_rta" {
  subnet_id      = aws_subnet.lab03_public_subnet.id
  route_table_id = aws_route_table.lab03_public_rt.id
}

resource "aws_route_table_association" "lab03_test_rta" {
  subnet_id      = aws_subnet.lab03_test_subnet.id
  route_table_id = aws_route_table.lab03_public_rt.id
}

resource "aws_route_table_association" "lab03_prod_rta" {
  subnet_id      = aws_subnet.lab03_prod_subnet.id
  route_table_id = aws_route_table.lab03_public_rt.id
}

resource "aws_security_group" "lab03_sg" {
  name   = "LAB03-SG"
  vpc_id = aws_vpc.lab03_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "LAB03-SG"
  }
}