variable "common_tags" {
  description = "Common Tags to appply to all resources"
  type        = map(any)
  default = {
    Owner       = "Acid Wizard"
    Project     = "Test"
    CostCenter  = "123123"
    Environment = "development"
  }
}

variable "region" {}
variable "instance_type" {}
variable "enable_detailed_monitoring" {}