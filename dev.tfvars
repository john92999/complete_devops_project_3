vpc_cidr = "10.0.0.0/16"
vpc_subnet = {
  "public_subnet" = {
    subnet_cidr_block = "10.0.1.0/24"
    subnet_availability_zone = "ap-south-1a"
    subnet_names = "web-subnet"
  }
  "private_subnet" = {
    subnet_cidr_block = "10.0.2.0/24"
    subnet_availability_zone = "ap-south-1b"
    subnet_names = "private_subnet"
  }
}
security_group_rules{
    "ssh" = {
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }
    "http" = {
        from_port = 80
        to_port = 80
        protocol = "tcp"
    }
    "app" = {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
    }
}

key_name = "demoapp"