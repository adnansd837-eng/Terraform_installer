#Key Pair
resource "aws_key_pair" "ec2_aws_key_pair" {
  key_name   = "my-key-pair"
  public_key = file("terraform-practice.pub")
}
#AMI 
data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

 
}

#VPC
resource "aws_default_vpc" "default" {

}

#Security group
resource "aws_security_group" "my_ec2_sg" {
  name        = "terra-auto-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id    #Interpolation

  tags = {
    Name = "terra-auto-sg"
  }
}

#Ingress (inbount rule)
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ssh" {
  security_group_id = aws_security_group.my_ec2_sg.id    #interpolation
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_http" {
  security_group_id = aws_security_group.my_ec2_sg.id     #interpolation
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

#Egress (outbound rules)
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.my_ec2_sg.id   #interpolation
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#Final instance with all wiring (interpolation)

resource "aws_instance" "my_ec2_instance" {
  count = 10            #meta arguments
  ami           = data.aws_ami.ubuntu.id                                          #Interpolation
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_ec2_sg.id]      #interpolation
  key_name = aws_key_pair.ec2_aws_key_pair.key_name                      #key_name

  root_block_device {           #storage
    volume_size = 20
    volume_type = "gp3"
  }
 
  tags = {
    Name = "terra-auto-server"
  }
}





