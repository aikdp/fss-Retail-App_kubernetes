variable "project" {
    default = "expense"
}

variable "environment"{
    default = "dev"
}


variable "private_subnet_cidrs" {
  type        =list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
  description = "Private subnet CIDRs"
}


variable "node_groups" {
  description = "EKS node group configuration"
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number
    })
  }))
  default = {
    general = {
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      scaling_config = {
        desired_size = 2
        max_size     = 4
        min_size     = 1
      }
    }
  }
}