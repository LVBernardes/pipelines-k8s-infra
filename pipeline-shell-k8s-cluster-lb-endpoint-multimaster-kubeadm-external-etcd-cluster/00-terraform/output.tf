output "k8s_masters" {
  value = [
    for key, item in aws_instance.k8s_master :
    "Name: ${item.tags.Name} | PrivateIP: ${item.private_ip} | PublicIP: ${item.public_ip} ==> ssh -i '~/.ssh/keyPvtAccess.pub' ubuntu@${item.private_ip}"
  ]
}

output "k8s_masters_etcd" {
  value = [
    for key, item in aws_instance.k8s_master_etcd :
    "Name: ${item.tags.Name} | PrivateIP: ${item.private_ip} | PublicIP: ${item.public_ip} ==> ssh -i '~/.ssh/keyPvtAccess.pub' ubuntu@${item.private_ip}"
  ]
}

output "k8s_workers" {
  value = [
    for key, item in aws_instance.k8s_worker :
    "Name: ${item.tags.Name} | PrivateIP: ${item.private_ip} | PublicIP: ${item.public_ip} ==> ssh -i '~/.ssh/keyPvtAccess.pub' ubuntu@${item.private_ip}"
  ]
}

output "private_subnets_ids" {
  value = local.private_subnet_ids_list
}

output "public_subnets_ids" {
  value = local.public_subnet_ids_list
}

output "lb_proxy_dns" {
  value = aws_lb.nlb_proxy.dns_name
}
