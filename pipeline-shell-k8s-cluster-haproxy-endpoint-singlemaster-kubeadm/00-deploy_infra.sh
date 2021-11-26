#!/bin/bash

cd 00-terraform/

terraform init
terraform fmt
terraform apply -target='aws_subnet.k8s_subnets_public' -target='aws_subnet.k8s_subnets_private' -auto-approve
terraform apply -auto-approve
terraform output > tf-output.txt