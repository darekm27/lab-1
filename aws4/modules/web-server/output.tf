output "server_ip" {
  value = formatlist(
    "%s - %s",
    aws_instance.app_server[*].tags["Name"],
    aws_instance.app_server[*].public_ip
  )
}