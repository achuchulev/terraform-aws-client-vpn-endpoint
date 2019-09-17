variable "aws_access_key" {
}

variable "aws_secret_key" {
}

variable "aws_region" {
  default = "us-east-1"
}

variable "client_cidr_block" {
  default = "18.0.0.0/22"
}

variable "subnet-id" {
}

variable "cert_dir" {
  default = "vpn_certs"
}

variable "domain" {
  default = "example.net"
}
