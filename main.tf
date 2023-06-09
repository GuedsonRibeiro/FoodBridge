provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "my-tfstate-bucket-guedson"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}

module "ec2" {
  source = "./modules/ec2"
  public_subnet_id = module.network.public_subnet_id
  web_sg_id = module.network.web_sg_id
}

module "rds" {
  source = "./modules/rds"
  private_subnet_id = module.network.private_subnet_id
  db_sg_id = module.network.db_sg_id
}


module "s3" {
  source = "./modules/s3"
}
