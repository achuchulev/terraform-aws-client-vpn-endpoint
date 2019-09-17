# Terraform module to create Client VPN Endpoint on AWS

## Prerequisites

- git
- terraform ( ~> 0.12 )
- AWS subscription

## How to use

#### Download and run following script to generate Server and Client Certificates and Keys

```
$ curl -o ./gen_acm_cert.sh https://raw.githubusercontent.com/achuchulev/terraform-aws-client-vpn-endpoint/master/scripts/gen_acm_cert.sh
$ chmod +x gen_acm_cert.sh
$ gen_acm_cert.sh <cert_dir> <domain>`
```

- Script will:
  - create private Certificate Authority (CA)
  - issue server certificate
  - issue client certificate

```
Note: this is based on [official AWS tutorial](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/authentication-authorization.html#mutual)
```

#### Create `terraform.tfvars` file

```
access_key = "your_aws_access_key"
secret_key = "your_aws_secret_key"
accepter_subnet_id = "subnet-xxxxxx"
```

#### Create `variables.tf` file

```
variable "access_key" {}
variable "secret_key" {}

variable "aws_region" {
  default = "us-east-1"
}

variable "cert_dir" {
  default = "vpn_certs"
}

variable "accepter_subnet_id" {}

variable "domain" {
  default = "example.com"
}
```

##### Inputs

| Name  |	Description |	Type |  Default |	Required
| ----- | ----------- | ---- |  ------- | --------
| aws_access_key | AWS access key | string  | -   | yes
| aws_secret_key | AWS secret key | string  | -   | yes
| aws_region | AWS region     | string  | yes | yes
| subnet-id | The ID of the subnet to associate with the Client VPN endpoint. | string  | -   | yes
| client_cidr_block | The IPv4 address range, in CIDR notation being /22 or greater, from which to assign client IP addresses | string  | `18.0.0.0/22` | no
| cert_dir | Some certificate directory name | string  | yes | no
| domain | Some domain name     | string  | yes | no

#### Create `main.tf` file

```
module "aws-client-vpn-test" {
  source = "git@github.com:achuchulev/terraform-aws-client-vpn-endpoint.git"

  aws_access_key     = var.access_key
  aws_secret_key     = var.secret_key
  aws_region         = var.aws_region
  accepter_subnet_id = var.accepter_subnet_id
}

```

### Initialize terraform and plan/apply

```
terraform init
terraform plan
terraform apply
```

- `Terraform apply` will:
  - upload server certificate to AWS Certificate Manager (ACM)
  - upload client certificate to AWS Certificate Manager (ACM)
  - create new Client VPN Endpoint on AWS 
  - make VPN network association with specified VPC subnet
  - authorize all clients vpn ingress
  - create new route to allow Internet access for VPN clients
  - export client config file

### Import client config file in your preffered vpn client

### Connect to VPN server

  ##### Outputs

| Name  |	Description 
| ----- | ----------- 
| client_vpn_endpoint_id | Client VPN Endpoint id
