variable "network_name" {
  description = "Desired name for the VPC network"
  type        = string
  default     = "gcp-vpc"
}

variable "subnet_name" {
  description = "Desired name for the subnet"
  type        = string
  default     = "gcp-subnet"
}

variable "subnet_cidr" {
  description = "Desired CIDR range for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}