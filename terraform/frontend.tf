### VARIABLES ###

variable "web_ami" {}
variable "frontend_name" {}
variable "instance_size" {}

### INSTANCE ###

resource "aws_instance" "web" {
  ami             = "${var.web_ami}"
  instance_type   = "${var.instance_size}"
  subnet_id       = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.http.id}"]

  tags {
    Name = "${var.frontend_name}"
  }
}
