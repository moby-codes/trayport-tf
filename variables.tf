
variable "s3_buckets" {
  description = "S3 bucket configurations per environment"
  type = map(object({
    name         = string
    environment  = string
    cost_centre  = string
    product_name = string
    versioning   = optional(bool, false)
    object_lock  = optional(bool, false)
    lock_mode    = optional(string)
    retention    = optional(number)
  }))
}

