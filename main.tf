variable "server-name" {
  type        = string
  description = "Name of server to provision"
}

output "output" {
  value = var.server-name
}