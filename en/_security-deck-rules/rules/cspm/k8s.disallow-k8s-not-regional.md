### Managed Kubernetes cluster is regional {#disallow-k8s-not-regional}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | k8s.disallow-k8s-not-regional ||
|#

#### Description

**How the rule works**: The rule checks whether the Managed Kubernetes cluster at hand is regional.

A regional Managed Kubernetes cluster is one whose control plane nodes and worker nodes are distributed across several availability zones within one geographical region.

A regional cluster complies with these information security requirements:

* Business continuity requirements.
* Requirements of the GOST R 57580 standard and 152-FZ (Russian Federal Law on Personal Data).

Regional clusters boost reliability by replicating both control plane and worker nodes across several zones within a region. A zonal cluster creates a unified point of failure for the entire security infrastructure, from monitoring and responding to managing secrets and audit.

#### Instructions and solutions

* [Create a dedicated cloud network](https://yandex.cloud/en/docs/vpc/operations/network-create) for your cluster. Do not use this network together with other services.
* [Create one subnet](https://yandex.cloud/en/docs/vpc/operations/subnet-create) in each of these three availability zones: `ru-central1-a`, `ru-central1-b`, and `ru-central1-d`. Deploy the master hosts and node groups in these subnets.
* Use non-overlapping ranges of IP addresses for subnets, pods, and services. Factor in cluster growth for your address space in advance.
* [Configure security groups](https://yandex.cloud/en/docs/vpc/operations/security-group-create) before creating the cluster. Allow only necessary traffic: between the master and nodes, between nodes, from load balancers.
* If your cluster does not require internet access, create it without a public IP address and [set up access through a NAT gateway](https://yandex.cloud/en/docs/vpc/operations/create-nat-gateway) or [Yandex Cloud Interconnect](https://yandex.cloud/en/services/interconnect).