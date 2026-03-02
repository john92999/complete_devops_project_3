resource "aws_instance" "main-instance"{
    ami                         = "ami-019715e0d74f695be"
    subnet_id                   = var.subnet_id
    instance_type               = var.instance_type
    key_name                    = var.key_name
    vpc_security_group_ids      = [var.sg_id]           
    associate_public_ip_address = var.associate_public_ip
    tags = {
        Name = var.ec2_machine_name
    }
}
