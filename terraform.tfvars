region        = "us-east-1"
ami_id        = "ami-00a929b66ed6e0de6"   # Replace with your desired AMI
instance_type = "t2.micro"
key_name      = "test_keypair"
subnet_id     = "subnet-0be9d6cd4c51c397e"        # Replace with your subnet ID
subnet_ids    = ["subnet-0be9d6cd4c51c397e", "subnet-0915df8c4a7c67362"]     # Replace with your subnet IDs for ALB
vpc_id        = "vpc-03f701a996b62f554"  
private_key_path = "C:/Users/ravanil/.ssh/id_ed25519.pub"         # Replace with your VPC ID
