data "template_file" "user_data" {
  template = file("${path.module}/cloud-init.yaml")

  vars = {
    hostname = "${var.project}-puppet-master-01"
    username = var.username
    ssh_key  = var.ssh_key
    passwd   = var.hashed_password
  }
}

resource "aws_instance" "puppet_master" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.puppet_master_sg.id]
  subnet_id              = var.public_subnet_id
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name              = "${var.project}-puppet-master-01"
    backup_exception  = "true"
    datadog_exception = "true"
  }
}

resource "aws_eip" "puppet_master_eip" {
  instance = aws_instance.puppet_master.id
  domain   = "vpc"
}

resource "aws_ec2_instance_state" "puppet_master_state" {
  instance_id = aws_instance.puppet_master.id
  state       = "running"
}

resource "aws_security_group" "puppet_master_sg" {
  name        = "${var.project}-puppet-sg"
  description = "Security group for Puppet Master"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.admin_cidrs
  }

  ingress {
    description = "Allow Puppet (port 8140)"
    from_port   = 8140
    to_port     = 8140
    protocol    = "tcp"
    cidr_blocks = var.puppet_cidrs
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
