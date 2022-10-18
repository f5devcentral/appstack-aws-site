## F5XC AppStack Edge Platform on AWS
### Objective
Spin up single node F5XC AppStack Edge Platform on AWS VPC with terraform.

## Requirements

Use the folloing command to extract .p12 certificate to an individual certificate and private key

> openssl pkcs12 -info -in \<tenant-name\>.console.ves.volterra.io.api-creds.p12 -out certificate.cert -nokeys

> openssl pkcs12 -info -in \<tenant-name\>.console.ves.volterra.io.api-creds.p12 -out private_key.key -nodes -nocerts

certificate.cert and private_key.key place in files folder.

## Terraform

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.9, != 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.3.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.0 |
| <a name="requirement_volterra"></a> [volterra](#requirement\_volterra) | 0.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.3.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |
| <a name="provider_volterra"></a> [volterra](#provider\_volterra) | 0.7.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route.ipv4_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.ipv6_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.volterra_ce](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [null_resource.wait_for_aws_mns](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [volterra_aws_vpc_site.this](https://registry.terraform.io/providers/volterraedge/volterra/0.7.1/docs/resources/aws_vpc_site) | resource |
| [volterra_cloud_credentials.aws](https://registry.terraform.io/providers/volterraedge/volterra/0.7.1/docs/resources/cloud_credentials) | resource |
| [volterra_tf_params_action.apply_aws_vpc](https://registry.terraform.io/providers/volterraedge/volterra/0.7.1/docs/resources/tf_params_action) | resource |
| [aws_instance.voltmesh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/instance) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_url"></a> [api\_url](#input\_api\_url) | n/a | `string` | `"https://<tenant-name>.console.ves.volterra.io/api"` | no |
| <a name="input_aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | AWS Access Key. Programmable API access key needed for creating the site | `string` | `"xxxxxxxxxxxxx"` | no |
| <a name="input_aws_az"></a> [aws\_az](#input\_aws\_az) | AWS Availability Zone in which the site will be created | `string` | `"<aws-zone>"` | no |
| <a name="input_aws_instance_type"></a> [aws\_instance\_type](#input\_aws\_instance\_type) | AWS instance type used for the Volterra site | `string` | `"t3.2xlarge"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region where Site will be created | `string` | `"<aws-region>"` | no |
| <a name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | AWS Secret Access Key. Programmable API secret access key needed for creating the site | `string` | `"<aws-secret>"` | no |
| <a name="input_aws_subnet_ce_cidr"></a> [aws\_subnet\_ce\_cidr](#input\_aws\_subnet\_ce\_cidr) | Map to hold different CE cidr with key as name of subnet | `map(string)` | <pre>{<br>  "outside": "\<aws-cidr\>/16"<br>}</pre> | no |
| <a name="input_aws_vpc_cidr"></a> [aws\_vpc\_cidr](#input\_aws\_vpc\_cidr) | AWS VPC CIDR, that will be used to create the vpc while creating the site | `string` | `"<aws-cidr>/16"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | CE Name. Also used as a prefix in names of related resources. | `string` | `"<appstack-name>"` | no |
| <a name="input_site_disk_size"></a> [site\_disk\_size](#input\_site\_disk\_size) | Disk size in GiB | `number` | `80` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | SSH Public Key | `string` | `"<ssh-public-key>"` | no |

## Outputs

No outputs.
