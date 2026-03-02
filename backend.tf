terraform {
  backend "s3" {
    bucket = "main-bucket-for-complete-devops-project-3"
    key="stateFile"
    region = "ap-south-1"
  }
}