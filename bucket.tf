resource "aws_s3_bucket" "bucket" {
  bucket = "shell-lambda-bucket-001"
}

 data "archive_file" "hello" {
  type        = "zip"
  source_file = "hello.py"
  output_path = "./hello.zip"
}
resource "aws_s3_object" "hello" {
  depends_on = [ data.archive_file.hello ]
  bucket = "aws_s3_bucket.bucket.bucket"
  key    = "hello.py"
  source = "hello.zip"
}


