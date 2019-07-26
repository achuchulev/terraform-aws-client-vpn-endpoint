# Sample terraform code to create Client VPN Endpoint on AWS

## Prerequisites

- git
- terraform ( < 0.12.xx )
- AWS subscription

## How to use

### Clone the repo

```
git clone https://github.com/achuchulev/terraform-aws-client-vpn-endpoint.git
cd terraform-aws-client-vpn-endpoint
```

### Create `terraform.tfvars` file

#### Inputs

| Name  |	Description |	Type |  Default |	Required
| ----- | ----------- | ---- |  ------- | --------
| aws_access_key   | AWS access key | string  | -   | yes
| aws_secret_key   | AWS secret key | string  | -   | yes
| aws_region       | AWS region     | string  | yes | yes
| subnet-id   | AWS VPC subnet id | string  | -   | yes
| cert_dir | Some certificate directory name     | string  | yes | no
| domain | Some domain name     | string  | yes | no

### Issue self signed server and client sertificates

Run `scripts/gen_acm_cert.sh <cert_dir> <domain>`

Script will:
  - create private Certificate Authority (CA)
  - issue server certificate
  - issue client certificate

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

  #### Outputs

| Name  |	Description 
| ----- | ----------- 
| client_vpn_endpoint_id | Client VPN Endpoint id
