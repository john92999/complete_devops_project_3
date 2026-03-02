output "subnet-ids" {
    value = {
        for key, subnet in aws_subnet.subnet :
        key => subnet.id
    }
}

# Added: needed by root main.tf to attach security group to the VPC
output "vpc_id" {
    value = aws_vpc.main_vpc.id
}
