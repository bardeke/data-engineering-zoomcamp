terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.13.0"
    }
  }
}

provider "google" {
  credentials = file("./keys/gcpcreds.json")
  project     = "chromatic-fx-411315"
  region      = "us-central1"
}



resource "google_storage_bucket" "demo-bucket" {
  name     = "chromatic-fx-411315-terrabucket"
  location = "US"

  # Optional, but recommended settings:
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 1 // days
    }
  }

  force_destroy = true
}
