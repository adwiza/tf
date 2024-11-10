# File can be named as
# terraform.tfvars
# *.auto.tfvars
# e.g. prod.auto.tfvars dev.auto.tfvars
region                     = "eu-west-3"
enable_detailed_monitoring = false
instance_type              = "t3.micro"
common_tags = {
  Owner       = "Acid Wizard"
  Project     = "Phoenix"
  CostCenter  = "12345"
  Environment = "dev"
}
allow_ports  = ["80", "443", "22", "8080"]
environment  = "dev"
project_name = "ANDESA"
owner        = "Acid Wizard"