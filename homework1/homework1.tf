variable "a" {
  type = number
}

variable "b" {
  type = number
  validation {
    condition = var.b != 0 || var.operand != "/"
    error_message = "Division by zero is no allowed!"  
  }  
}

variable "operand" {
  type = string
  validation {
    condition = contains(local.operators, var.operand)
    error_message = "Operand must be one of: '${join("','", local.operators)}'"
  }
}

locals {
  calculator = {
    "+" = var.a + var.b
    "-" = var.a - var.b
    "*" = var.a * var.b
    "/" = var.a / var.b
  }
  operators = ["+", "-", "*", "/"]
}

output "result" {
  value =  lookup(local.calculator, var.operand)
}