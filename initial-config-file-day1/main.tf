resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/24"
tags = {
    name = "my-pvt-vpc"

}
  
}
resource "aws_subnet" "pvtsub" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/26"
}
resource "aws_security_group" "pvtsg" {
    name = "my-pvt-sg"
    vpc_id = aws_vpc.name.id
}