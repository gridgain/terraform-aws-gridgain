
provider "aws" {
  region = "us-east-1"
}

module "gridgain" {
  source = "../"

  nodes_count          = 1
  ami_id               = "ami-XXXXXXXXXXXXXXXXX"
  public_access_enable = true
  tags = {
    Reason = "Test Gridgain Terraform AWS module"
  }
  ssh_public_key         = "XXXXXXXXXXXXXXXXXXXXXXX"
  cloudwatch_logs_enable = true

  # gridgain_license  = file("files/license.xml")
  gridgain_config       = file("files/server.xml")
  gridgain_ssl_cert     = file("files/server.crt")
  gridgain_ssl_key      = file("files/server.key")
  gridgain_jetty_config = file("files/jetty.xml")
  keystore_password     = "XXXXXXXXXXXXXX"

  s3_enable  = true
  ssm_enable = true
  ssl_enable = true
}


terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
