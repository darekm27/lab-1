variable "name_prefix" {
  type    = string
}

variable "server_version" {
  type = string
  validation {
    condition     = var.server_version == "1" || var.server_version == "2"
    error_message = "Wrong version"
  }
}

variable "number_of_servers" {
  type    = number
  default = 3
}

variable "vpc_id" {
  type = string
  description = "Server VPC"
}

variable "subnet_ids" {
  type = list(string)
  description = "List of servers subnets"
}

