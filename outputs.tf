#by using output we can see public_dns and public_ip. instead of going aws


output "public_dns" {
  value = aws_instance.my_ec2_instance.public_dns
}

output "public_ip" {
  value = aws_instance.my_ec2_instance.public_ip
}


