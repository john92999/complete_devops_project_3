variable "vpc_cidr" {
    description = "value of VPC getting created"
    type        = string
}

variable "vpc_subnet" {
    description = "List of subnets"
    type = map(object({
        subnet_cidr_block        = string
        subnet_availability_zone = string
        subnet_names             = string
    }))
}

variable "ami_id" {
    description = "AMI ID for EC2 instances"
    type        = string
}

variable "instance_type" {
    description = "EC2 instance type"
    type        = string
    default     = "t2.micro"
}

variable "key_name" {
    description = "Name of the existing EC2 key pair for SSH"
    type        = string
}

variable "private_key_path" {
    description = "Path to the private key file for SSH"
    type        = string
}
