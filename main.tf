terraform {
  # If we want to add a remote backend, which would be best practice, we can use the backend block below which will add the state file to an s3 bucket
  # backend "s3" {}
  required_version = ">= 1.1.0"
  # required aws provider, this can be added to a providers.tf file also, however the requirement was to keep it simple an in a single file so using it in the main.tf
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

  # Bucket name
  bucket = each.value.name

  # Bucket tags
  tags = {
    Name        = each.value.name
    Environment = each.value.environment
    CostCentre  = each.value.cost_centre
    Product     = each.value.product_name
  }
}

# Resource for versioning
resource "aws_s3_bucket_versioning" "versioning" {
  # Looping through the variables, so this is only applicable where the versioning variable in the s3_buckets variable is set to true, for the buckets where it is set to false, it should skip that and not create a versioning resource for it
  for_each = { for k, v in var.s3_buckets : k => v if v.versioning }

  # for the buckets that do have it set to true, this will become appicable to that as it will then enable it
  bucket = aws_s3_bucket.trayport_s3[each.key].id
  versioning_configuration {
    status = "Enabled"
  }
}

# Adding acl resource, though not a requirement in the tech test, its best practice to have this enabled
resource "aws_s3_bucket_acl" "trayport_s3_acl" {
  # looping through all the buckets
  for_each = var.s3_buckets
  # grabbing the bucket id and setting the acl to private
  bucket = aws_s3_bucket.trayport_s3[each.key].id
  acl    = "private"
}

# object lock configuration
# as per the requirements this was supposed to be set for only specific buckets also, so again we will map through the variable file, only grab the values where the object_lock is true
resource "aws_s3_bucket_object_lock_configuration" "lock" {
  for_each = { for k, v in var.s3_buckets : k => v if v.object_lock }
  # once we have the ones where it is set, we will set the default values for it in the bucket
  bucket = aws_s3_bucket.trayport_s3[each.key].id
  # and set the rules for that specific bucket
  rule {
    default_retention {
      mode = each.value.lock_mode
      days = each.value.retention
    }
  }
}
