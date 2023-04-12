provider "google" {
  project = "${var.project_name}"
    credentials = var.GOOGLE_CREDENTIALS
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


