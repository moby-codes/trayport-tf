s3_buckets = {
  "staging-bucket-1" = {
    name         = "staging-bucket-1"
    environment  = "staging"
    cost_centre  = "DevOps"
    product_name = "StagingApp"
    versioning   = true
    object_lock  = false
  },
  "staging-bucket-2" = {
    name         = "staging-bucket-2"
    environment  = "staging"
    cost_centre  = "Finance"
    product_name = "StagingApp"
    versioning   = false
    object_lock  = true
    lock_mode    = "COMPLIANCE"
    retention    = 90
  }
}
