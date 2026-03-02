variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type        = string
    default = "10.0.0.0/16"
}

variable "subnet" {
    description = "Subnets assigned to the VPC"
    type = map(object({
        subnet_cidr_block = string
        subnet_availability_zone = string
        subnet_names = string
    }))
}