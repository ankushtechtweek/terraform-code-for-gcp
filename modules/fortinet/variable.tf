/*
variable "image_location" {
  description = "Project where source image is located"
  default     = "fortigcp-project-001"

}

variable "image" {
  description = "Name of Image to use"
  default     = "fortinet-fgtondemand-646-20210531-001-w-license"
}
*/
##fortinet##

variable "region" {
  type    = string
  default = "us-east1"
}

# GCP zone
variable "zone" {
  type    = string
  default = "us-east1-c" #Default Zone
}

# GCP Fortinet official project
variable "ftntproject" {
  type    = string
  default = "fortigcp-project-001"
}

# FortiGate Image name
# 7.2.4 payg is projects/fortigcp-project-001/global/images/fortinet-fgtondemand-724-20230201-001-w-license
# 7.2.4 byol is projects/fortigcp-project-001/global/images/fortinet-fgt-724-20230201-001-w-license
variable "image" {
  type    = string
  default = "projects/fortigcp-project-001/global/images/fortinet-fgtondemand-724-20230201-001-w-license"
}

# GCP VNIC type
# either GVNIC or VIRTIO_NET
variable "nictype" {
  type    = string
  default = "GVNIC"
  
}
# GCP instance machine type
variable "machine" {
  type    = string
  default = "e2-medium"
}
# VPC CIDR
variable "vpc_cidr" {
  type    = string
  default = "172.16.0.0/16"
}
# Public Subnet CIDR
variable "public_subnet" {
  type    = string
  default = "172.16.0.0/24"
}
# Private Subnet CIDR
variable "protected_subnet" {
  type    = string
  default = "172.16.1.0/24"
}

# user data for bootstrap fgt configuration
variable "user_data" {
  type    = string
  default = "config.txt"
}

# user data for bootstrap fgt license file
variable "license_file" {
  type    = string
  default = "license.lic" #FGT BYOL license
}