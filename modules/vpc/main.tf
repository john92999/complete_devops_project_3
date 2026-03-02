resource "aws_vpc" "main_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "main_vpc"
    }
}

resource "aws_subnet" "subnet" {
    for_each = var.subnet
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = each.value.subnet_cidr_block
    availability_zone = each.value.subnet_availability_zone
    tags = {
        Name = each.value.subnet_names
    }
}

resource "aws_internet_gateway" "main_igw" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
        Name = "Web-igw"
    }
}

# EIP for NAT Gateway
resource "aws_eip" "nat_eip" {
    domain = "vpc"
}

# NAT Gateway goes in the PUBLIC subnet
resource "aws_nat_gateway" "main_nat" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id     = aws_subnet.subnet["public_subnet"].id
    tags = {
        Name = "Main-nat"
    }
}

# Public route table → Internet Gateway
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main_igw.id
    }
    tags = {
        Name = "public-rt"
    }
}

resource "aws_route_table_association" "public_rta" {
    subnet_id      = aws_subnet.subnet["public_subnet"].id
    route_table_id = aws_route_table.public_rt.id
}

# Private route table → No internet route (private EC2 cannot reach internet)
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
        Name = "private-rt"
    }
}

resource "aws_route_table_association" "private_rta" {
    subnet_id      = aws_subnet.subnet["private_subnet"].id
    route_table_id = aws_route_table.private_rt.id
}
