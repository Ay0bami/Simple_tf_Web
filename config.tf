terraform {
  backend "s3" {
    bucket = "fall2022-acs730-islamiyat" // Bucket where to SAVE Terraform State
    key    = "midterm/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                 // Region where bucket is created
  }
}
