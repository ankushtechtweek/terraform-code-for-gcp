provider "google" {
  project = "${var.project_name}" 
    credentials = var.GOOGLE_CREDENTIALS   # change this  with variable name that you are using in terraform cloud for passing GCP details
  region  = "${var.region}"
}


terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.47.0"
    }
  }
}


