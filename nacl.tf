# network_acl.tf

resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MainNACL"
  }
}

resource "aws_network_acl_rule" "allow_http" {
  network_acl_id = aws_network_acl.main.id
  rule_number     = 100
  egress          = false
  protocol        = "tcp"
  rule_action     = "allow"
  cidr_block      = "0.0.0.0/0"
  from_port       = 80
  to_port         = 80
}

resource "aws_network_acl_rule" "allow_https" {
  network_acl_id = aws_network_acl.main.id
  rule_number     = 101
  egress          = false
  protocol        = "tcp"
  rule_action     = "allow"
  cidr_block      = "0.0.0.0/0"
  from_port       = 443
  to_port         = 443
}

resource "aws_network_acl_rule" "allow_outbound" {
  network_acl_id = aws_network_acl.main.id
  rule_number     = 100
  egress          = true
  protocol        = "-1"  # All protocols
  rule_action     = "allow"
  cidr_block      = "0.0.0.0/0"
  from_port       = 0
  to_port         = 0
}

resource "aws_network_acl_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  network_acl_id = aws_network_acl.main.id
}

resource "aws_network_acl_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  network_acl_id = aws_network_acl.main.id
}

resource "aws_network_acl_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  network_acl_id = aws_network_acl.main.id
}

resource "aws_network_acl_association" "private_subnet_3_association" {
  subnet_id      = aws_subnet.private_subnet_3.id
  network_acl_id = aws_network_acl.main.id
}

output "nacl_id" {
  value = aws_network_acl.main.id
}
