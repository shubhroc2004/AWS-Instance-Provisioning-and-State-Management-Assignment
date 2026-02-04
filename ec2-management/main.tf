data "aws_ssm_parameter" "ami" {
  name = var.ami_ssm_parameter
}

module "ec2" {
  source        = "./modules/ec2"
  ami_id        = data.aws_ssm_parameter.ami.value
  cidr_ipv4     = var.cidr_ipv4
  instance_type = var.instance_type
  user_data = file("${path.root}/userdata.tpl")
}