# File can be named as
# terraform.tfvars
# *.auto.tfvars
# e.g. prod.auto.tfvars dev.auto.tfvars
region                     = "eu-west-3"
enable_detailed_monitoring = true
instance_type              = "t2.small"
common_tags = {
  Owner       = "Acid Wizard"
  Project     = "Phoenix"
  CostCenter  = "12345"
  Environment = "prod"
}
allow_ports  = ["80", "443", "22", "8080"]
environment  = "prod"
project_name = "ANDESA"
owner        = "Acid Wizard"