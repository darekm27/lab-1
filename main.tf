variable "server-name" {
  type        = string
  description = "Name of server to provision"
}
locals {
  minNumberOfServers = 1
  maxNumberOfServers = 10
}
variable "number-of-servers" {
  type = number
  description = "Required number of servers"
  validation {
    condition = var.number-of-servers >= local.minNumberOfServers && var.number-of-servers <= local.maxNumberOfServers
    error_message = "Number of servers must be in range ${local.minNumberOfServers} - ${local.maxNumberOfServers}"
  }
}

output "output" {
  value = var.server-name
}