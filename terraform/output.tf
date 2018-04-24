### VPC ###

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "public_subnets" {
  value = "${aws_subnet.public.id}"
}

output "sg_http" {
  value = "${aws_security_group.http.id}"
}

### FRONTEND ###

output "web_public_ip" {
  value = "${aws_instance.web.public_ip}"
}

output "web_private_ip" {
  value = "${aws_instance.web.private_ip}"
}
