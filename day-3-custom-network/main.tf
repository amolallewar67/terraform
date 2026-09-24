resource "aws_vpc" "name" {
    cidr_block = var.vpc_cidr
    tags = {
        name = "my-vpc"
    }

  
}
resource "aws_subnet" "pvt-subnet-1" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.subnet_cidr
    tags = {
      "name" = "custom-subnet-1"
    }
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.name.id
    tags = {
        name = "my-custom-igw"
    }
}
resource "aws_route_table" "custom-route-table" {
    vpc_id = aws_vpc.name.id
    tags = {
        name = "my-custom-route-table"
    }
    route {
        cidr_block = "0.0.0.0/24"
        gateway_id = aws_internet_gateway.igw.id
    }
}
resource "aws_route_table_association" "custom-route-table-association" {
    subnet_id = aws_subnet.pvt-subnet-1.id
    route_table_id = aws_route_table.custom-route-table.id
}
resource "aws_security_group" "my-sg" {
    name = "my-security-group"
    description = " allow ssh and http"
    vpc_id = aws_vpc.name.id

ingress {
    from_port = var.ingress_ports[0] #we can add here for loop also for many ingress rules
    to_port = var.ingress_ports[0]
    protocol = "tcp"
    #ipv4_cidr_blocks = [192.168.0.0/16]
    cidr_blocks = ["0.0.0.0/0"]
}
ingress {
    from_port = var.ingress_ports[1]
    to_port = var.ingress_ports[1]
    protocol = "http"
    cidr_blocks = ["0.0.0.0/0"]
}
egress {
    from_port = 0
    to_port = 0
    protocol = -1 #any protocol
    cidr_blocks = ["0.0.0.0/0"]
}
egress {
    from_port = 0
    to_port = 0
    protocol = -1 #any protocol
    cidr_blocks = ["0.0.0.0/0"]
}
}
resource "aws_instance" "my-instance" {
    ami = var.ami_id #amazon linux 2 ami
    instance_type = "t3.micro"
    subnet_id = aws_subnet.pvt-subnet-1.id
    vpc_security_group_ids = [aws_security_group.my-sg.id]
}

