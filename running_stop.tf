#running and stopped instance state
resource "aws_ec2_instance_state" "my_instance_state" {
  instance_id = aws_instance.my_ec2_instance.id
  state       = "stopped"
}
