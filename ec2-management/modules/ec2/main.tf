resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh_22" {
  security_group_id = aws_security_group.allow_tls.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = var.cidr_ipv4
}

resource "aws_vpc_security_group_ingress_rule" "tcp_8080" {
  security_group_id = aws_security_group.allow_tls.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = var.cidr_ipv4
}

resource "aws_vpc_security_group_egress_rule" "all_outbound" {
  security_group_id = aws_security_group.allow_tls.id
  ip_protocol       = "-1"
  cidr_ipv4         = var.cidr_ipv4
}

resource "aws_key_pair" "deployer" {
  key_name = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWb/z8Dfm2YXL3oKg1LSt+hPsFTceNZ6Dl39j6ONaOjIJepkIaEH/IcZ+4dI+WOp323VsRky098Y8Pj1fp4L1tHwovHYCDrov9aKW+BEXsxkSEHi0MwRTh+ZmvgTev0B3uAhkU2/LZ2ec25acNJ4Fv8pXPeIBaGIsxsl+/iwidwUK4/kj8e+gwgGDdfVTq4q2i73WSwJa9f/KBZGj7xI/1XEbvDkX8S0dXnB//iCmoMxBp/Vzz4dq3lwhtTZZIY82sEAAifl/rRe5ha4Ckh54shlbYCQiBqXKnXOzuzyXVzhhPy4jGgX/MHR+1WN4d0o0UOgBYN0qe9DS2VHZkUxKtal7MXEg6kye+imGa12vlExaLU6Yz8N1xsff1OZKusqWCAWFEd/oCWapGnYBnI68uOm4deWrPt9ZvskysJuUluYyn2DTWPmsaobZ+zdcEk6q9+IGZJXyUjdkNtpAymp8i2CNkv7GjWV/P1WV++3G6O1KLZNU+UP1jQCIbr9+uEwM= codespace@codespaces-591a18"
}

resource "aws_instance" "aws_instance_1" {
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = var.user_data
  key_name = aws_key_pair.deployer.key_name
  user_data_replace_on_change = true

  tags = {
    Name = "server-one-1"
  }
}