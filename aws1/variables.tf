variable "tags_to_ignore" {
  type    = list(string)
  default = ["department"]
}

# Global public access switch
variable "is_public" {
  type    = bool
  default = false
}
