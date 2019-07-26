givariable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-east-1"
}

variable "subnet-id" {}

variable "cert_dir" {
  default = "vpn_certs"
}

variable "domain" {
  default = "example.net"
}
