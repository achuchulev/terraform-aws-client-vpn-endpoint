givariable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-east-1"
}

variable "subnet-id" {
  default = "subnet-0ec213e288c498e14"
}

variable "cert_dir" {
  default = "vpn_certs"
}

variable "domain" {
  default = "example.net"
}
