resource "aws_vpc" "main_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "main_vpc"
    }
}

resource "aws_subnet" "subnet"{
    for_each = var.subnet
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = each.value.subnet_cidr_block
    availability_zone = each.value.subnet_availability_zone
    tags = {
        Name = each.value.subnet_names
    }
}

resource "aws_internet_gateway" "main_igw"{
    vpc_id = aws_vpc.main_vpc.id
    tags = {
        Name = "Web-igw"
    }
}

resource "aws_eip" "nat_eip" {
    domain = "vpc"
}

resource "aws_nat_gateway" "main_nat"{
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.subnet["private_subnet"].id
    tags = {
      Name = "Main-nat"
    }
}

resource "aws_security_group" "security_rules" {
    for_each = var.security_rules
    ingress = {
        from_port = each.value.security_group_from_port
        to_port = each.value.security_group_to_port
        protocol = each.value.security_group_protocol
    }
}