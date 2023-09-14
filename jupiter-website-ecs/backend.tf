terraform {
  backend "s3" {
    bucket  = "terraform-state-information-btc-mihir"
    key     = "jupiter_website_ecs_key"
    region  = "us-east-1"
    profile = "mihir_terraform"
  }
}
