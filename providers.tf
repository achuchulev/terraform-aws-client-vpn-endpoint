provider "aws" {
  region = "${var.aws_region}"

  # Requester's credentials.
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}
