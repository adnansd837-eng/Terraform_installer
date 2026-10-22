locals {
  ec2_key_name = "terra-key-pair"    #name of file
}

#Key Pair
resource "aws_key_pair" "ec2_aws_key_pair" {
  key_name   = locals.ec2_key_name # using this local variable
  public_key = file("terra-server-k.pub")
}
