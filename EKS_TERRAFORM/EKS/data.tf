# Outputs for the EKS module
data "aws_ssm_parameter" "subnet_ids_private" {
  name = "/${var.project}/${var.environment}/private_subnet_ids"
}

