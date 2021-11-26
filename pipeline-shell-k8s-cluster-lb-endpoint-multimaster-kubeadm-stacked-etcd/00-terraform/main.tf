# ----------------------------------------------------------------------------
# Master node instance template

resource "aws_instance" "k8s_master" {
  count = var.instance_k8s_master_object.number_of_nodes
  # ami                         = data.aws_ami.ubuntu.image_id
  ami           = "ami-09c92d3eb1db3a728"
  instance_type = var.instance_k8s_master_object.type
  key_name      = var.instance_k8s_master_object.key_pair
  # iam_instance_profile        = var.instance_k8s_master_object.iam_profile
  associate_public_ip_address = var.instance_k8s_master_object.public_ip

  vpc_security_group_ids = [aws_security_group.sg_k8s_master.id]
  subnet_id              = local.private_subnet_ids_list[((count.index) % local.number_of_private_subnets)]

  ebs_optimized = true
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = var.instance_k8s_master_object.root_ebs_size
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  tags = {
    "Name"                      = "${var.instance_k8s_master_object.tags.name}-${count.index}"
    "instance-group"            = "${var.instance_k8s_master_object.tags.instance_group}"
    "instance-sub-group"        = "${count.index == 0 ? var.instance_k8s_master_object.tags.instance_sub_group[0] : var.instance_k8s_master_object.tags.instance_sub_group[1]}"
    "ctr-orchestration-engine"  = "${var.container_orchestration.engine}"
    "ctr-orchestration-cluster" = "${var.container_orchestration.cluster_name}"
    "ctr-orchestration-network" = "${var.container_orchestration.network_template}"
    "ctr-engine"                = "${var.container_engine.name}"
    "project"                   = "${var.project.name}"
  }
}


# ----------------------------------------------------------------------------
# Worker node instance template

resource "aws_instance" "k8s_worker" {
  count = var.instance_k8s_worker_object.number_of_nodes
  # ami                         = data.aws_ami.ubuntu.image_id
  ami           = "ami-09c92d3eb1db3a728"
  instance_type = var.instance_k8s_worker_object.type
  key_name      = var.instance_k8s_worker_object.key_pair
  # iam_instance_profile        = var.instance_k8s_master_object.iam_profile
  associate_public_ip_address = var.instance_k8s_worker_object.public_ip

  vpc_security_group_ids = [aws_security_group.sg_k8s_worker.id]
  subnet_id              = local.private_subnet_ids_list[((count.index) % local.number_of_private_subnets)]

  ebs_optimized = true
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = var.instance_k8s_worker_object.root_ebs_size
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  tags = {
    "Name"                      = "${var.instance_k8s_worker_object.tags.name}-${count.index}"
    "instance-group"            = "${var.instance_k8s_worker_object.tags.instance_group}"
    "instance-sub-group"        = "${var.instance_k8s_worker_object.tags.instance_sub_group}"
    "ctr-orchestration-engine"  = "${var.container_orchestration.engine}"
    "ctr-orchestration-cluster" = "${var.container_orchestration.cluster_name}"
    "ctr-orchestration-network" = "${var.container_orchestration.network_template}"
    "ctr-engine"                = "${var.container_engine.name}"
    "project"                   = "${var.project.name}"
  }
}
