terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.46"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = local.region
}

locals {
  name   = "makalis-gg9-terraform"
  region = "us-east-1"

  ami_id        = "ami-0691d9b7a0c2878d7"
  instance_type = "t3.medium"

  vpc_id       = "vpc-0b7e98bfdd1d6a5d7"
  subnet_ids = ["subnet-078524394ba9c96b2", "subnet-005b4a2ee9ed8db28"]

  zones = ["us-east-1b", "us-east-1c"]

  tags = {
    Name = "makalis-gg9-terraform"
  }
}

module "ec2_instance" {
  source = "../"

  ami_id        = local.ami_id
  fullname      = local.name
  name          = local.name
  instance_type = local.instance_type

  gridgain_version = "9.0.7"
  nodes_count = 2
  ports = [
    "22",
    "10300",
    "10800",
    "3344"
  ]
  public_access_enable = true
  public_allowlist = [
    "18.223.124.60/32",
    "35.215.101.135/32",
    "172.31.0.0/16"
  ]

  ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXEEKQ57cASxh+s9C1WxHt4Yn6KVc/87rNhR+7ynXuMCMki3Xp4ZfIZO4gJL5xrMUvYMixR3+kZiiGfz/NcVTAoUHjfKxLrL9lgcAgUKr1MlDqxWSMt/wiqMQEHRIExrMY3tahE0JbOsrq4KdVFRb57p9+ar6znX4V2rs09uV7Awl17LEJiKdgvHeUDzVBwjQH5YnK0M/9rzwXenGVwEXI1spOEKojs6cZh0G+AezAhqlFb5eYenPTlSWxFCj5gnzhb+7RS7YR+Wf5ZvlleoWL1lhD4QimiUZIzNPTABtLNDVMrlQ/uNm7/E6AaJvQikdaoUs/ZGcfBpDisUieEEnK1POMPrfsz7l8bO0gjhQJWzrWxiZOl3dgQlWZ3cpduMf0KeLUpfM4XdZXcdsoWMqBlwQwxHLsLVTOz7RtoRBcwuX7RPF4vmk/Bwes8PAPdrFFUX0z/xM2Lxx2/AvndBd+k2BwDXGi3N5Nael1Mjm/xieh+JalbhLxpuZObbvHR9M="
  subnet_ids = local.subnet_ids
  vpc_id     = local.vpc_id
  ssm_enable = false

  gridgain_config = "{\n  \"deploy\": {\n    \"env\": \"st\",\n    \"venue\": \"cluster\",\n    \"cloud\": \"aws\",\n    \"account\": 705859261108,\n    \"layer\": \"base,nebula\",\n    \"target\": \"spoke,spoke\",\n    \"product\": \"nebula\",\n    \"customer\": \"shared\",\n    \"united_id\": \"us-east\",\n    \"cluster_id\": \"e48afc11-f0ee-450f-88e1-e67737d1a0ea\"\n  },\n  \"spoke_net\": {\n    \"vpc_bitmask\": 24,\n    \"tgw_bitmask\": 28,\n    \"pvt_bitmask\": 26\n  },\n  \"ggmc\": {\n    \"state\": \"running\",\n    \"product_ver\": \"8.8.20\",\n    \"ami_purpose\": \"nebula\",\n    \"ami_version\": \"gridgain-ultimate-8.8.20-v00.05\",\n    \"backend_api\": \"https://staging.gridgain-nebula-test.com/api/v1/\",\n    \"vault_addr\": \"https://vault.st.gridgain-nebula-test.com\",\n    \"vault_mount\": \"terra\",\n    \"subnet_type\": \"PVT\",\n    \"tls_client\": \"TLSv1.3,TLSv1.2\",\n    \"tls_https\": \"TLSv1.3,TLSv1.2\",\n    \"az_count\": 2,\n    \"node\": {\n      \"type\": \"t3.micro\",\n      \"count\": 5,\n      \"volumes\": [\n        {\n          \"name\": \"root\",\n          \"size\": \"U.GB\",\n          \"iops\": 4000\n        }\n      ]\n    },\n    \"config\": {\n      \"heap\": {\n        \"size\": \"U.Bytes\"\n      },\n      \"data\": {\n        \"default\": [\n          {\n            \"name\": \"default\",\n            \"size\": \"U.Bytes\",\n            \"persist\": true\n          }\n        ],\n        \"custom\": [\n          {\n            \"name\": \"region-1\",\n            \"size\": \"U.Bytes\",\n            \"persist\": true\n          }\n        ]\n      }\n    },\n    \"access\": {\n      \"users\": [\n        {\n          \"meta\": \"rover\",\n          \"email\": \"cm92ZXIK\",\n          \"login\": \"cm92ZXIK\",\n          \"password\": \"cm92ZXIK\"\n        },\n        {\n          \"meta\": \"api\",\n          \"email\": \"YXBpCg==\",\n          \"login\": \"YXBpCg==\",\n          \"password\": \"YXBpCg==\"\n        },\n        {\n          \"meta\": \"server\",\n          \"email\": \"c2VydmVyCg==\",\n          \"login\": \"c2VydmVyCg==\",\n          \"password\": \"c2VydmVyCg==\"\n        }\n      ]\n    },\n    \"encryption\": {\n      \"enabled\": true,\n      \"cmk_id\": \"customer-managed-kms-key-id\",\n      \"role_name\": \"nebula-shared-us-east-e48afc11-f0ee-450f-88e1-e67737d1a0ea-st-role\",\n      \"external_id\": \"some-id-uuid-for-example\"\n    }\n  },\n  \"public_access\": {\n    \"enabled\": true,\n    \"rules\": [\n      {\n        \"range\": \"10.0.0.0/8\",\n        \"ports\": [\n          10800,\n          443\n        ]\n      }\n    ]\n  },\n  \"private_link\": {\n    \"enabled\": true,\n    \"allowed_principals\": [\n      \"customer-account-id-1\",\n      \"customer-account-id-2\"\n    ]\n  }\n}\n"
  gridgain_license = "stub"
  zones = local.zones

  tags = local.tags
}