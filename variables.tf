#Variables you change values without changing your code.
variable "ec2_volume_size" {
  type        = number
  default     = "10"
  description = "this variable holds volume size"
}

variable "ec2_instance_name" {
  type        = string
  default     = "my_advance_instance"
  description = "this variable holds the instance name"
}
