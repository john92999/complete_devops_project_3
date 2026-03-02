module "vpc" {
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    subnet = var.vpc_subnet
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

