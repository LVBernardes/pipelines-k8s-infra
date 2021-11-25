resource "local_file" "k8s_lb_dns_name" {
  content  = aws_lb.nlb_proxy.dns_name
  filename = "${path.module}/k8s_lb_dns_name"
}