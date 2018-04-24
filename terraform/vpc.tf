### VARIABLES ###

variable "region" {}
variable "vpc_name" {}
variable "base_network" {}
variable "public_networks" {}

### VPC ###

resource "aws_vpc" "main" {
  cidr_block = "${var.base_network}"

  tags {
    Name = "${var.vpc_name}"
  }
}

### SUBNETS ###

resource "aws_subnet" "public" {
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

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "${var.vpc_name} public route"
  }
}

resource "aws_route_table_association" "rtap" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}

### SECURITY GROUPS ###

resource "aws_security_group" "http" {
  depends_on  = ["aws_vpc.main"]
  name        = "${var.vpc_name}-http"
  description = "Allow all http from everyone"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.vpc_name}-http"
  }
}
