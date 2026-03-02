module "vpc" {
    source   = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    subnet   = var.vpc_subnet
}

resource "aws_s3_bucket" "main_terraform_statefile" {
    bucket = "main-bucket-for-complete-devops-project-3"
}

resource "aws_s3_bucket_versioning" "version_main_terraform_statefile" {
    bucket = aws_s3_bucket.main_terraform_statefile.id
    versioning_configuration {
        status = "Enabled"
    }
}

# Security Group — allows 22, 80, 8080 from internet; all internal VPC traffic
resource "aws_security_group" "main_sg" {
    name   = "main-sg"
    vpc_id = module.vpc.vpc_id

    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "App port"
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow all traffic within VPC (so public ↔ private EC2 can communicate)
    ingress {
        description = "Internal VPC traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [var.vpc_cidr]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "main-sg"
    }
}

# Public EC2 — has public IP, accessible from internet
resource "aws_instance" "public_ec2" {
    ami                         = var.ami_id
    instance_type               = var.instance_type
    subnet_id                   = module.vpc.subnet-ids["public_subnet"]
    vpc_security_group_ids      = [aws_security_group.main_sg.id]
    associate_public_ip_address = true
    key_name                    = var.key_name

    tags = {
        Name = "public-ec2"
    }
}

# Private EC2 — no public IP, no internet route
resource "aws_instance" "private_ec2" {
    ami                         = var.ami_id
    instance_type               = var.instance_type
    subnet_id                   = module.vpc.subnet-ids["private_subnet"]
    vpc_security_group_ids      = [aws_security_group.main_sg.id]
    associate_public_ip_address = false
    key_name                    = var.key_name

    tags = {
        Name = "private-ec2"
    }
}
