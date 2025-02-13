# variable "bucket_name" {
#   description = "name of s3 bucket"
#   type        = string

# }

# variable "s3_env" {
#   description = "AWS s3 bucket environment"
#   type        = string

# }

# variable "s3_version" {
#   description = "AWS s3 bucket version"
#   default     = false
# }

# variable "s3_project" {
#   description = "the project the s3 bucket belongs to"
# }

variable "s3_buckets" {
  description = "S3 bucket configurations per environment"
  type = map(object({
    name         = string
    environment  = string
    cost_centre  = string
    product_name = string
    versioning   = optional(bool, false)
    object_lock  = optional(bool, false)
    lock_mode    = optional(string, "GOVERNANCE")
    retention    = optional(number)
  }))
}

