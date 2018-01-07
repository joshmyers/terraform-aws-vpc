# Define composite variables for resources
module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.2.1"
  namespace  = "${var.namespace}"
  name       = "${var.name}"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
}

resource "aws_vpc" "default" {
  cidr_block                       = "${var.cidr_block}"
  instance_tenancy                 = "${var.instance_tenancy}"
  enable_dns_hostnames             = "${var.enable_dns_hostnames}"
  enable_dns_support               = "${var.enable_dns_support}"
  enable_classiclink               = "${var.enable_classiclink}"
  assign_generated_ipv6_cidr_block = "${var.assign_generated_ipv6_cidr_block}"
  tags                             = "${module.label.tags}"
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
  tags   = "${module.label.tags}"
}
