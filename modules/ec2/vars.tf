variable "subnet_id" {
    type = map(object({
        subnet_id = string
    }))
    description = "Subnet id associated with the EC2 machine"
}
variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "key_name" {
    type = string
    default = "key value to ssh into the machine"
}

variable "ec2_machine_name" {
    type = string
    default = "Name of the ec2 machine"
}