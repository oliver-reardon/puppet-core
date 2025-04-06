locals {
  base_tags = {
    application       = "puppet-master"
    application_owner = "config-team"
    account_team      = "infra"
    aws_account_name  = var.aws_account_name
    contact           = "devops@example.com"
    cost              = "opex"
    operations_owner  = "platform"
    org               = "example-org"
    repo              = "puppet-core"
    terraformed       = "true"
  }
}
