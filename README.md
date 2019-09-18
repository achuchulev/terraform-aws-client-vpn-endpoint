# Terraform module to create Client VPN Endpoint on AWS

## Prerequisites

- git
- terraform ( ~> 0.12 )
- AWS subscription
- VPC with Internet GW and a subnet having route assosiated with the IGW (i.e a public subnet)

## How to use

#### Create `terraform.tfvars` file

```
access_key = "your_aws_access_key"
secret_key = "your_aws_secret_key"
subnet_id  = "subnet-xxxxxx"
domain     = "your.domain"
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

variable "subnet_id" {}

variable "domain" {
  default = "example.com"
}
```

##### Inputs

| Name  |	Description |	Type |  Default |	Required
| ----- | ----------- | ---- |  ------- | --------
| aws_access_key | AWS access key | string  | - | yes
| aws_secret_key | AWS secret key | string  | - | yes
| aws_region | AWS region | string  | yes | yes
| subnet_id | The ID of the subnet to associate with the Client VPN endpoint. | string  | - | yes
| client_cidr_block | The IPv4 address range, in CIDR notation being /22 or greater, from which to assign client IP addresses | string  | `18.0.0.0/22` | no
| cert_dir | Some certificate directory name | string | yes | no
| domain | Some domain name | string  | yes | no


#### Create `main.tf` file

```
module "aws-client-vpn" {
  source = "git@github.com:achuchulev/terraform-aws-client-vpn-endpoint.git"

  aws_access_key = var.access_key
  aws_secret_key = var.secret_key
  aws_region     = var.aws_region
  subnet_id      = var.accepter_subnet_id
  domain         = var.domain
}

```

### Initialize terraform 

```
terraform init
```

#### Generate Server and Client Certificates and Keys

Run `$ .terraform/modules/aws-client-vpn/scripts/gen_acm_cert.sh ./<cert_dir> <domain>`

- Script will:
  - make a `cert_dir` in the root
  - create private Certificate Authority (CA)
  - issue server certificate chain
  - issue client certificate chain
  
Note: This is based on official AWS tutorial described [here](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/authentication-authorization.html#mutual)

### Deploy Client VPN

```
$ terraform plan
$ terraform apply
```

- `Terraform apply` will:
  - upload server certificate to AWS Certificate Manager (ACM)
  - upload client certificate to AWS Certificate Manager (ACM)
  - create new Client VPN Endpoint on AWS 
  - make VPN network association with specified VPC subnet
  - authorize all clients vpn ingress
  - create new route to allow Internet access for VPN clients
  - export client config file `client-config.ovpn` in the root

##### Outputs

| Name  |	Description 
| ----- | ----------- 
| client_vpn_endpoint_id | Client VPN Endpoint id


### Import client config file in your preffered vpn client and connect
