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

variable "security_group_rules" {
    description = "Rules given to security group"
    type =  map(object({
        security_group_from_port = list[string]
        security_group_to_port = string
        protocol = string    
    }))   
}