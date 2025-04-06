provider "aws" {
  region = var.region
}

module "webserver" {
  source        = "./modules/webserver"
  region        = var.region
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  vpc_id        = var.vpc_id 
  private_key_path = var.private_key_path

}

module "load_balancer" {
  source               = "./modules/load_balancer"
  region               = var.region
  subnet_ids           = var.subnet_ids
  vpc_id               = var.vpc_id
  webserver_instance_id = module.webserver.webserver_instance_id
}

output "webserver_public_ip" {
  value = module.webserver.webserver_public_ip
}

output "alb_dns_name" {
  value = module.load_balancer.alb_dns_name
}
