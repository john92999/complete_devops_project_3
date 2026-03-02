vpc_cidr = "10.0.0.0/16"

vpc_subnet = {
  "public_subnet" = {
    subnet_cidr_block        = "10.0.1.0/24"
    subnet_availability_zone = "ap-south-1a"
    subnet_names             = "web-subnet"
  }
  "private_subnet" = {
    subnet_cidr_block        = "10.0.2.0/24"
    subnet_availability_zone = "ap-south-1b"
    subnet_names             = "private_subnet"
  }
}

ami_id        = "ami-0f58b397bc5c1f2e8"  # Amazon Linux 2 ap-south-1 — replace if needed
instance_type = "t2.micro"
key_name      = "your-key-pair-name"      # Replace with your actual key pair name
