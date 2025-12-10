Create VPC

# INPUT
cidr = "10.0.0.0/16"
public_ip_on_launch = true
tags
subnets ["10.0.1.0/24", "10.0.2.0/24"] (prywatne)

# OUTPUT
vpc_id
