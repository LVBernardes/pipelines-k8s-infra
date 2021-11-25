# ----------------------------------------------------------------------------
# Kubernetes Cluster API entry point Network Load Balancer (NLB)

resource "aws_lb" "nlb_proxy" {
  name               = var.nlb_lb_proxy_object.name
  internal           = var.nlb_lb_proxy_object.is_internal
  load_balancer_type = "network"
  ip_address_type    = "ipv4"
  subnets            = local.public_subnet_ids_list

  tags = {
    "Name"    = "${var.nlb_lb_proxy_object.name}"
    "project" = "${var.project.name}"
  }
}


# ----------------------------------------------------------------------------
# Kubernetes Cluster API entry point Network Load Balancer (NLB) target group

resource "aws_lb_target_group" "target_group_k8s_master_api" {
  name               = "K8s-masters-api-server-tcp"
  protocol           = "TCP"
  target_type        = "instance"
  port               = 6443
  vpc_id             = var.vpc_data.vpc_id
  preserve_client_ip = true

  health_check {
    enabled  = true
    protocol = "TCP"
    port     = 6443
  }

  tags = {
    "Name"    = "K8s-masters-api-server-tcp"
    "project" = "${var.project.name}"
  }
}


# ----------------------------------------------------------------------------
# Kubernetes Cluster API entry point Network Load Balancer (NLB) target
# instances to target group association

resource "aws_lb_target_group_attachment" "attach_k8s_master_api" {
  count            = length(aws_instance.k8s_master)
  target_group_arn = aws_lb_target_group.target_group_k8s_master_api.arn
  target_id        = aws_instance.k8s_master[count.index].id
}


# ----------------------------------------------------------------------------
# Kubernetes Cluster API entry point Network Load Balancer (NLB) listener
# Cluster Api Server port

resource "aws_lb_listener" "listener_k8s_master_api" {
  load_balancer_arn = aws_lb.nlb_proxy.arn
  port              = "6443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_k8s_master_api.arn
  }

  tags = {
    "project" = "${var.project.name}"
  }
}