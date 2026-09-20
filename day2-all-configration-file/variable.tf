variable "cidr" {
    type = string
    default = "10.0.0.0/24"
  
}
variable "subnet" {

    default = "10.0.0.0/26"
  
}
variable "name_tag" {
    type = string
    default = "my-vpc"
}