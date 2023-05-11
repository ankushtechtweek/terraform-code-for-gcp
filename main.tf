/*
module "secret" {
  source = "./modules/secret_manager"
  secrets       = var.secrets
}
*/

module "vpc" {
  source = "./modules/vpc"
}