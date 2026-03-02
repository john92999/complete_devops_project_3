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

variable "security_rules" {
    description = "Type of security rules to be associated to security group"
    type = map(object({
      security_group_from_port = list[string]
      security_group_to_port = string
      protocol = string
    }))
}