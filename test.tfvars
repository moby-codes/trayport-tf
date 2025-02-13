s3_buckets = {
  "test-bucket-1" = {
    name         = "test-bucket-1"
    environment  = "test"
    cost_centre  = "DevOps"
    product_name = "TestApp"
    versioning   = true
    object_lock  = false
  },
  "test-bucket-2" = {
    name         = "test-bucket-2"
    environment  = "test"
    cost_centre  = "Finance"
    product_name = "TestApp"
    versioning   = false
    object_lock  = true
    lock_mode    = "GOVERNANCE"
    retention    = 30
  }
}
