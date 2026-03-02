resource "aws_instance" "main-instance"{
    ami = "ami-019715e0d74f695be"
    for_each = var.subnet_id
    subnet_id = each.value.subnet_id
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = aws_security_group.complete_project_security_group.id
    tags = {
        Name = var.ec2_machine_name
    }
}