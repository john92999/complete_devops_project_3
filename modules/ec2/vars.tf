variable "subnet_id" {
    type        = string
    description = "Subnet ID for the EC2 instance"
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

variable "sg_id" {
    type        = string
    description = "Security group ID to attach"
}

variable "associate_public_ip" {
    type        = bool
    default     = false
    description = "Whether to assign a public IP"
}
