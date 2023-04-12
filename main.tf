module "secret" {
  source = "modules/secret_manager"
  secrets       = var.secrets
}