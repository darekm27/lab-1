variable "server-name" {
  type        = string
  description = "Name of server to provision"
}

variable "password" {
  type = string
  sensitive = true
}

locals {
  minNumberOfServers = 1
  maxNumberOfServers = 10
}

locals {
  countOfItesm = {
    disks = 13
    servers = 22
    max = local.maxNumberOfServers
  }
  pwd = var.password
}


variable "number-of-servers" {
  type        = number
  description = "Required number of servers"
  default     = 2
  validation {
    condition     = var.number-of-servers >= local.minNumberOfServers && var.number-of-servers <= local.maxNumberOfServers
    error_message = "Number of servers must be in range ${local.minNumberOfServers} - ${local.maxNumberOfServers}"
  }
}
variable "list-of-names" {
  type = list(string)
  description = "List of names"
}

variable "number-of-disks" {
  type = number
  description = "Number of disks"
  default = 1
}

output "result" {
  value = "${var.server-name} x ${var.number-of-servers}"
}

output "number-resources" {
  value = var.number-of-disks * var.number-of-servers
}

output "list-of-names" {
  value = "${join(", ",var.list-of-names)}"
}

output "name" {
  value = lookup(local.countOfItesm, max)
}

output "pasword" {
  value = local.pwd
}