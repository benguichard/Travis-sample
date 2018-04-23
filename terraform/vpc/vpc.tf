terraform {
  backend "local" {}
}

### VARIABLES ###

variable "region" {}
variable "vpc_name" {}
variable "base_network" {}
variable "public_networks" {}
variable "private_networks" {}

### PROVIDER ###

provider "aws" {
  region = "${var.region}"
}

### VPC ###

resource "aws_vpc" "main" {
  cidr_block = "${var.base_network}"

  tags {
    Name = "${var.vpc_name}"
  }
}

### OUTPUTS ###

output "region" {
  value = "${var.region}"
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}
