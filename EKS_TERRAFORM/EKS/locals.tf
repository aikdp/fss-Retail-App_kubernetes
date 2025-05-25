locals {
  private_subnet_id = split(",", data.aws_ssm_parameter.subnet_ids_private.value)
#   split(",", data.aws_ssm_parameter.private_subnet_ids.value)
}
