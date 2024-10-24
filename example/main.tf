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
    "10400",
    "10800",
    "3344"
  ]
  public_access_enable = true
  public_allowlist = [
    "18.223.124.60/32",
    "35.215.101.135/32",
    "172.31.0.0/16",
    "44.210.0.150/32",
    "54.175.25.77/32"
  ]

  ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXEEKQ57cASxh+s9C1WxHt4Yn6KVc/87rNhR+7ynXuMCMki3Xp4ZfIZO4gJL5xrMUvYMixR3+kZiiGfz/NcVTAoUHjfKxLrL9lgcAgUKr1MlDqxWSMt/wiqMQEHRIExrMY3tahE0JbOsrq4KdVFRb57p9+ar6znX4V2rs09uV7Awl17LEJiKdgvHeUDzVBwjQH5YnK0M/9rzwXenGVwEXI1spOEKojs6cZh0G+AezAhqlFb5eYenPTlSWxFCj5gnzhb+7RS7YR+Wf5ZvlleoWL1lhD4QimiUZIzNPTABtLNDVMrlQ/uNm7/E6AaJvQikdaoUs/ZGcfBpDisUieEEnK1POMPrfsz7l8bO0gjhQJWzrWxiZOl3dgQlWZ3cpduMf0KeLUpfM4XdZXcdsoWMqBlwQwxHLsLVTOz7RtoRBcwuX7RPF4vmk/Bwes8PAPdrFFUX0z/xM2Lxx2/AvndBd+k2BwDXGi3N5Nael1Mjm/xieh+JalbhLxpuZObbvHR9M="
  subnet_ids = local.subnet_ids
  vpc_id     = local.vpc_id
  ssm_enable = false

  gridgain_config = "{\n  \"deploy\": {\n    \"env\": \"st\",\n    \"venue\": \"cluster\",\n    \"cloud\": \"aws\",\n    \"account\": 705859261108,\n    \"layer\": \"base,nebula\",\n    \"target\": \"spoke,spoke\",\n    \"product\": \"nebula\",\n    \"customer\": \"shared\",\n    \"united_id\": \"us-east\",\n    \"cluster_id\": \"e48afc11-f0ee-450f-88e1-e67737d1a0ea\"\n  },\n  \"spoke_net\": {\n    \"vpc_bitmask\": 24,\n    \"tgw_bitmask\": 28,\n    \"pvt_bitmask\": 26\n  },\n  \"ggmc\": {\n    \"state\": \"running\",\n    \"product_ver\": \"8.8.20\",\n    \"ami_purpose\": \"nebula\",\n    \"ami_version\": \"gridgain-ultimate-8.8.20-v00.05\",\n    \"backend_api\": \"https://staging.gridgain-nebula-test.com/api/v1/\",\n    \"vault_addr\": \"https://vault.st.gridgain-nebula-test.com\",\n    \"vault_mount\": \"terra\",\n    \"subnet_type\": \"PVT\",\n    \"tls_client\": \"TLSv1.3,TLSv1.2\",\n    \"tls_https\": \"TLSv1.3,TLSv1.2\",\n    \"az_count\": 2,\n    \"node\": {\n      \"type\": \"t3.micro\",\n      \"count\": 5,\n      \"volumes\": [\n        {\n          \"name\": \"root\",\n          \"size\": \"U.GB\",\n          \"iops\": 4000\n        }\n      ]\n    },\n    \"config\": {\n      \"heap\": {\n        \"size\": \"7654\"\n      },\n      \"data\": {\n        \"default\": [\n          {\n            \"name\": \"default\",\n            \"size\": \"4000000000\",\n            \"persist\": true\n          }\n        ],\n        \"custom\": [\n          {\n            \"name\": \"region-1\",\n            \"size\": \"4000000000\",\n            \"persist\": true\n          }\n        ]\n      }\n    },\n    \"access\": {\n      \"users\": [\n        {\n          \"meta\": \"rover\",\n          \"email\": \"cm92ZXIK\",\n          \"login\": \"cm92ZXIK\",\n          \"password\": \"cm92ZXIK\"\n        },\n        {\n          \"meta\": \"api\",\n          \"email\": \"YXBpCg==\",\n          \"login\": \"YXBpCg==\",\n          \"password\": \"YXBpCg==\"\n        },\n        {\n          \"meta\": \"server\",\n          \"email\": \"c2VydmVyCg==\",\n          \"login\": \"c2VydmVyCg==\",\n          \"password\": \"c2VydmVyCg==\"\n        }\n      ]\n    },\n    \"encryption\": {\n      \"enabled\": true,\n      \"cmk_id\": \"customer-managed-kms-key-id\",\n      \"role_name\": \"nebula-shared-us-east-e48afc11-f0ee-450f-88e1-e67737d1a0ea-st-role\",\n      \"external_id\": \"some-id-uuid-for-example\"\n    }\n  },\n  \"public_access\": {\n    \"enabled\": true,\n    \"rules\": [\n      {\n        \"range\": \"10.0.0.0/8\",\n        \"ports\": [\n          10800,\n          443\n        ]\n      }\n    ]\n  },\n  \"private_link\": {\n    \"enabled\": true,\n    \"allowed_principals\": [\n      \"customer-account-id-1\",\n      \"customer-account-id-2\"\n    ]\n  }\n}\n"

  gridgain_ssl_cert = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUY0RENDQk1pZ0F3SUJBZ0lTQkJXb2czK1NRK3ppTCt1dHp6aEtIMlNRTUEwR0NTcUdTSWIzRFFFQkN3VUEKTURNeEN6QUpCZ05WQkFZVEFsVlRNUll3RkFZRFZRUUtFdzFNWlhRbmN5QkZibU55ZVhCME1Rd3dDZ1lEVlFRRApFd05TTVRFd0hoY05NalF4TURBeE1EUXhPVEExV2hjTk1qUXhNak13TURReE9UQTBXakErTVR3d09nWURWUVFECkV6TnVaV0oxYkdFdGMyaGhjbVZrTFhWekxXVmhjM1F0TVM1emRDNW5jbWxrWjJGcGJpMXVaV0oxYkdFdGRHVnoKZEM1amIyMHdnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCRHdBd2dnRUtBb0lCQVFDV3lTa1BWdWcyb3gvdAp1RHZKd2oxNHhNSlE1WjlwSWg4VWgxSTFZMHdaVGpUWm9hbWVrdiszQVI1cUlWTkNuV0hYVkZHNXBVaUtzcjc4CnEwbm9RZVVxYndRbWgrcklMY0lQWXp0WG1ENDNPd0lmdVRJaVhaOUNWNm9vQ0tIVkpoMWRtSjQwbkM1cmhTekQKR0JPYzJtc2NGK1NtRDNZQ1duQ2FEeDdwdm1iWEZmR2cxYk5FTzJqbUFoNWFwWVN5RWhlUDVWQ0I3UnRDODlOSgpOMTNoWVJCZDlFYytTWHJNaEN6OWhkZi9FanZlWjB2UngwWktvZXZzUGxKV1Q0LzEyU2kraDdsZjJvcWxaVlZICnJxNmpJUVNCNDRGNElkbnA5ZDg5U2ZPY0lhNmtZZjllY1hQOS9tQzRPYlZHa0RQMGFDaEZwN0pKMlYwbTdlaEYKa1FiV1JnNGRBZ01CQUFHamdnTGhNSUlDM1RBT0JnTlZIUThCQWY4RUJBTUNCYUF3SFFZRFZSMGxCQll3RkFZSQpLd1lCQlFVSEF3RUdDQ3NHQVFVRkJ3TUNNQXdHQTFVZEV3RUIvd1FDTUFBd0hRWURWUjBPQkJZRUZET0dXaHdVClZZMkNack9zTGxnZmVkdjJmQitUTUI4R0ExVWRJd1FZTUJhQUZNWFBScVRxOU1QQWVteVZ4QzJ3WHBJdkp1TzUKTUZjR0NDc0dBUVVGQndFQkJFc3dTVEFpQmdnckJnRUZCUWN3QVlZV2FIUjBjRG92TDNJeE1TNXZMbXhsYm1OeQpMbTl5WnpBakJnZ3JCZ0VGQlFjd0FvWVhhSFIwY0RvdkwzSXhNUzVwTG14bGJtTnlMbTl5Wnk4d2dlY0dBMVVkCkVRU0IzekNCM0lJMUtpNXVaV0oxYkdFdGMyaGhjbVZrTFhWekxXVmhjM1F0TVM1emRDNW5jbWxrWjJGcGJpMXUKWldKMWJHRXRkR1Z6ZEM1amIyMkNOeW91Ym1WaWRXeGhMWE5vWVhKbFpDMTFjeTFsWVhOMExURXVlQzV6ZEM1bgpjbWxrWjJGcGJpMXVaV0oxYkdFdGRHVnpkQzVqYjIyQ00yNWxZblZzWVMxemFHRnlaV1F0ZFhNdFpXRnpkQzB4CkxuTjBMbWR5YVdSbllXbHVMVzVsWW5Wc1lTMTBaWE4wTG1OdmJZSTFibVZpZFd4aExYTm9ZWEpsWkMxMWN5MWwKWVhOMExURXVlQzV6ZEM1bmNtbGtaMkZwYmkxdVpXSjFiR0V0ZEdWemRDNWpiMjB3RXdZRFZSMGdCQXd3Q2pBSQpCZ1puZ1F3QkFnRXdnZ0VFQmdvckJnRUVBZFo1QWdRQ0JJSDFCSUh5QVBBQWRnQS9GMHRQMXlKSFdKUWRaUnlFCnZnMFM3WkEzZngrRmF1dkJ2eWlGN1Boa2JnQUFBWkpHZ3pJc0FBQUVBd0JITUVVQ0lRREpMeTVORmVVNHB4bDEKTG8vRVhsMWVMZllkbGRFWFJoNmwySkxIbGE1cEZBSWdhQ3lrRFU0Q3l0WHpmZmhBaHIvM1Nlb3FjaG5SMkRaUQpRbGJtL3hGY3NzVUFkZ0IyLzRnL0NyYjdsVkhDWWN6MWg3bzB0S1ROdXluY2FFSUtuK1puVEZvNmRBQUFBWkpHCmd6SjBBQUFFQXdCSE1FVUNJRXNBYzVsQUF3bzNESmw0QUhPS2JYZWNnbW1Ubk9KaEQxYmlQOHJBaDVzZkFpRUEKdmRtTDZpZ0krU2x1VElpQVY4Yi9pUU1RRDNHdUpuVzc1NURISU9ja3RNSXdEUVlKS29aSWh2Y05BUUVMQlFBRApnZ0VCQUMyYUIwYUJ1M3JicVljZXVrMy9NbTgvUktzNWlaODUzeXhPaEwwZmo1SG96d2xHYWdQSnBpZ0d0Nm4vCkVKM2FVNzRScHhZUUdIZDJFOHpnRXpxZ25HSmU0cHRrSzRGeWFZWDh6S1RPUW1HZlFoYkxRNFFBUkJyMGZwbVQKc1dsWWRteHlOZ2NVeVIxdGlaMDBtSmh1emhCQXA3RzgwbnNaUkhrT2ErK3c2NTR1Nmo2Vi84MjZCdTBlRUREMAp5b2Y5dUhzVG1uY1A3V2ZVSStjOXV1emFVQ2I4QWRQb0NlNlQ0NzkzYWJlbW1HN0t4bGs1Z3BHRFNtVlorMWZPCjM5UGY5empveHBTbWtKTDZxdlltWFI4Q2xhU1pFNkk5YjhML1BkWXpaQ05TWmxibC90UlFTREZHbFhrL3RSVDcKRWpueEJISUdYeG1Wb2psTHJtdytZVnNzSExZPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCgotLS0tLUJFR0lOIENFUlRJRklDQVRFLS0tLS0KTUlJRkJqQ0NBdTZnQXdJQkFnSVJBSXA5UGhQV0x6RHZJNGE5S1Fkck5QZ3dEUVlKS29aSWh2Y05BUUVMQlFBdwpUekVMTUFrR0ExVUVCaE1DVlZNeEtUQW5CZ05WQkFvVElFbHVkR1Z5Ym1WMElGTmxZM1Z5YVhSNUlGSmxjMlZoCmNtTm9JRWR5YjNWd01SVXdFd1lEVlFRREV3eEpVMUpISUZKdmIzUWdXREV3SGhjTk1qUXdNekV6TURBd01EQXcKV2hjTk1qY3dNekV5TWpNMU9UVTVXakF6TVFzd0NRWURWUVFHRXdKVlV6RVdNQlFHQTFVRUNoTU5UR1YwSjNNZwpSVzVqY25sd2RERU1NQW9HQTFVRUF4TURVakV4TUlJQklqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQ0FROEFNSUlCCkNnS0NBUUVBdW9lOFhCc0FPY3ZLQ3MzVVp4RDVBVHlsVHFWaHl5YktVdnNWQWJlNUtQVW9IdTBuc3lRWU9XY0oKREFqczREcXdPM2NPdmZQbE9WUkJERTZ1UWRhWmRONVIyKzk3LzFpOXFMY1Q5dDR4MWZKeXlYSnFDNE4wbFp4RwpBR1FVbWZPeDJTTFp6YWlTcWh3bWVqLys3MWdGZXdpVmdkdHhENDc3NHpFSnV3bStVRTFmajVGMlBWcWRub1B5CjZjUm1zK0VHWmtOSUdJQmxvRGNZbXB1RU1wZXhzcjNFK0JVQW5TZUkrK0pqRjVac215ZG5TOFRiS0Y1cHdubncKU1Z6Z0pGRGh4THloQmF4N1FHMEF0TUpCUDZkWXVDL0ZYSnVsdXdtZThmN3JzSVU1L2FnSzcwWEVlT3RsS3NMUApYenplNDF4TkcvY0xKeXVxQzBKM1UwOTVhaDJIMlFJREFRQUJvNEg0TUlIMU1BNEdBMVVkRHdFQi93UUVBd0lCCmhqQWRCZ05WSFNVRUZqQVVCZ2dyQmdFRkJRY0RBZ1lJS3dZQkJRVUhBd0V3RWdZRFZSMFRBUUgvQkFnd0JnRUIKL3dJQkFEQWRCZ05WSFE0RUZnUVV4YzlHcE9yMHc4QjZiSlhFTGJCZWtpOG00N2t3SHdZRFZSMGpCQmd3Rm9BVQplYlJaNW51MjVlUUJjNEFJaU1nYVdQYnBtMjR3TWdZSUt3WUJCUVVIQVFFRUpqQWtNQ0lHQ0NzR0FRVUZCekFDCmhoWm9kSFJ3T2k4dmVERXVhUzVzWlc1amNpNXZjbWN2TUJNR0ExVWRJQVFNTUFvd0NBWUdaNEVNQVFJQk1DY0cKQTFVZEh3UWdNQjR3SEtBYW9CaUdGbWgwZEhBNkx5OTRNUzVqTG14bGJtTnlMbTl5Wnk4d0RRWUpLb1pJaHZjTgpBUUVMQlFBRGdnSUJBRTdpaVYwS0F4eVFPTkQxSC9seFhQakRqN0kzaUhwdnNDVWY3YjYzMklZR2p1a0poTTF5CnY0SHovTXJQVTBqdHZmWnBRdFNsRVQ0MXlCT3lraDBGWCtvdTFOajRTY090OVptV25POG0yT0cwSkF0SUlFMzgKMDFTMHFjWWh5T0UyRy85M1pDa1h1ZkJMNzEzcXpYblF2NUMvdmlPeWtOcEtxVWd4ZEtsRUMrSGk5aTJEY2FSMQplOUtVd1FVWlJoeTVqL1BFZEVnbEtnM2w5ZHRENHR1VG03a1p0Qjh2MzJvT2p6SFRZdys3S2R6ZFppdy9zQnRuClVmaEJQT1JOdWF5NHBKeG1ZL1dyaFNNZHpGTzJxM0d1M01VQmNkbzI3Z29ZS2pMOUNURjhqL1p6NTV5Y3RVb1YKYW5lQ1dzL2FqVVgrSHlwa0JUQStjOExHRExuV08yTktxMFlEL3BuQVJrQW5ZR1BmVURvSFI5Z1ZTcC9xUngrWgpXZ2hpRExac013aE4xemp0U0MwdUJXaXVnRjN2VE56WUlFRmZhUEc3V3MzakRyQU1NWWViUTk1SlErSElCRC9SClBCdUhSVEJwcUtseURua1NIREhZUGlOWDNhZFBvUEFjZ2RGM0gyL1cwcm1vc3dNV2dUbExuMVd1MG1ya3M3L3EKcGRXZlM2UEoxanR5ODByMlZLc00vRGozWUlEZmJqWEtkYUZVNUMrOGJoZkpHcVUzdGFLYXV1ejB3SFZHVDNlbwo2RmxXa1dZdGJ0NHBnZGFtbHdWZVpFVytMTTdxWkVKRXNNTlByZkMwM0FQS21ac0pncFdDRFdPS1p2a1pjdmpWCnVZa1E0b21ZQ1RYNW9oeStrbk1qZE9tZEg5YzdTcHFFV0JEQzg2ZmlOZXgrTzBYT01FWlNhOERBCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
  gridgain_ssl_key  = "LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUV2QUlCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktZd2dnU2lBZ0VBQW9JQkFRQ1d5U2tQVnVnMm94L3QKdUR2SndqMTR4TUpRNVo5cEloOFVoMUkxWTB3WlRqVFpvYW1la3YrM0FSNXFJVk5DbldIWFZGRzVwVWlLc3I3OApxMG5vUWVVcWJ3UW1oK3JJTGNJUFl6dFhtRDQzT3dJZnVUSWlYWjlDVjZvb0NLSFZKaDFkbUo0MG5DNXJoU3pECkdCT2MybXNjRitTbUQzWUNXbkNhRHg3cHZtYlhGZkdnMWJORU8yam1BaDVhcFlTeUVoZVA1VkNCN1J0Qzg5TkoKTjEzaFlSQmQ5RWMrU1hyTWhDejloZGYvRWp2ZVowdlJ4MFpLb2V2c1BsSldUNC8xMlNpK2g3bGYyb3FsWlZWSApycTZqSVFTQjQ0RjRJZG5wOWQ4OVNmT2NJYTZrWWY5ZWNYUDkvbUM0T2JWR2tEUDBhQ2hGcDdKSjJWMG03ZWhGCmtRYldSZzRkQWdNQkFBRUNnZ0VBRlBrb2hxdHdNODlYVE5YRUxURmhJd2Y5UGtyZU5EMnNoSXE1QnRlSHVYcGQKRkF0dVFESVNzd1lMRUxpUGIvUGJyTnViM1g1dHUyc1c4U2F6S2tUbUp4T1hpSE45MXZlMFp6Y0doVTNXRTVFWAozOGsrL2JRM2gzOFJtaTF2TXlwd3liakZncXhac1pkdHpUb3ZXakV3VmxGRmVzcXFQN1FNTndXVTUyN1dONkx0Ck5XN3dPQUNlaTFxcjc0Si9BUVUweThGL2FNQzl2Q2pEdzA3cFFselU2SmNBV05JT1YvN21WdDVLWnFoS01lYXcKWHZTUS92MFZiN3RDYk40clZpUkdBSmRYT3A4VitsUERqKzEwcVAzZ3BhSllaK01iWHlwdTBaMlNXdzV2ZmpWTAovZ2tHaDFpR2M2ejVPd3pBdVVlVU9VZzhjZHorTHlQQkZOTjdIdk5DQVFLQmdRQzNNR2V1NndBK3prL1NsSmNuCklZdjF3T1JwTzhRRDl5QVJTWk5ZQzBETWJNMUQ1QlZoRUV4emlMRHkvZndsMTVUdVp0eUZUbDVjQjV5bUI1dTkKZWZiOFZGRldMcnFQd0ZwaFVMZWZUOGFoNTJhcnoxejFiT1FETi9WNmZDUDJvYmQ0OXM1MGpyNHk2UCt1UVozSQprU01xQ1N1cGxQcTFlMGJZSm5PaGM4YXlBUUtCZ1FEU3Q3TnhDaHFpdTJOQzlSckJ3RW1sV0RzdHRzR1J4U1dhCkJTQklSaFBSSURPUG9oMEtJR0pDM0RrNHNaNkwrSktmVDV1WWMrT3NnOTlHdmFEdi8ycFdrbGtNR1loOU42OWUKbXdOUTFNOFBhZHJMQmZFbXlSVWxTQnVuak00NHVkdndYRlVybGNlSUt6T1NKbkdZQ0VBTEdHUkJVZENYUjd2cwpNWnNjdkR2a0hRS0JnQ1FEYkI3RExHVXNnaHpRQVhjNzdSdi9NK2hNUzVqTCtJM3RmUDRPR0VzWUNMS1VJRy9ZCm1HOE9MRnRZK3owbFNLNGxvcXpDWDJLUVRJZUhiMktzbTVXM3JkWFhrZTI0end2YXBuNjNYRUZ3RUlzdVZRUWEKeUNpcDA2U2t5eDB0WmJodUxPQlZQNmNhajBsZXRQbzlMa0NSVlBnZHhidnY1Rm1TRmFGajlXZ0JBb0dBRWJqeApscWhLNVRUdGZFd3hHK3FZUnhmTW9tT2tsQ1lJcTVPU3k0RlpXVlZrQU1pWnVLaFFtMTc2VVJKZlMxWjB2b0ZyCmpMN3lmeWY0TjNMcmZrUDFKYUxaYW5NYlQ2ekhTeVd1ZWJYc1ZGZUsxMWlBbDhxQnhNanp5bnZGUEhBbFYybnMKbitYUkNsclgwNHI0TXRrK3liQWJmb0xyRUU0d09BVlVEbTZtZXVFQ2dZQk80T01UejBqVENmYVVTMkdIUDh0SQpnWmV1M0crS0Y3SzRlNTIwdTJSM3YrLzhOcWJvOHEvOXhEWk1pVllXN2xZUDY3L1R2NDI2djBBM1VmUkRqZmovCnZlK2lLd3hhSnVoWUFzSG1UOURLVDJqV1lUU3I5bHVUK2FlZi9hdGZnMWdtelppclpwNzl3MisyeGRJUUg1YTAKeFhVV3p4WEQramlFbTBUdmZZVWhWZz09Ci0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0K"
  keystore_password="H3pmbA8sAbbaatqC"

  cluster_url = "makalis-gg9-a.nebula-shared-us-east-1.st.gridgain-nebula-test.com"

  zones = local.zones

  ssl_enable = true

  tags = local.tags
}

# URL: https://makalis-gg9-a.nebula-shared-us-east-1.st.gridgain-nebula-test.com:10400
# Client connections: makalis-gg9-a-4666dfea9735c0fd.elb.us-east-1.amazonaws.com:10800
# SSL Enabled: true
# Credentials: server/server