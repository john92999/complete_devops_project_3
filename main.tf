module "vpc" {
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    subnet = var.vpc_subnet
    security_rules = var.security_group_rules
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

# ADD after the S3 resources:
module "public_ec2" {
    source              = "./modules/ec2"
    subnet_id           = module.vpc.subnet-ids["public_subnet"]
    sg_id               = module.vpc.sg_id
    associate_public_ip = true
    ec2_machine_name    = "public-ec2"
    key_name            = var.key_name
}

module "private_ec2" {
    source              = "./modules/ec2"
    subnet_id           = module.vpc.subnet-ids["private_subnet"]
    sg_id               = module.vpc.sg_id
    associate_public_ip = false
    ec2_machine_name    = "private-ec2"
    key_name            = var.key_name
}