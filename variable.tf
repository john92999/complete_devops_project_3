variable "vpc_cidr" {
    description = "value of VPC getting created"
    type = string
}

variable "vpc_subnet" {
    description = "List of subnets"
    type = map(object({
        subnet_cidr_block = string
        subnet_availability_zone = string
        subnet_names = string
}))
}