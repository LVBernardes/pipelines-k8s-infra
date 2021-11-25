#!/bin/bash

cp -p 00-terraform/k8s_lb_dns_name 01-ansible/

cd 01-ansible/

ansible-playbook 00-ansible-prepare-all-nodes.yml

# ansible-playbook 01-ansible-init-master-primary.yml

# ansible-playbook 02-ansible-join-master-replicas.yml

# ansible-playbook 03-ansible-join-worker-nodes.yml

# ansible-playbook 04-ansible-configure-k8s-network-mode.yml