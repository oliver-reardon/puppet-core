output "eip-dns" {
  value       = aws_eip.puppet-master-eip.public_dns
  description = "The dns name associated with the EC2 instance."
}

output "eip-ip" {
  value       = aws_eip.puppet-master-eip.private_ip
  description = "The Elastic IP address associated with the EC2 instance."
}
