
#-----------------------------------------
# Terraform defaults
#-----------------------------------------

variable "is_production" {
  description = "The infrastructure is in production?. If true api_termination will be disabled"
  default     = true
}