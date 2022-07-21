variable "vpc_cidr" {
  default = "10.16.0.0/16"
}
variable "enable_dns_support" {
  default = true
}
variable "enable_dns_hostnames" {
  default = true
}
variable "web_subnet_count" {
  default = 0
}
variable "app_subnet_count" {
  default = 0
}
variable "db_subnet_count" {
  default = 0
}
variable "reserved_subnet_count" {
  default = 0
}
variable "web_cidr_blocks" {
  default = []
}
variable "app_cidr_blocks" {
  default = []
}
variable "db_cidr_blocks" {
  default = []
}
variable "reserved_cidr_blocks" {
  default = []
}
variable "max_subnetcount" {
  default = 20
}
variable "vpc_endpoints" {
  default = {}
}
variable "security_group_ids" {
  default = []
}
variable "availability_zone" {
  default = []
}
variable "service_name" {
  default = ""
}
variable "vpc_endpoint_type" {
  default = ""
}
variable "subnet_ids" {
  default = []
}
variable "vpc_name" {
  default = "tf-project"
}