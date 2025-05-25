locals {
  module_name = "${var.project}-${var.environment}"
  az_zones = slice((data.aws_availability_zones.available.names), 0, 2) 
}