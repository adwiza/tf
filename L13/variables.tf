variable "region" {}

variable "instance_type" {}

variable "allow_ports" {
  type = list(any)
}

variable "enable_detailed_monitoring" {
  type = bool
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(any)
}

variable "environment" {}
variable "project_name" {}
variable "owner" {}