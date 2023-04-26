# Configuring security groups

{% include [security-groups-note](../../../_includes/vpc/security-groups-note-services.md) %}

[Security groups](../../../vpc/concepts/security-groups.md) follow the "All traffic that is not allowed is prohibited" principle. For a cluster to run, you need to [create rules](../../../vpc/operations/security-group-add-rule.md) in its security groups to allow:
* [Service traffic within the cluster](#rules-internal).
* [Connections to services from the internet](#rules-nodes).
* [Connections to nodes over SSH](#rules-nodes-ssh).
* [API access{{ k8s }}](#rules-master).

{% note info %}

We recommend creating an independent security group for each of the mentioned sets of rules.

{% endnote %}

You can set more detailed rules for security groups, such as allowing traffic in only specific [subnets](../../../vpc/concepts/network.md#subnet).

Security groups must be correctly configured for all subnets that will host the [cluster](../../concepts/index.md#kubernetes-cluster). This determines the performance and availability of the cluster and the services running there.

Prior to editing security groups or the settings of any included rules, make sure this is not going to disrupt the cluster or its node groups.

{% note alert %}

Do not delete the security groups bound to a running cluster or node group as this might result in disruptions in their operation and data loss.

{% endnote %}

## Creating rules for service traffic {#rules-internal}

{% note warning %}

Rules for service traffic are required for a regional cluster to work.

{% endnote %}

For the cluster to run properly, create rules both for the inbound and outgoing traffic, and **apply them to the cluster and node groups**:
1. Add rules for incoming traffic.
   * For a network load balancer:
     * Port range: `{{ port-any }}`.
     * Protocol: `TCP`.
     * Source type: `Load balancer health checks`.
   * To transfer service traffic between the [master](../../concepts/index.md#master) and [nodes](../../concepts/index.md#node-group):
     * Port range: `{{ port-any }}`.
     * Protocol: `Any`.
     * Source type: `Security group`.
     * Security group: Current (`Self`).
   * To transfer traffic between [pods](../../concepts/index.md#pod) and [services](../../concepts/index.md#service):
     * Port range: `{{ port-any }}`.
     * Protocol: `Any`.
     * Source type: `CIDR`.
     * Destination: Specify the IP address ranges of the subnets created along with the cluster, such as:
       * `10.96.0.0/16`.
       * `10.112.0.0/16`.
   * To test the nodes using ICMP requests from the subnets within {{ yandex-cloud }}:
     * Protocol: `ICMP`.
     * Source type: `CIDR`.
     * Destination: IP address ranges of the subnets within {{ yandex-cloud }} from which you'll perform cluster diagnostics, such as:
       * `10.0.0.0/8`.
       * `192.168.0.0/16`.
       * `172.16.0.0/12`.
1. Add a rule for outgoing traffic that allows cluster hosts to connect to external resources, for example, to download images from Docker Hub or work with [{{ objstorage-full-name }}](../../tutorials/backup.md):
   * Port range: `{{ port-any }}`.
   * Protocol: `Any`.
   * Source type: `CIDR`.
   * Destination: `0.0.0.0/0`.

## Creating a rule for connecting to services from the internet {#rules-nodes}

To be sure that the services running on nodes are accessible from the internet and subnets within {{ yandex-cloud }}, create a rule for the incoming traffic and **apply it to the node group**:
* Port range: `30000-32767`.
* Protocol: `TCP`.
* Source type: `CIDR`.
* Destination: `0.0.0.0/0`.

## Creating a rule for connecting to nodes via SSH {#rules-nodes-ssh}

To access the nodes via SSH, create a rule for incoming traffic and **apply it to the node group**:
* Port: `{{ port-ssh }}`.
* Protocol: `TCP`.
* Source type: `CIDR`.
* Destination: IP address ranges of the subnets within {{ yandex-cloud }} and public IP addresses of computers on the internet, for example:
  * `10.0.0.0/8`.
  * `192.168.0.0/16`.
  * `172.16.0.0/12`.
  * `85.32.32.22/32`.

## Creating rules to access the {{ k8s }} API {#rules-master}

To access the {{ k8s }} API and manage clusters using `kubectl` and other utilities, you need rules that allow connections to the master via ports `{{ port-k8s }}` and `{{ port-https }}`. Create two rules for the incoming traffic, one rule per port, and **apply them to the cluster**:
* Ports: `{{ port-https }}`, `{{ port-k8s }}`.
* Protocol: `TCP`.
* Source type: `CIDR`.
* Destination: Specify the IP address range of the subnets from which you'll manage the cluster, such as:
  * `85.23.23.22/32`: For the external network.
  * `192.168.0.0/24`: For the internal network.

## Examples {#examples}

{% list tabs %}

- {{ TF }}

  For example, you need to create rules for an existing {{ k8s }} cluster:
  * With the zonal master located in the `{{ region-id }}-a` availability zone.
  * With the `worker-nodes-с` node group.
  * With the address range for pods and services: `10.96.0.0/16` and `10.112.0.0/16`.
  * With access to services:
    * From the load balancer's address range `198.18.235.0/24` and `198.18.248.0/24`.
    * From the internal subnets`172.16.0.0/12`, `10.0.0.0/8`, and `192.168.0.0/16` for the ICMP protocol.
    * From the internet from any address (`0.0.0.0/0`) to a range of NodePorts (`30000-32767`).
  * With access to nodes from the internet from the address `85.32.32.22/32` to port `{{ port-ssh }}`.
  * With access to the {{ k8s }} API from an external subnet from an address range `203.0.113.0/24` via ports `{{ port-https }}` and `{{ port-k8s }}`.

  Four security groups are created:
  * `k8s-main-sg`: Rules for service traffic.
  * `k8s-public-services`: Rules for connecting to nodes from the internet.
  * `k8s-nodes-ssh-access`: Rules for connecting to nodes over SSH.
  * `k8s-master-whitelist`: Rules for accessing the cluster API.

  {% cut "Configuration file for this cluster:" %}

  
  ```hcl
  terraform {
    required_providers {
      yandex = {
        source = "yandex-cloud/yandex"
      }
    }
  }

  provider "yandex" {
    token     = "<service account OAuth or static key>"
    cloud_id  = "<cloud ID>"
    folder_id = "<folder ID>"
    zone      = "<availability zone>"
  }

  resource "yandex_vpc_security_group" "k8s-main-sg" {
    name        = "k8s-main-sg"
    description = "Group rules support basic cluster functionality. Apply it to the cluster and node groups."
    network_id  = "<cloud network ID>"
    ingress {
      protocol          = "TCP"
      description       = "The rule allows availability checks from the load balancer address range. It is required for the operation of a fault-tolerant cluster and load balancer services."
      predefined_target = "loadbalancer_healthchecks"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ANY"
      description       = "The rule allows master to node and node to node communication inside a security group."
      predefined_target = "self_security_group"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol       = "ANY"
      description    = "Rule allows pod-pod and service-service communication. Specify the subnets of your cluster and services."
      v4_cidr_blocks = ["10.96.0.0/16", "10.112.0.0/16"]
      from_port      = 0
      to_port        = 65535
    }
    ingress {
      protocol       = "ICMP"
      description    = "Rule allows debugging ICMP packets from internal subnets."
      v4_cidr_blocks = ["172.16.0.0/12", "10.0.0.0/8", "192.168.0.0/16"]
    }
    egress {
      protocol       = "ANY"
      description    = "Rule allows all outgoing traffic. Nodes can connect to {{ container-registry-full-name }}, {{ objstorage-name }}, Docker Hub, and so on."
      v4_cidr_blocks = ["0.0.0.0/0"]
      from_port      = 0
      to_port        = 65535
    }
  }

  resource "yandex_vpc_security_group" "k8s-public-services" {
    name        = "k8s-public-services"
    description = "Group rules allow connections to services from the internet. Apply the rules only for node groups."
    network_id  = "<cloud network ID>"

    ingress {
      protocol       = "TCP"
      description    = "Rule allows incoming traffic from the internet to the NodePort port range. Add ports or change existing ones to the required ports."
      v4_cidr_blocks = ["0.0.0.0/0"]
      from_port      = 30000
      to_port        = 32767
    }
  }

  resource "yandex_vpc_security_group" "k8s-nodes-ssh-access" {
    name        = "k8s-nodes-ssh-access"
    description = "Group rules allow connections to cluster nodes over SSH. Apply the rules only for node groups."
    network_id  = "<cloud network ID>"

    ingress {
      protocol       = "TCP"
      description    = "Rule allows connections to nodes over SSH from specified IPs."
      v4_cidr_blocks = ["85.32.32.22/32"]
      port           = 22
    }
  }

  resource "yandex_vpc_security_group" "k8s-master-whitelist" {
    name        = "k8s-master-whitelist"
    description = "Group rules allow access to the {{ k8s }} API from the internet. Apply the rules to the cluster only."
    network_id  = "<cloud network ID>"

    ingress {
      protocol       = "TCP"
      description    = "Rule allows connections to the {{ k8s }} API via port {{ port-k8s }} from a specified network."
      v4_cidr_blocks = ["203.0.113.0/24"]
      port           = 6443
    }

    ingress {
      protocol       = "TCP"
      description    = "Rule allows connections to the {{ k8s }} API via port {{ port-https }} from a specified network."
      v4_cidr_blocks = ["203.0.113.0/24"]
      port           = 443
    }
  }

  resource "yandex_kubernetes_cluster" "k8s-cluster" {
    name = "k8s-cluster"
    cluster_ipv4_range = "10.96.0.0/16"
    service_ipv4_range = "10.112.0.0/16"
    ...
    master {
      version = "1.20"
      zonal {
        zone      = "{{ region-id }}-a"
        subnet_id = <cloud network ID>
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
        subnet_ids         = [<cloud network ID>]
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



  {% endcut %}

{% endlist %}