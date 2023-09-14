provider "aws" {
  region = var.region
  profile = "mihir_terraform"
}

#create VPC
module "vpc" {
  source                             = "../module/vpc"
  region                             = var.region
  project_name                       = var.project_name
  vpc_cidr_block                     = var.vpc_cidr_block
  public_subnet_az1_cidr_block       = var.public_subnet_az1_cidr_block
  public_subnet_az2_cidr_block       = var.public_subnet_az2_cidr_block
  private_app_subnet_az1_cidr_block  = var.private_app_subnet_az1_cidr_block
  private_app_subnet_az2_cidr_block  = var.private_app_subnet_az2_cidr_block
  private_data_subnet_az1_cidr_block = var.private_data_subnet_az1_cidr_block
  private_data_subnet_az2_cidr_block = var.private_data_subnet_az2_cidr_block

}
/*
module "s3" {
  source = "../modules/s3"
  bucket = var.bucket
}
*/
