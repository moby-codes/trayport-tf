terraform {
  # If we want to add a remote backend, which would be best practice, we can use the backend block below which will add the state file to an s3 bucket
  # backend "s3" {}
  required_version = ">= 1.1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
}

# Creating the aws_s3_resource

resource "aws_s3_bucket" "trayport_s3" {
    # Looping through the s3_buckets variable
  for_each = var.s3_buckets

  bucket = each.value.name

  tags = {
    Name        = each.value.name
    Environment = each.value.environment
    CostCentre  = each.value.cost_centre
    Product     = each.value.product_name
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  for_each = { for k, v in var.s3_buckets : k => v if v.versioning }

  bucket = aws_s3_bucket.trayport_s3[each.key].id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_acl" "trayport_s3_acl" {
  for_each = var.s3_buckets

  bucket = aws_s3_bucket.trayport_s3[each.key].id
  acl    = "private"
}


resource "aws_s3_bucket_object_lock_configuration" "lock" {
  for_each = { for k, v in var.s3_buckets : k => v if v.object_lock }

  bucket = aws_s3_bucket.trayport_s3[each.key].id

  rule {
    default_retention {
      mode  = each.value.lock_mode
      days  = each.value.retention
    }
  }
}
