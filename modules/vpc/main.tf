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

resource "aws_nat_gateway" "main_nat"{
    subnet_id = module.vpc.subnet_id["public-subnet"]
    tags = {
      Name = "Main-nat"
    }
}
