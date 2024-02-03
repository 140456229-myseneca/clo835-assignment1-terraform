terraform {
  backend "s3" {
    bucket = "clo835-assignment-1"        // Bucket where to SAVE Terraform State. Provide your unique custom name
    key    = "network/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                           // Region where bucket is created
  }
}