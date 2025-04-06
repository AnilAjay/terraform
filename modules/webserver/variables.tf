variable "region" {
  description = "AWS region"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the web server"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 web server"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "subnet_id" {
  description = "VPC Subnet ID for the EC2 instance"
  type        = string
}

variable "root_volume_size" {
  description = "Root EBS volume size"
  type        = number
  default     = 8
}
variable "vpc_id" {
  description = "VPC ID to associate the resources"
  type        = string
}
variable "private_key_path" {
  type        = string
  description = "Path to the private key"
}