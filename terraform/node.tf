resource "aws_security_group" "puppet_node_sg" {
  name        = "${var.project}-puppet-node-sg"
  description = "Security group for Puppet nodes"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.admin_cidrs
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "template_file" "user_data_nodes" {
  count    = length(var.puppet_nodes)
  template = file("${path.module}/cloud-init.yaml")

  vars = {
    hostname = "${var.project}-puppet-${var.puppet_nodes[count.index]}"
    username = var.username
    ssh_key  = var.ssh_key
    passwd   = var.hashed_password
  }
}

resource "aws_instance" "puppet_nodes" {
  count                       = length(var.puppet_nodes)
  ami                         = var.ami
  instance_type               = var.node_instance_type
  subnet_id                   = var.public_subnet_2_id
  vpc_security_group_ids      = [aws_security_group.puppet_node_sg.id]
  associate_public_ip_address = true
  user_data                   = data.template_file.user_data_nodes[count.index].rendered

  tags = {
    Name              = "${var.project}-puppet-${var.puppet_nodes[count.index]}"
    backup_exception  = "true"
    datadog_exception = "true"
  }
}