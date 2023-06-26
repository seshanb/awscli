variable "ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-0123456789abcdef0"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "Key pair name"
  type        = string
  default     = "your_key_pair_name"
}
