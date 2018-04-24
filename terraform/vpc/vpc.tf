terraform {
  backend "local" {}
}

### VARIABLES ###

variable "region" {}
variable "vpc_name" {}
variable "base_network" {}
variable "public_networks" {}

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

### SUBNETS ###

resource "aws_subnet" "public-subnet" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${var.public_networks}"
  map_public_ip_on_launch = "true"

  tags {
    Name = "Public - ${var.public_networks}"
  }
}

### ROUTES TABLES ###

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.vpc_name}-IGW"
  }
}

### OUTPUTS ###

output "region" {
  value = "${var.region}"
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}
