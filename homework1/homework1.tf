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
    condition = var.operand == "+" || var.operand == "-" || var.operand == "*" || var.operand == "/"
    error_message = "Operand must be one of '+','-','*','/' "
  }
}

locals {
  calculator = {
    "+" = var.a + var.b
    "-" = var.a - var.b
    "*" = var.a * var.b
    "/" = var.a / var.b
  }
}

output "result" {
  value =  lookup(local.calculator, var.operand)
}