# Esteira Cluster Estático Kubernetes usando Terraform, Ansible e Shell Script

## Resultados

### Cluster Kubernetes em HA (_high availability_)

- 3 nós mestres
- 3 nós servos
- 3 servidores de ETCD do control plane

### Infraestrutura

- Provedor de nuvem: **AWS**
- 3 sub-nets públicas (comunicação com a internet)
- 4 grupos de segurança:
    1) _Balanceador para nós mestres:_
    - **Entrada:** HTTP(80, 8080), HTTPS(443), SSH(22) e grupo de seg. 3
    - **Saída:** Todos os protocolos (sem restrição de IP)  

    2) _Ambiente dos nós mestres:_
    - **Entrada:** SSH(22), grupo de seg. 1 e grupo de seg. 3
    - **Saída:** Todos os protocolos (sem restrição de IP)

    3) _Ambiente dos nós servos:_
    - **Entrada:** SSH(22), grupo de seg. 2
    - **Saída:** Todos os protocolos (sem restrição de IP)
- 1 entrada no DNS para o balanceador de carga
- 1 balanceador de carga de rede


## Esteira em Shell Script