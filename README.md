# Puppet Core

This repository contains Terraform code to deploy a Puppet master and a configurable number of Puppet agent nodes in AWS. It's designed for quick provisioning of a basic Puppet-based configuration management environment, ideal for testing, development, or bootstrapping larger automation workflows.

> If using macOS to create the cloud-init data: macOS does not have `mkpasswd`. To create SHA of the local user password `docker run -it --rm alpine mkpasswd -m sha-512`

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.74.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.74.0 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_instance_state.puppet_master_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_instance_state) | resource |
| [aws_eip.puppet_master_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.puppet_master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.puppet_nodes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.puppet_master_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.puppet_node_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.user_data_nodes](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_cidrs"></a> [admin\_cidrs](#input\_admin\_cidrs) | List of CIDRs allowed to SSH | `list(string)` | `[]` | no |
| <a name="input_ami"></a> [ami](#input\_ami) | AMI ID to use for EC2 instances | `string` | n/a | yes |
| <a name="input_aws_account_name"></a> [aws\_account\_name](#input\_aws\_account\_name) | The AWS account alias (e.g. dev, prod) | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy resources in | `string` | `"us-east-1"` | no |
| <a name="input_hashed_password"></a> [hashed\_password](#input\_hashed\_password) | User's password hash (generate using: openssl passwd -6) | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type for the Puppet master | `string` | `"t2.large"` | no |
| <a name="input_node_instance_type"></a> [node\_instance\_type](#input\_node\_instance\_type) | EC2 instance type for Puppet nodes | `string` | `"t2.micro"` | no |
| <a name="input_private_subnet_id"></a> [private\_subnet\_id](#input\_private\_subnet\_id) | Private subnet ID (optional use) | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Prefix used for naming all project resources | `string` | n/a | yes |
| <a name="input_public_subnet_2_id"></a> [public\_subnet\_2\_id](#input\_public\_subnet\_2\_id) | Public subnet ID for Puppet nodes | `string` | n/a | yes |
| <a name="input_public_subnet_id"></a> [public\_subnet\_id](#input\_public\_subnet\_id) | Public subnet ID for primary instance | `string` | n/a | yes |
| <a name="input_puppet_cidrs"></a> [puppet\_cidrs](#input\_puppet\_cidrs) | List of CIDRs allowed to access Puppet port (8140) | `list(string)` | `[]` | no |
| <a name="input_puppet_nodes"></a> [puppet\_nodes](#input\_puppet\_nodes) | List of Puppet node suffixes to launch (e.g. ["node-01", "node-02"]) | `list(string)` | <pre>[<br>  "node-01",<br>  "node-02"<br>]</pre> | no |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | SSH public key for the user | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Local Linux username to create on the instances | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where resources will be deployed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eip-dns"></a> [eip-dns](#output\_eip-dns) | The dns name associated with the EC2 instance. |
| <a name="output_eip-ip"></a> [eip-ip](#output\_eip-ip) | The Elastic IP address associated with the EC2 instance. |
