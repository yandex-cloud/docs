# Configuring security groups

[Security groups](../../vpc/concepts/security-groups.md) follow the principle <q>all traffic that is not allowed is prohibited</q>. In order for a cluster to work, you need to [create rules](../../vpc/operations/security-group-update.md#add-rule) in its security groups that allow:
* [Service traffic within the cluster](#rules-internal).
* [Connections to services from the internet](#rules-nodes).
* [Connections to nodes over SSH](#rules-nodes-ssh).
* [Access to the {{ k8s }} API](#rules-master).

You can set more detailed rules for security groups, such as allowing traffic in only specific [subnets](../../vpc/concepts/network.md#subnet).

Security groups must be correctly configured for all subnets that will host the [cluster](../concepts/index.md#kubernetes-cluster). This determines the performance and availability of the cluster and the services running there.

## Create rules for service traffic {#rules-internal}

{% note warning %}

Setting up rules for service traffic enables the performance of a regional cluster.

{% endnote %}

1. Add rules for incoming traffic.

   * For a network load balancer:
     * Port range: `{{ port-any }}`.
     * Protocol: `TCP`.
     * Source type: `CIDR`.
     * Destination: `198.18.235.0/24` and `198.18.248.0/24`.

   * To transfer service traffic between the [master](../concepts/index.md#master) and [nodes](../concepts/index.md#node-group):
     * Port range: `{{ port-any }}`.
       * Protocol: `Any`.
       * Source type: `Security group`.
       * Security group: Current (`Self`).

   * To transfer traffic between [pods](../concepts/index.md#pod) and [services](../concepts/index.md#service):
     * Port range: `{{ port-any }}`.
     * Protocol: `Any`.
     * Source type: `CIDR`.
     * Destination: Specify the IP address ranges of the subnets created along with the cluster, such as:
       * `10.96.0.0/16`.
       * `10.112.0.0/16`.

   * To test the nodes using ICMP requests from the subnets within {{ yandex-cloud }}:
     * Protocol: `ICMP`.
     * Source type: `CIDR`.
     * Destination: IP address ranges of the subnets within {{ yandex-cloud }} to perform cluster diagnostics from, such as:
       * `10.0.0.0/8`.
       * `192.168.0.0/16`.
       * `172.16.0.0/12`.

1. Add a rule for outgoing traffic that allows cluster hosts to connect to external resources, for example, to download images from Docker Hub or work with [{{ objstorage-full-name }}](../tutorials/backup.md):
   * Port range: `{{ port-any }}`.
   * Protocol: `Any`.
   * Source type: `CIDR`.
   * Destination: `0.0.0.0/0`.

## Create a rule for connecting to services from the internet {#rules-nodes}

The services running on the nodes are accessible from the internet and subnets within {{ yandex-cloud }} after you create a rule for incoming traffic:
* Port range: `30000-32767`.
* Protocol: `TCP`.
* Source type: `CIDR`.
* Destination: `0.0.0.0/0`.

## Create a rule for connecting to nodes via SSH {#rules-nodes-ssh}

To connect to nodes over SSH, create a rule for incoming traffic:
* Port: `{{ port-ssh }}`.
* Protocol: `TCP`.
* Source type: `CIDR`.
* Destination: IP address ranges of the subnets within {{ yandex-cloud }} and public IP addresses of computers on the internet, for example:
  * `10.0.0.0/8`.
  * `192.168.0.0/16`.
  * `172.16.0.0/12`.
  * `85.32.32.22/32`.

## Create rules to access the {{ k8s }} API {#rules-master}

To access the {{ k8s }} API and manage clusters using `kubectl` and other utilities, you need rules that allow connections to the master via ports `{{ port-k8s }}` and `{{ port-https }}`. Create two rules for incoming traffic, one per port:
* Ports: `{{ port-https }}` and `{{ port-k8s }}`.
* Protocol: `TCP`.
* Source type: `CIDR`.
* Destination: Specify the IP address range of the subnets that you'll manage the cluster from, such as:
  * `85.23.23.22/32`: For the external network.
  * `192.168.0.0/24`: For the internal network.

## Examples {#examples}

{% list tabs %}

- {{ TF }}

  For example, you need to create rules for an existing {{ k8s }} cluster:
  * With the zonal master located in the `{{ region-id }}-a` availability zone.
  * With the `worker-nodes-c` node group.
  * With access to services:
    * From the load balancer's address range `198.18.235.0/24` and `198.18.248.0/24`.
    * From the internal subnet `10.129.0.0/24` to transfer traffic between pods and services.
    * From the internal subnet `172.16.0.0/12` for the ICMP protocol.
    * From the internet from any addresses (`0.0.0.0/0`) to a range of NodePort ports (`30000-32767`).
  * With access to nodes from the internet from the address `85.32.32.22/32` to port `{{ port-ssh }}`.
  * With access to the {{ k8s }} API from an external subnet from the address range `203.0.113.0/24` via ports `{{ port-https }}` and `{{ port-k8s }}`.

    Four security groups are created:
    * `k8s-main-sg`: Rules for service traffic.
    * `k8s-public-services`: Rules for connecting to nodes from the internet.
    * `k8s-nodes-ssh-access`: Rules for connecting to nodes over SSH.
    * `k8s-master-whitelist`: Rules for accessing the cluster API.

    {% cut "The configuration file for the cluster:" %}

    {% if product == "yandex-cloud" %}

    ```hcl
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }
    }

    provider "yandex" {
      token = "<OAuth or static key of service account>"
      cloud_id  = "<cloud ID>"
      folder_id = "<folder ID>"
      zone      = "<availability zone>"
    }

    resource "yandex_vpc_security_group" "k8s-main-sg" {
      name        = "k8s-main-sg"
      description = "Group rules ensure the basic performance of the cluster. Apply it to the cluster and node groups."
      network_id  = "<cloud network ID>"
      ingress {
        protocol       = "TCP"
        description    = "The rule allows availability checks from the load balancer's range of addresses. It is required for the operation of a fault-tolerant cluster and load balancer services."
        v4_cidr_blocks = ["198.18.235.0/24", "198.18.248.0/24"]
        from_port      = 0
        to_port        = 65535
      }
      ingress {
        protocol          = "ANY"
        description       = "The rule allows the master-node and node-node interaction within the security group."
        predefined_target = "self_security_group"
        from_port         = 0
        to_port           = 65535
      }
      ingress {
        protocol       = "ANY"
        description = "The rule allows the pod-pod and service-service interaction. Specify the subnets of your cluster and services."
        v4_cidr_blocks = ["10.129.0.0/24"]
        from_port      = 0
        to_port        = 65535
      }
      ingress {
        protocol       = "ICMP"
        description = "The rule allows receipt of debugging ICMP packets from internal subnets."
        v4_cidr_blocks = ["172.16.0.0/12"]
      }
      egress {
        protocol       = "ANY"
        description = "The rule allows all outgoing traffic. Nodes can connect to {{ container-registry-full-name }}, {{ objstorage-name }}, Docker Hub, and more."
        v4_cidr_blocks = ["0.0.0.0/0"]
        from_port      = 0
        to_port        = 65535
      }
    }

    resource "yandex_vpc_security_group" "k8s-public-services" {
      name        = "k8s-public-services"
      description = "Group rules allow connections to services from the internet. Only apply the rules to node groups."
      network_id  = "<cloud network ID>"

      ingress {
        protocol       = "TCP"
        description = "The rule allows incoming traffic from the internet to a range of NodePort ports. Add or change the ports to the ones you need."
        v4_cidr_blocks = ["0.0.0.0/0"]
        from_port      = 30000
        to_port        = 32767
      }
    }

    resource "yandex_vpc_security_group" "k8s-nodes-ssh-access" {
      name        = "k8s-nodes-ssh-access"
      description = "Group rules allow connections to cluster nodes over SSH. Only apply the rules to node groups."
      network_id  = "<cloud network ID>"

      ingress {
        protocol       = "TCP"
        description = "The rule allows SSH connections to nodes from the specified IP addresses."
        v4_cidr_blocks = ["85.32.32.22/32"]
        port           = 22
      }
    }

    resource "yandex_vpc_security_group" "k8s-master-whitelist" {
      name        = "k8s-master-whitelist"
      description = "Group rules allow accessing the {{ k8s }} API  from the internet. Apply the rules to the cluster only."
      network_id  = "<cloud network ID>"

      ingress {
        protocol       = "TCP"
        description = "The rule allows connections to the {{ k8s }} API through port {{ port-k8s }} from the specified network."
        v4_cidr_blocks = ["203.0.113.0/24"]
        port           = 6443
      }

      ingress {
        protocol       = "TCP"
        description = "The rule allows connections to the {{ k8s }} API through port {{ port-https }} from the specified network."
        v4_cidr_blocks = ["203.0.113.0/24"]
        port           = 443
      }
    }

    resource "yandex_kubernetes_cluster" "k8s-cluster" {
      name = "k8s-cluster"
      ...
      master {
        version = "1.20"
        zonal {
          zone      = "{{ region-id }}-a"
          subnet_id = <cloud subnet ID>
        }

        security_group_ids = [
          yandex_vpc_security_group.k8s-main-sg.id,
          yandex_vpc_security_group.k8s-master-whitelist.id
        ]
        ...
      }
      ...
    }

    resource "yandex_kubernetes_node_group" "worker-nodes-c" {
      cluster_id = yandex_kubernetes_cluster.k8s-cluster.id
      name       = "worker-nodes-c"
      version    = "1.20"
      ...
      instance_template {
        platform_id = "standard-v3"
        network_interface {
          nat                = true
          subnet_ids         = [<cloud subnet ID>]
          security_group_ids = [
            yandex_vpc_security_group.k8s-main-sg.id,
            yandex_vpc_security_group.k8s-nodes-ssh-access.id,
            yandex_vpc_security_group.k8s-public-services.id
          ]
          ...
        }
        ...
      }
    }
    ```

    {% endif %}

    {% if product == "cloud-il" %}

    ```hcl
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }
    }

    provider "yandex" {
      endpoint  = "{{ api-host }}:443"
      token     = "<static key of the service account>"
      cloud_id  = "<cloud ID>"
      folder_id = "<folder ID>"
      zone      = "<availability zone>"
    }

    resource "yandex_vpc_security_group" "k8s-main-sg" {
      name        = "k8s-main-sg"
      description = "Group rules ensure the basic performance of the cluster. Apply it to the cluster and node groups."
      network_id  = "<cloud network ID>"
      ingress {
        protocol       = "TCP"
        description    = "The rule allows availability checks from the load balancer's range of addresses. It is required for the operation of a fault-tolerant cluster and load balancer services."
        v4_cidr_blocks = ["198.18.235.0/24", "198.18.248.0/24"]
        from_port      = 0
        to_port        = 65535
      }
      ingress {
        protocol          = "ANY"
        description       = "The rule allows the master-node and node-node interaction within the security group."
        predefined_target = "self_security_group"
        from_port         = 0
        to_port           = 65535
      }
      ingress {
        protocol       = "ANY"
        description = "The rule allows the pod-pod and service-service interaction. Specify the subnets of your cluster and services."
        v4_cidr_blocks = ["10.129.0.0/24"]
        from_port      = 0
        to_port        = 65535
      }
      ingress {
        protocol       = "ICMP"
        description = "The rule allows receipt of debugging ICMP packets from internal subnets."
        v4_cidr_blocks = ["172.16.0.0/12"]
      }
      egress {
        protocol       = "ANY"
        description = "The rule allows all outgoing traffic. Nodes can connect to {{ container-registry-full-name }}, {{ objstorage-name }}, Docker Hub, and more."
        v4_cidr_blocks = ["0.0.0.0/0"]
        from_port      = 0
        to_port        = 65535
      }
    }

    resource "yandex_vpc_security_group" "k8s-public-services" {
      name        = "k8s-public-services"
      description = "Group rules allow connections to services from the internet. Only apply the rules to node groups."
      network_id  = "<cloud network ID>"

      ingress {
        protocol       = "TCP"
        description = "The rule allows incoming traffic from the internet to a range of NodePort ports. Add or change the ports to the ones you need."
        v4_cidr_blocks = ["0.0.0.0/0"]
        from_port      = 30000
        to_port        = 32767
      }
    }

    resource "yandex_vpc_security_group" "k8s-nodes-ssh-access" {
      name        = "k8s-nodes-ssh-access"
      description = "Group rules allow connections to cluster nodes over SSH. Only apply the rules to node groups."
      network_id  = "<cloud network ID>"

      ingress {
        protocol       = "TCP"
        description = "The rule allows SSH connections to nodes from the specified IP addresses."
        v4_cidr_blocks = ["85.32.32.22/32"]
        port           = 22
      }
    }

    resource "yandex_vpc_security_group" "k8s-master-whitelist" {
      name        = "k8s-master-whitelist"
      description = "Group rules allow accessing the {{ k8s }} API  from the internet. Apply the rules to the cluster only."
      network_id  = "<cloud network ID>"

      ingress {
        protocol       = "TCP"
        description = "The rule allows connections to the {{ k8s }} API through port {{ port-k8s }} from the specified network."
        v4_cidr_blocks = ["203.0.113.0/24"]
        port           = 6443
      }

      ingress {
        protocol       = "TCP"
        description = "The rule allows connections to the {{ k8s }} API through port {{ port-https }} from the specified network."
        v4_cidr_blocks = ["203.0.113.0/24"]
        port           = 443
      }
    }

    resource "yandex_kubernetes_cluster" "k8s-cluster" {
      name = "k8s-cluster"
      ...
      master {
        version = "1.20"
        zonal {
          zone      = "{{ region-id }}-a"
          subnet_id = <cloud subnet ID>
        }

        security_group_ids = [
          yandex_vpc_security_group.k8s-main-sg.id,
          yandex_vpc_security_group.k8s-master-whitelist.id
        ]
        ...
      }
      ...
    }

    resource "yandex_kubernetes_node_group" "worker-nodes-c" {
      cluster_id = yandex_kubernetes_cluster.k8s-cluster.id
      name       = "worker-nodes-c"
      version    = "1.20"
      ...
      instance_template {
        platform_id = "standard-v3"
        network_interface {
          nat                = true
          subnet_ids         = [<cloud subnet ID>]
          security_group_ids = [
            yandex_vpc_security_group.k8s-main-sg.id,
            yandex_vpc_security_group.k8s-nodes-ssh-access.id,
            yandex_vpc_security_group.k8s-public-services.id
          ]
          ...
        }
        ...
      }
    }
    ```

    {% endif %}

    {% endcut %}

{% endlist %}