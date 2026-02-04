variable "ami_id" {
    description = "AMI for EC2 Instance"
    type = string
}

variable "cidr_ipv4" {}
variable "instance_type" {}
variable "user_data" { type = string }