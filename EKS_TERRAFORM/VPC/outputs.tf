
# output "default_vpc_check"{
#   value = data.aws_vpc.default.main_route_table_id
# }

# output "default_route_vpc"{
#   value = data.aws_route_table.main.route_table_id
# }

output "vpc_id"{
  value = aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = aws_subnet.public[*].id
}