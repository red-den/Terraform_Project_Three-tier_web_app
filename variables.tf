/*variable "instace_name" {
  description = "Name assigned to every instance made"
  type        = string
  default     = "Project_Instance 1"
}
*/

#VPC
variable "vpc_cidr" {
  description = "VPC Cidr"
  #type = string
  default = "172.20.0.0/20"
}

#VPC
variable "public-subnet1_cidr" {
  description = "VPC Cidr"
  #type = string
  default = "172.20.1.0/24"
}

variable "public-subnet2_cidr" {
  description = "VPC Cidr"
  #type = string
  default = "172.20.2.0/24"
}

variable "private-app1_cidr" {
  description = "VPC Cidr"
  #type = string
  default = "172.20.3.0/24"
}

variable "private-app2_cidr" {
  description = "VPC Cidr"
  #type = string
  default = "172.20.4.0/24"
}

variable "private-db1_cidr" {
  description = "VPC Cidr"
  #type = string
  default = "172.20.5.0/24"
}

variable "private-db2_cidr" {
  description = "VPC Cidr"
  #type = string
  default = "172.20.6.0/24"
}
