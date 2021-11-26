# ----------------------------------------------------------------------------
# Public subnets for Kubernetes environment and public route table 
# association

resource "aws_subnet" "k8s_subnets_public" {
  for_each          = toset(var.az_list)
  vpc_id            = var.vpc_data.vpc_id
  availability_zone = each.key
  cidr_block        = "${var.public_subnet_object.cidr_first_block}.${var.public_subnet_object.cidr_second_block}.${var.public_subnet_object.cidr_third_block + index(var.az_list, each.key)}.0/24"

  tags = {
    "Name"    = "${var.public_subnet_object.name}-${each.key}"
    "az"      = "${each.key}"
    "project" = "${var.project.name}"
  }
}

resource "aws_route_table_association" "rtb_public_subnet_k8s_association" {
  for_each       = aws_subnet.k8s_subnets_public
  route_table_id = var.vpc_data.route_table_public
  subnet_id      = each.value.id
}


# ----------------------------------------------------------------------------
# Private subnets for Kubernetes environmenta nd private route table 
# association

resource "aws_subnet" "k8s_subnets_private" {
  for_each          = toset(var.az_list)
  vpc_id            = var.vpc_data.vpc_id
  availability_zone = each.key
  cidr_block        = "${var.private_subnet_object.cidr_first_block}.${var.private_subnet_object.cidr_second_block}.${var.private_subnet_object.cidr_third_block + index(var.az_list, each.key)}.0/24"

  tags = {
    "Name"    = "${var.private_subnet_object.name}-${each.key}"
    "az"      = "${each.key}"
    "project" = "${var.project.name}"
  }
}

resource "aws_route_table_association" "rtb_private_subnet_k8s_association" {
  for_each       = aws_subnet.k8s_subnets_private
  route_table_id = var.vpc_data.route_table_private
  subnet_id      = each.value.id
}

# ----------------------------------------------------------------------------
# Elastic IPs for NAT gateways in public subnets

resource "aws_eip" "nat_gtw_public_ips" {
  for_each = aws_subnet.k8s_subnets_public
  vpc      = true

  tags = {
    "az"        = "${each.value.availability_zone}"
    "subnet"    = "${each.value.tags.Name}"
    "subnet-id" = "${each.value.id}"
    "project"   = "${var.project.name}"
  }
}


# ----------------------------------------------------------------------------
# NAT gateways for private subnets external (internet) access

resource "aws_nat_gateway" "k8s_private_subnet_nat_gtw" {
  for_each          = local.association_eip_nat_gtw
  subnet_id         = each.key
  connectivity_type = "public"
  allocation_id     = each.value

  tags = {
    "key"       = "value"
    "eip-id"    = "${each.value}"
    "subnet-id" = "${each.key}"
    "project"   = "${var.project.name}"
  }
}