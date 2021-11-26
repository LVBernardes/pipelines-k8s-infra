# resource "aws_route53_zone" "k8s_dns_main_domain" {
#   name = var.dns_k8s_object.main_domain_name

#   tags = {
#     "project" = "${var.project.name}"
#   }
# }

# resource "aws_route53_record" "k8s_dns_api_subdomain_record" {
#   zone_id = aws_route53_zone.k8s_dns_main_domain.zone_id
#   name    = "${var.dns_k8s_object.api_subdomain_name}.${var.dns_k8s_object.main_domain_name}"
#   type    = "A"
#   alias {
#     name                   = aws_lb.nlb_proxy.dns_name
#     zone_id                = aws_lb.nlb_proxy.zone_id
#     evaluate_target_health = true
#   }
# }
