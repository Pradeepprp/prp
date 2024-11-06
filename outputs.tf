# Outputs
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}

output "private_subnet_3_id" {
  value = aws_subnet.private_subnet_3.id
}

output "vpn_gateway_id" {
  value = aws_vpn_gateway.vpn.id
}

output "customer_gateway_id" {
  value = aws_customer_gateway.example.id
}

output "vpn_connection_id" {
  value = aws_vpn_connection.example.id
}
/*
output "route53_zone_id" {
  value = aws_route53_zone.main.zone_id
}
*/



# Output for Public Security Group ID
output "public_security_group_id" {
  value = aws_security_group.public_sg.id
  description = "ID of the Public Security Group"
}

# Output for Private Security Group ID
output "private_security_group_id" {
  value = aws_security_group.private_sg.id
  description = "ID of the Private Security Group" 
  }