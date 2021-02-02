# TEST

resource "aws_s3_bucket" "b" {
  bucket = "demo-bucket-terraform"
  acl    = "public-read"
}


# ============================ SSM ======================================

resource "random_password" "random" {
  length = 64
}

resource "aws_ssm_parameter" "my_index_key" {
  name  = "${var.project_name}-my-index-key"
  type  = "String"
  value = random_password.random.result
}

resource "aws_kms_key" "master_key" {
  description              = "master encryption key"
  customer_master_key_spec = "RSA_4096"
  key_usage                = "ENCRYPT_DECRYPT"
  deletion_window_in_days  = 7

  tags = {
    Name    = "${var.project_name}-master-key"
    Project = var.project_name
  }
}