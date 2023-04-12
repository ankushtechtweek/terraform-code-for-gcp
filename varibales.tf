variable "project_name" {
  type    = string
  default = "grant-bayerle"
}

variable "GOOGLE_CREDENTIALS" {
  type = any

}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "secrets" {
  type = map(object({
    secret_name  = string
    secret_value = string
  }))
  default = {
    "OPENAI_API_KEY" = {
      secret_name  = "OPENAI_API_KEY1"
      secret_value = "my_secret_value_1"
    }
    "RECALL_API_KEY" = {
      secret_name  = "RECALL_API_KEY1"
      secret_value = "my_secret_value_2"
    }
    "RECALL_SIGN_TOKEN" = {
      secret_name  = "RECALL_SIGN_TOKEN1"
      secret_value = "my_secret_value_3"
    }
    "SENDGRID_API_KEY" = {
      secret_name  = "SENDGRID_API_KEY1"
      secret_value = "my_secret_value_4"
    }
    "TYPESENSE_SEARCH_ONLY_KEY" = {
      secret_name  = "TYPESENSE_SEARCH_ONLY_KEY1"
      secret_value = "my_secret_value_5"
    }
    "TYPESENSE_WRITE_ONLY_KEY" = {
      secret_name  = "TYPESENSE_WRITE_ONLY_KEY1"
      secret_value = "my_secret_value_6"
    }
    "WEB_CLIENT_SECRET" = {
      secret_name  = "WEB_CLIENT_SECRET1"
      secret_value = "my_secret_value_7"
    }
    "ZOOM_OAUTH_APP_CLIENT_SECRET" = {
      secret_name  = "ZOOM_OAUTH_APP_CLIENT_SECRET1"
      secret_value = "my_secret_value_8"
    }
    "ZOOM_OAUTH_APP_WEBHOOK_SECRET_TOKEN" = {
      secret_name  = "ZOOM_OAUTH_APP_WEBHOOK_SECRET_TOKEN1"
      secret_value = "my_secret_value_9"
    }
    "ZOOM_TOKEN_ENCRYPTION_KEY" = {
      secret_name  = "ZOOM_TOKEN_ENCRYPTION_KEY1"
      secret_value = "my_secret_value_10"
    }
    "ZOOM_TOKEN_ENCRYPTION_KEYASDA" = {
      secret_name  = "ZOOM_TOKEN_ENCRYPTIONDASDAS"
      secret_value = "my_secret_value_10"
    }
  }
}