variable "region" {
  description = "AWS region"
  type        = string
}

variable "subnet_ids" {
  description = "List of Subnet IDs to attach the ALB to"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "webserver_instance_id" {
  description = "The instance ID of the web server"
  type        = string
}
