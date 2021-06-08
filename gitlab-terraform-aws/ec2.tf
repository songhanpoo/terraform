
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# EC2 instance
resource "aws_instance" "main" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.dmz.id
  key_name               = var.ssh_key_name
  vpc_security_group_ids = [aws_security_group.base.id]
  private_ip             = var.main_instance_private_ip
}

resource "aws_security_group" "base" {
  name        = "Base SG"

  # Outbound HTTPS
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound HTTP
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self        = false
  }

  vpc_id = aws_vpc.main.id

}

# Elastic IP
resource "aws_eip" "main_eip" {
  vpc = true
}

resource "aws_eip_association" "main_eip_assoc" {
  instance_id   = aws_instance.main.id
  allocation_id = aws_eip.main_eip.id
}
