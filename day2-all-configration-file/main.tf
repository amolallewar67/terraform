resource "aws_vpc" "name" {
    cidr_block = var.cidr
    tags = {
        name = var.name_tag
    }
  
}
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.subnet
    tags = {
        name = "pub-subnet"
    }


}