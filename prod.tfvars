s3_buckets = {
  "prod-bucket-1" = {
    name         = "prod-bucket-1"
    environment  = "production"
    cost_centre  = "DevOps"
    product_name = "ProdApp"
    versioning   = true
    object_lock  = false
  },
  "prod-bucket-2" = {
    name         = "prod-bucket-2"
    environment  = "production"
    cost_centre  = "Finance"
    product_name = "ProdApp"
    versioning   = false
    object_lock  = true
    lock_mode    = "GOVERNANCE"
    retention    = 365
  }
}
