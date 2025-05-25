# Outputs for the VPC module

resource "aws_ssm_parameter" "private_subnet_ids" {
  name        = "/${var.project}/${var.environment}/private_subnet_ids"
  description = "The IDs of the private subnets"
  type        = "String"
  value       = join(",", aws_subnet.private.*.id)

  tags = {
    Name        = "${var.project}-${var.environment}-private-subnet-ids"
    Environment = var.environment
  }
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name        = "/${var.project}/${var.environment}/public_subnet_ids"
  description = "The IDs of the public subnets"
  type        = "String"
  value       = join(",", aws_subnet.public.*.id)

  tags = {
    Name        = "${var.project}-${var.environment}-public-subnet-ids"
    Environment = var.environment
  }
}