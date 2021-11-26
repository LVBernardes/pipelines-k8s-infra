# ----------------------------------------------------------------------------
# Security group for resources inside public subnets

resource "aws_security_group" "sg_k8s_public" {
  name        = var.sg_public_object.name
  description = var.sg_public_object.description
  vpc_id      = var.vpc_data.vpc_id

  tags = {
    "Name"    = "${var.sg_public_object.name}"
    "project" = "${var.project.name}"
  }
}


# ----------------------------------------------------------------------------
# Security group for kubernetes master resources inside private subnets

resource "aws_security_group" "sg_k8s_master" {
  name        = var.sg_master_object.name
  description = var.sg_master_object.description
  vpc_id      = var.vpc_data.vpc_id

  tags = {
    "Name"    = "${var.sg_master_object.name}"
    "project" = "${var.project.name}"
  }
}


# ----------------------------------------------------------------------------
# Security group for kubernetes worker resources inside private subnets

resource "aws_security_group" "sg_k8s_worker" {
  name        = var.sg_worker_object.name
  description = var.sg_worker_object.description
  vpc_id      = var.vpc_data.vpc_id

  tags = {
    "Name"    = "${var.sg_worker_object.name}"
    "project" = "${var.project.name}"
  }
}
