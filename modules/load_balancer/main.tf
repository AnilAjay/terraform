provider "aws" {
  region = var.region
}

resource "aws_security_group" "alb_sg" {
  name_prefix = "alb-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "web_lb" {
  name               = "webserver-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups   = [aws_security_group.alb_sg.id]
  subnets           = var.subnet_ids

  enable_deletion_protection = false

  enable_cross_zone_load_balancing = true
}

resource "aws_lb_target_group" "web_target_group" {
  name     = "webserver-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      status_code = 200
      content_type = "text/plain"
      message_body = "Helloworld"
    }
  }
}

resource "aws_lb_target_group_attachment" "web_target" {
  target_group_arn = aws_lb_target_group.web_target_group.arn
  target_id        = var.webserver_instance_id
  port             = 80
}

output "alb_dns_name" {
  value = aws_lb.web_lb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.web_target_group.arn
}
