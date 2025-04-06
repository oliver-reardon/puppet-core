# --------------------
# AWS Environment
# --------------------
variable "aws_account_name" {
  description = "The AWS account alias (e.g. dev, prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

# --------------------
# Networking
# --------------------
variable "vpc_id" {
  description = "VPC ID where resources will be deployed"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for primary instance"
  type        = string
}

variable "public_subnet_2_id" {
  description = "Public subnet ID for Puppet nodes"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID (optional use)"
  type        = string
}

variable "admin_cidrs" {
  description = "List of CIDRs allowed to SSH"
  type        = list(string)
  default     = []
}

variable "puppet_cidrs" {
  description = "List of CIDRs allowed to access Puppet port (8140)"
  type        = list(string)
  default     = []
}

# --------------------
# EC2 Configuration
# --------------------
variable "ami" {
  description = "AMI ID to use for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the Puppet master"
  type        = string
  default     = "t2.large"
}

variable "node_instance_type" {
  description = "EC2 instance type for Puppet nodes"
  type        = string
  default     = "t2.micro"
}

# --------------------
# Puppet Nodes
# --------------------
variable "puppet_nodes" {
  description = "List of Puppet node suffixes to launch (e.g. [\"node-01\", \"node-02\"])"
  type        = list(string)
  default     = ["node-01", "node-02"]
}

# --------------------
# User Access
# --------------------
variable "username" {
  description = "Local Linux username to create on the instances"
  type        = string
}

variable "ssh_key" {
  description = "SSH public key for the user"
  type        = string
}

variable "hashed_password" {
  description = "User's password hash (generate using: openssl passwd -6)"
  type        = string
}

# --------------------
# General Project Info
# --------------------
variable "project" {
  description = "Prefix used for naming all project resources"
  type        = string
}
