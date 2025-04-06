provider "aws" {
  region = var.region
}

resource "aws_security_group" "web_sg" {
  name_prefix = "webserver"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows access from any IP, or replace with your specific IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "private_key" {
  content  = tls_private_key.ec2_key.private_key_pem
  filename = "${path.module}/${var.key_name}.pem"
}
# Create an AWS Key Pair
resource "aws_key_pair" "generated_key" {
  key_name   = "test_keypair-${timestamp()}"
  public_key = file("C:/Users/ravanil/.ssh/id_ed25519.pub")
}

resource "aws_instance" "webserver" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  security_groups        = [aws_security_group.web_sg.id]
  subnet_id              = var.subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "WebServer"
  }
   # Provisioners to install Apache and serve "Hello World"
provisioner "remote-exec" {
  inline = [  
    "echo 'Starting setup script...'", # Debug line
    "sudo yum update -y",
    "sudo yum install -y httpd",
    "echo '<html><h1>Hello World</h1></html>' | sudo tee /var/www/html/index.html",
    "sudo systemctl start httpd",
    "sudo systemctl enable httpd"
  ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    host        = aws_instance.webserver.public_ip
  }

  on_failure = "continue" # Continue even if it fails, useful for debugging
}

  }



output "webserver_public_ip" {
  value = aws_instance.webserver.public_ip
}

output "webserver_instance_id" {
  value = aws_instance.webserver.id
}
