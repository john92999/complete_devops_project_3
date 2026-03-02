output "subnet-ids" {
    value = {
        for key, subnet in aws_subnet.subnet :
        key => subnet.id
    }
}

output "vpc_id" {
    value = aws_vpc.main_vpc.id
}

output "sg_id" {
    value = aws_security_group.main_sg.id
}