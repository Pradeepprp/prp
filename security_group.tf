# Security Group for Public Subnet
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.main.id

  # Allow HTTP and HTTPS traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all IPs
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all IPs
  }

  # Outbound rules for Public SG
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]  # Allow all IPs
  }

  tags = {
    Name = "PublicSecurityGroup"
  }
}

# Data source to reference the Public Security Group in the Private SG
data "aws_security_group" "public_sg" {
  id = aws_security_group.public_sg.id
}

# Security Group for Private Subnet
resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.main.id

  # Allow traffic from the public security group using the data source
  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [data.aws_security_group.public_sg.id] # Use data source to get the Public SG ID
  }

  # Allow outbound traffic to the Internet via NAT Gateway
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]  # Allow all IPs
  }

  tags = {
    Name = "PrivateSecurityGroup"
  }
}