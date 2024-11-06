provider "aws" {
  region = "us-east-1"  
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "MainVPC"
  }
}

# Create a VPN Gateway
resource "aws_vpn_gateway" "vpn" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MainVPNGateway"
  }
}

# Create a Customer Gateway (if needed)
resource "aws_customer_gateway" "example" {
  bgp_asn    = 65000
  ip_address = "203.0.113.12"  # Replace with your on-premises static IP
  type       = "ipsec.1"

  tags = {
    Name = "CustomerGateway"
  }
}

# Create a VPN Connection. The below VPN connection is used to establish a secure tunnel between AWS environment(via a VPN Gateway) and on-premises network(via the Customer Gateway)
resource "aws_vpn_connection" "example" {
  vpn_gateway_id      = aws_vpn_gateway.vpn.id
  customer_gateway_id = aws_customer_gateway.example.id
  type                = "ipsec.1"

  tags = {
    Name = "VPNConnection"
  }
}
/*
# Create a Route 53 Hosted Zone
resource "aws_route53_zone" "main" {
  name = "example.com"  # Replace with your domain name

  tags = {
    Name = "MainRoute53Zone"
  }
}
*/
