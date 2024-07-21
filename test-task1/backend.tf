terraform {
  backend "s3" {
    bucket = "paymentop-test-task-vl"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}