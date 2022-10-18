resource "aws_vpc" "this" {
  cidr_block                       = var.aws_vpc_cidr
  assign_generated_ipv6_cidr_block = false
  enable_dns_support               = true
  enable_dns_hostnames             = true
  tags = {
    "Name"                                         = var.prefix
    "usecase"                                      = "edge-platform"
    format("kubernetes.io/cluster/%s", var.prefix) = "shared"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name"    = var.prefix
    "usecase" = "edge-platform"
  }
}

resource "aws_route" "ipv6_default" {
  route_table_id              = aws_vpc.this.main_route_table_id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.this.id
  lifecycle {
    ignore_changes = [
      route_table_id
    ]
  }
}

resource "aws_route" "ipv4_default" {
  route_table_id         = aws_vpc.this.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
  lifecycle {
    ignore_changes = [
      route_table_id
    ]
  }
}

resource "aws_subnet" "volterra_ce" {
  for_each          = var.aws_subnet_ce_cidr
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = var.aws_az
  tags = {
    "Name"        = format("%s-%s", var.prefix, each.key)
    "usecase"     = "edge-platform"
    "subnet-type" = each.key
  }
}

resource "aws_security_group" "this" {
  name        = "security-group-allow-ce-node"
  description = "Allows connectivity between ce node and client instance"
  vpc_id      = aws_vpc.this.id
  tags = {
    "Name"    = format("%s-sg", var.prefix)
    "usecase" = "edge-platform"
  }
  depends_on = [
    aws_internet_gateway.this,
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "this" {
  key_name   = format("%s-key", var.prefix)
  public_key = var.ssh_public_key
}

data "aws_instance" "voltmesh" {
  depends_on = [volterra_tf_params_action.apply_aws_vpc]
  filter {
    name   = "tag:Name"
    values = ["master-0"]
  }
  filter {
    name   = "vpc-id"
    values = [aws_vpc.this.id]
  }
}

