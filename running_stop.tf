#running and stopped instance to check the file . we use this instance
resource "aws_ec2_instance_state" "my_instance_state" {
  instance_id = aws_instance.my_ec2_instance.id
  state       = "stopped"
}
