project_name = "grant-bayerle"   # chnage this project name to gcp project name 

region       =  "us-east1"



secrets = {
  "OPENAI_API_KEY" = {
    secret_name  = "OPENAI_API_KEY"
    secret_value = "my_secret_value_1"
  }
  "RECALL_API_KEY" = {
    secret_name  = "RECALL_API_KEY"
    secret_value = "my_secret_value_2"
  }
  "RECALL_SIGN_TOKEN" = {
    secret_name  = "RECALL_SIGN_TOKEN"
    secret_value = "my_secret_value_3"
  }
  "SENDGRID_API_KEY" = {
    secret_name  = "SENDGRID_API_KEY"
    secret_value = "my_secret_value_4"
  }
  "TYPESENSE_SEARCH_ONLY_KEY" = {
    secret_name  = "TYPESENSE_SEARCH_ONLY_KEY"
    secret_value = "my_secret_value_5"
  }
  "TYPESENSE_WRITE_ONLY_KEY" = {
    secret_name  = "TYPESENSE_WRITE_ONLY_KEY"
    secret_value = "my_secret_value_6"
  }
  "WEB_CLIENT_SECRET" = {
    secret_name  = "WEB_CLIENT_SECRET"
    secret_value = "my_secret_value_7"
  }
  "ZOOM_OAUTH_APP_CLIENT_SECRET" = {
    secret_name  = "ZOOM_OAUTH_APP_CLIENT_SECRET"
    secret_value = "my_secret_value_8"
  }
  "ZOOM_OAUTH_APP_WEBHOOK_SECRET_TOKEN" = {
    secret_name  = "ZOOM_OAUTH_APP_WEBHOOK_SECRET_TOKEN"
    secret_value = "my_secret_value_9"
  }
  "ZOOM_TOKEN_ENCRYPTION_KEY" = {
    secret_name  = "ZOOM_TOKEN_ENCRYPTION_KEY"
    secret_value = "my_secret_value_10"
  }
}
