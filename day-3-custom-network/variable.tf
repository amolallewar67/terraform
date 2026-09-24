variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}
variable "ami_id" {
    description = "the ami id for the instance"
    type = string
    default = "ami-0fef201115eefe936"
    
}
variable "ingress_ports" {
    description = " list of ingress port to allow"
    type = list(number)
    default = [22,80]
}