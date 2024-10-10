variable "common_tags" {
  description = "Common Tags to appply to all resources"
  type = map
  default = {
    Owner = "Acid Wizard"
    Project = "Test"
    CostCenter = "123123"
    Environment = "development"
  }
}