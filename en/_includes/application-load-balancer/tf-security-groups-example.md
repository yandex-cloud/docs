Create the following security groups and rules:

```hcl
locals {
  network-id = "<cloud_network_ID>"
}

resource "yandex_vpc_security_group" "alb" {
  description = "Load balancer security group"
  name        = "alb"
  network_id  = local.network-id
  ingress {
    description    = "Rule to allow incoming HTTP traffic"
    port           = 80
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description    = "Rule to allow incoming HTTPS traffic"
    port           = 443
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description       = "Rule for load balancer node health checks"
    port              = 30080
    protocol          = "TCP"
    predefined_target = "loadbalancer_healthchecks"
  }
  egress {
    description    = "Rule for sending traffic to nodes, including health checks"
    from_port      = 0
    to_port        = 65535
    protocol       = "TCP"
    v4_cidr_blocks = ["10.140.0.0/24"]
  }
}

resource "yandex_vpc_security_group" "nodegroup-backend" {
  description = "Node group's security group for backend health checks"
  name        = "nodegroup-backend"
  network_id  = local.network-id
  ingress {
    description    = "Backend health check rule"
    port           = 10501
    protocol       = "TCP"
    v4_cidr_blocks = ["10.128.0.0/24", "10.129.0.0/24", "10.130.0.0/24"]
  }
}

resource "yandex_vpc_security_group" "k8s-cluster-nodegroup-traffic" {
  description = "Cluster and node group's security group for service traffic"
  name        = "k8s-cluster-nodegroup-traffic"
  network_id  = local.network-id
  ingress {
    description       = "Network load balancer rule"
    from_port         = 0
    to_port           = 65535
    protocol          = "TCP"
    predefined_target = "loadbalancer_healthchecks"
  }
  ingress {
    description       = "Rule for traffic between the master and nodes"
    from_port         = 0
    to_port           = 65535
    protocol          = "ANY"
    predefined_target = "self_security_group"
  }
  ingress {
    description    = "Rule for health checks of nodes from subnets within Yandex Cloud"
    from_port      = 0
    to_port        = 65535
    protocol       = "IPV6_ICMP"
    v4_cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
  }
  egress {
    description       = "Rule for traffic between the master and nodes"
    from_port         = 0
    to_port           = 65535
    protocol          = "ANY"
    predefined_target = "self_security_group"
  }
}

resource "yandex_vpc_security_group" "nodegroup-traffic" {
  description = "Node group's security group for service traffic"
  name        = "nodegroup-traffic"
  network_id  = local.network-id
  ingress {
    description    = "Rule for traffic between pods and services"
    from_port      = 0
    to_port        = 65535
    protocol       = "ANY"
    v4_cidr_blocks = ["10.96.0.0/16", "10.112.0.0/16"]
  }
  egress {
    description    = "Rule for external resource access"
    from_port      = 0
    to_port        = 65535
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "k8s-cluster-traffic" {
  description = "Cluster security group for control plane traffic"
  name        = "k8s-cluster-traffic"
  network_id  = local.network-id
  ingress {
    description    = "Rule for access to the Kubernetes API"
    port           = 443
    protocol       = "TCP"
    v4_cidr_blocks = ["203.0.113.0/24"]
  }
  ingress {
    description    = "Rule for access to the Kubernetes API"
    port           = 6443
    protocol       = "TCP"
    v4_cidr_blocks = ["203.0.113.0/24"]
  }
  egress {
    description    = "Rule for traffic between the master and metric-server pods"
    port           = 4443
    protocol       = "TCP"
    v4_cidr_blocks = ["10.96.0.0/16"]
  }
}

resource "yandex_vpc_security_group" "nodegroup-services-access" {
  description = "Node group's security group for accessing services from the internet"
  name        = "nodegroup-services-access"
  network_id  = local.network-id
  ingress {
    description    = "Rules for accessing services from the internet and Yandex Cloud subnets"
    from_port      = 30000
    to_port        = 32767
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "nodegroup-ssh" {
  description = "Node group's security group for SSH access to nodes"
  name        = "nodegroup-ssh"
  network_id  = local.network-id
  ingress {
    description    = "Rules for SSH access to nodes"
    port           = 22
    protocol       = "TCP"
    v4_cidr_blocks = ["203.0.113.0/24"]
  }
}
```
