---
title: How to configure {{ k8s }} cluster security groups in {{ managed-k8s-full-name }}
description: Follow this guide to set up security groups.
---

# Configuring security groups


[Security groups](../../../vpc/concepts/security-groups.md) follow the _All traffic that is not allowed is prohibited_ principle. For a cluster to work:

1. In its security groups, [create rules](../../../vpc/operations/security-group-add-rule.md) to allow relevant traffic for the cluster nodes:

    * [Service traffic within the cluster](#rules-internal).

      These rules allow intra-cluster communication and connection to the cluster via the {{ k8s }} API.

    * [Connections to services from the internet](#rules-nodes).
    * [Connections to nodes over SSH](#rules-nodes-ssh).

    {% note tip %}

    Place each of these rule sets into a separate security group.

    This will make it easy [to apply these security groups](#apply) to the cluster and its node groups.

    {% endnote %}

1. (Optional) If planning to use a [{{ alb-full-name }} L7 balancer](../../../application-load-balancer/concepts/application-load-balancer.md) together with the cluster, [add rules for the balancer](../../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md) as well.

1. [Apply security groups with these rules](#apply) to the cluster and node groups.

You can specify more detailed rules for your security groups, e.g., to allow traffic only in specific [subnets](../../../vpc/concepts/network.md#subnet).

  {% note warning %}

  Some products require applying additional rules in security groups. For more information, see guides for the relevant products.

  {% endnote %}

Security groups must be correctly configured for all subnets that will host the [cluster](../../concepts/index.md#kubernetes-cluster). This determines the performance and availability of the cluster and the services running there.

Prior to editing security groups or the settings of any included rules, make sure this is not going to disrupt the cluster or its node groups.

{% note alert %}

Do not delete the security groups linked to a running cluster or node group. This may cause prohibition of network traffic and disrupt the operation of the cluster and its nodes.

{% endnote %}

## Creating rules for service traffic {#rules-internal}

{% note warning %}

Rules for service traffic are required for a highly-available cluster to work.

{% endnote %}

### Allowing traffic for a cluster and node groups {#rules-internal-cluster}

For the cluster to work correctly, create rules for incoming and outgoing traffic and [apply them to the cluster and node groups](#apply):

1. Add rules for incoming traffic that allow:

   * Health checks of the network load balancer:
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`.
   * Transferring service traffic between the [master](../../concepts/index.md#master) and the [nodes](../../concepts/index.md#node-group):
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).
   * Health checks of nodes using ICMP requests from subnets within {{ yandex-cloud }}:
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `ICMP`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: Address ranges of subnets within {{ yandex-cloud }} to health check the cluster from, e.g.:
       * `10.0.0.0/8`
       * `192.168.0.0/16`
       * `172.16.0.0/12`

1. Add a rule for outgoing service traffic between the master and the nodes:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).

{% note info %}

If using a [highly available master](../../concepts/index.md#master), allow traffic to the CIDRs of the subnets where the master hosts are located or to the cluster CIDR for node groups. This is required for transmitting service traffic between the master and nodes.

{% endnote %}

### Allowing traffic for node groups {#rules-internal-nodegroup}

For node groups to run properly, create rules for incoming and outgoing traffic and [apply them to node groups](#apply):

1. Add a rule for incoming traffic that allows traffic transfer between [pods](../../concepts/index.md#pod) and [services](../../concepts/index.md#service):
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: CIDRs of the cluster and services, e.g., `10.96.0.0/16` and `10.112.0.0/16`.

1. Add a rule for outgoing traffic that allows node group nodes to connect to external resources, e.g., to download images from Docker Hub or work with [{{ objstorage-full-name }}](../../tutorials/kubernetes-backup.md):
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

    {% note info %}

    If you are using a [highly available master](../../concepts/index.md#master) and do not want to allow nodes to connect to any addresses (CIDR: `0.0.0.0/0`), allow outgoing traffic to the CIDRs of the subnets where the master hosts are located or to the cluster CIDR. This ensures node access to the master.

      {% cut "Examples" %}

      * Access to the cluster CIDR:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `10.131.0.32/32`.

      * Access to the CIDRs of subnets with master hosts:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `10.128.0.0/24`, `10.129.0.0/24`, `10.131.0.0/24`.

      {% endcut %}

    {% endnote %}

### Allowing traffic for cluster {#rules-master}

For the cluster to work correctly and to allow incoming [connections](./index.md), create rules for incoming and outgoing traffic and [apply them to the cluster](#apply):

1. Add rules for incoming traffic that allow connecting to the [master](../../concepts/index.md#master) via ports `{{ port-k8s }}` and `{{ port-https }}`. This will allow you to access the {{ k8s }} API and manage the cluster using `kubectl` and other utilities.

    Create two rules for incoming traffic, one per port:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`, `{{ port-k8s }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: Specify the IP address range of the subnets you will manage the cluster from, e.g.:
      * `85.23.23.22/32`: For an external network.
      * `192.168.0.0/24`: For an internal network.

1. Add a rule for outgoing traffic that allows traffic transfer between the master and `metric-server` [pods](../../concepts/index.md#pod):

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `4443`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: Specify the cluster CIDR, e.g., `10.96.0.0/16`.

## Creating a rule for connecting to services from the internet {#rules-nodes}

To be sure that the services running on nodes are accessible from the internet and subnets within {{ yandex-cloud }}, create a rule for the incoming traffic and [apply it to the node group](#apply):

* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `30000-32767`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

## Creating a rule for connecting to nodes via SSH {#rules-nodes-ssh}

To access the nodes via SSH, create a rule for incoming traffic and [apply it to the node group](#apply):

* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: IP address ranges of subnets within {{ yandex-cloud }} and public IP addresses of computers on the internet, for example:
    * `10.0.0.0/8`
    * `192.168.0.0/16`
    * `172.16.0.0/12`
    * `85.32.32.22/32`

## Applying security groups with rules {#apply}

Depending on the rules the security groups contain, these groups must be assigned [to a cluster](../kubernetes-cluster/kubernetes-cluster-update.md#update-cluster) or [node group](../node-group/node-group-update.md#update-settings):

| **Security group** | **Object to assign the group to** |
| ----------------------- | --------------------------------------------- |
| Group [allowing traffic for a cluster and node groups](#rules-internal-cluster) | Cluster and node group |
| Group [allowing traffic for node groups](#rules-internal-nodegroup) | Node group |
| Group [allowing traffic for a cluster](#rules-master) | Cluster |
| Group [allowing connection to services from the internet](#rules-nodes) | Node group |
| Group [allowing connection to nodes via SSH](#rules-nodes-ssh) | Node group |

## Examples of rules {#examples}

Let’s assume you want to create a {{ k8s }} cluster which:

* Uses the following configuration:

    * A highly-available master in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d` availability zones.
    * A node group named `worker-nodes-a` in the `{{ region-id }}-a` availability zone.
    * Cluster CIDR: `10.96.0.0/16`; CIDR of services: `10.112.0.0/16`.

* Follows these traffic exchange policies:

    * [Health checks of nodes using ICMP requests](#rules-internal-cluster) are allowed from the following subnets within {{ yandex-cloud }}:

        * `10.0.0.0/8`
        * `172.16.0.0/12`
        * `192.168.0.0/16`

    * [Connections to services from the internet](#rules-nodes) are allowed from any addresses: `0.0.0.0/0`.
    * [Connections to nodes via SSH](#rules-nodes-ssh) are allowed from the only address: `85.32.32.22/32`.
    * [Access to the {{ k8s }} API](#rules-master) is allowed from the only subnet: `203.0.113.0/24`.

To create such a cluster:

{% list tabs group=instructions %}

- CLI {#cli}

  1. Create a security group named `k8s-cluster-nodegroup-traffic` that allows traffic for a cluster and node groups:

      ```bash
      yc vpc security-group create \
        --name k8s-cluster-nodegroup-traffic \
        --network-id <cloud_network_ID> \
        --rule "description=healthchecks,direction=ingress,protocol=tcp,from-port=0,to-port=65535,predefined=loadbalancer_healthchecks" \
        --rule "description=master-nodes,direction=ingress,protocol=any,from-port=0,to-port=65535,predefined=self_security_group" \
        --rule "description=icmp,direction=ingress,protocol=icmp,v4-cidrs=[10.0.0.0/8,172.16.0.0/12,192.168.0.0/16]" \
        --rule "description=master-nodes-outgoing,direction=egress,protocol=any,from-port=0,to-port=65535,predefined=self_security_group"
      ```

  1. Create a security group named `k8s-nodegroup-traffic` that allows traffic for node groups:

      ```bash
      yc vpc security-group create \
        --name k8s-nodegroup-traffic \
        --network-id <cloud_network_ID> \
        --rule "description=pods-services,direction=ingress,protocol=any,from-port=0,to-port=65535,v4-cidrs=[10.96.0.0/16,10.112.0.0/16]" \
        --rule "description=nodes-external-resources,direction=egress,protocol=any,from-port=0,to-port=65535,v4-cidrs=[0.0.0.0/0]"
      ``` 

  1. Create a security group named `k8s-cluster-traffic` that allows traffic for a cluster:

      ```bash
      yc vpc security-group create \
        --name k8s-cluster-traffic \
        --network-id <cloud_network_ID> \
        --rule "description=api-443,direction=ingress,protocol=tcp,port=443,v4-cidrs=[203.0.113.0/24]" \
        --rule "description=api-6443,direction=ingress,protocol=tcp,port=6443,v4-cidrs=[203.0.113.0/24]" \
        --rule "description=metric-server,direction=egress,protocol=tcp,port=4443,v4-cidrs=[10.96.0.0/16]"
      ```

  1. Create a security group named `k8s-services-access` that allows connection to services from the internet:

      ```bash
      yc vpc security-group create \
        --name k8s-services-access \
        --network-id <cloud_network_ID> \
        --rule "description=services-incoming,direction=ingress,protocol=tcp,from-port=30000,to-port=32767,v4-cidrs=[0.0.0.0/0]"
      ```

  1. Create a security group named `k8s-ssh-access` that allows connection to nodes over SSH:

      ```bash
      yc vpc security-group create \
        --name k8s-ssh-access \
        --network-id <cloud_network_ID> \
        --rule "description=ssh-access,direction=ingress,protocol=tcp,port=22,v4-cidrs=[85.32.32.22/32]"
      ```  

  1. Create a cluster and assign it the `k8s-cluster-nodegroup-traffic` and `k8s-cluster-traffic` security groups:

      ```bash
      {{ yc-k8s }} cluster create \
        --name k8s-cluster \
        --network-id <cloud_network_ID> \
        --service-account-id <service_account_ID_for_cluster> \
        --node-service-account-id <serivce_account_ID_for_node_group> \
        --cluster-ipv4-range 10.96.0.0/16 \
        --service-ipv4-range 10.112.0.0/16 \
        --public-ip \
        --master-location zone={{ region-id }}-a,subnet-id=<cloud_subnet_ID_in_{{ region-id }}-a_zone> \
        --master-location zone={{ region-id }}-b,subnet-id=<cloud_subnet_ID_in_{{ region-id }}-b_zone> \
        --master-location zone={{ region-id }}-d,subnet-id=<cloud_subnet_ID_in_{{ region-id }}-d_zone> \
        --security-group-ids <k8s-cluster-nodegroup-traffic_ID>,<k8s-cluster-traffic_ID>
      ```

      You can [get](../../../vpc/operations/security-group-get-info.md) the security group ID together with info on the security group.

  1. Create a node group and assign it the `k8s-cluster-nodegroup-traffic`, `k8s-nodegroup-traffic`, `k8s-services-access`, and `k8s-ssh-access` security groups:

      ```bash
      {{ yc-k8s }} node-group create \
        --name worker-nodes-a \
        --cluster-id <cluster_ID> \
        --location zone={{ region-id }}-a \
        --fixed-size 1 \
        --network-interface subnets=<subnet_ID_in_{{ region-id }}-a>,ipv4-address=nat,security-group-ids=[<k8s-cluster-nodegroup-traffic_ID>,<k8s-nodegroup-traffic_ID>,<k8s-services-access_ID>,<k8s-ssh-access_ID>]
      ```

      You can [get](../../../vpc/operations/security-group-get-info.md) the security group ID together with info on the security group.
    
- {{ TF }} {#tf}    

  1. Create security groups with the required rules:

      ```hcl
      resource "yandex_vpc_security_group" "k8s-cluster-nodegroup-traffic" {
        name        = "k8s-cluster-nodegroup-traffic"
        description = "The group rules allow service traffic for the cluster and node groups. Apply it to the cluster and node groups."
        network_id  = "<cloud_network_ID>"
        ingress {
          description       = "Rule for health checks of the network load balancer."
          from_port         = 0
          to_port           = 65535
          protocol          = "TCP"
          predefined_target = "loadbalancer_healthchecks"
        }
        ingress {
          description       = "Rule for incoming service traffic between the master and the nodes."
          from_port         = 0
          to_port           = 65535
          protocol          = "ANY"
          predefined_target = "self_security_group"
        }
        ingress {
          description    = "Rule for health checks of nodes using ICMP requests from subnets within {{ yandex-cloud }}."
          protocol       = "ICMP"
          v4_cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
        }
        egress {
          description       = "Rule for outgoing service traffic between the master and the nodes."
          from_port         = 0
          to_port           = 65535
          protocol          = "ANY"
          predefined_target = "self_security_group"
        }
      }

      resource "yandex_vpc_security_group" "k8s-nodegroup-traffic" {
        name        = "k8s-nodegroup-traffic"
        description = "The group rules allow service traffic for node groups. Apply it to node groups."
        network_id  = "<cloud_network_ID>"
        ingress {
          description    = "Rule for incoming traffic that allows traffic transfer between pods and services."
          from_port      = 0
          to_port        = 65535
          protocol       = "ANY"
          v4_cidr_blocks = ["10.96.0.0/16", "10.112.0.0/16"]
        }
        egress {
          description    = "Rule for outgoing traffic that allows node group nodes to connect to external resources."
          from_port      = 0
          to_port        = 65535
          protocol       = "ANY"
          v4_cidr_blocks = ["0.0.0.0/0"]
        }
      }

      resource "yandex_vpc_security_group" "k8s-services-access" {
        name        = "k8s-services-access"
        description = "The group rules allow connections to services from the internet. Apply it to node groups."
        network_id  = "<cloud_network_ID>"
        ingress {
          description    = "Rule for incoming traffic that allows connection to services."
          from_port      = 30000
          to_port        = 32767
          protocol       = "TCP"
          v4_cidr_blocks = ["0.0.0.0/0"]
        }
      }

      resource "yandex_vpc_security_group" "k8s-ssh-access" {
        name        = "k8s-ssh-access"
        description = "The group rules allow connection to nodes via SSH. Apply it to node groups."
        network_id  = "<cloud_network_ID>"
        ingress {
          description    = "Rule for incoming traffic that allows connection to nodes via SSH."
          port           = 22
          protocol       = "TCP"
          v4_cidr_blocks = ["85.32.32.22/32"]
        }
      }

      resource "yandex_vpc_security_group" "k8s-cluster-traffic" {
        name        = "k8s-cluster-traffic"
        description = "The group rules allow traffic for the cluster. Apply it to the cluster."
        network_id  = "<cloud_network_ID>"
        ingress {
          description    = "Rule for incoming traffic that allows access to the {{ k8s }} API (port 443)."
          port           = 443
          protocol       = "TCP"
          v4_cidr_blocks = ["203.0.113.0/24"]
        }
        ingress {
          description    = "Rule for incoming traffic that allows access to the {{ k8s }} API (port 6443)."
          port           = 6443
          protocol       = "TCP"
          v4_cidr_blocks = ["203.0.113.0/24"]
        }
        egress {
          description    = "Rule for outgoing traffic that allows traffic transfer between the master and metric-server pods."
          port           = 4443
          protocol       = "TCP"
          v4_cidr_blocks = ["10.96.0.0/16"]
        }
      }
      ```

  1. Create a cluster with a node group and apply the security groups with rules as follows:

      ```hcl
      resource "yandex_kubernetes_cluster" "k8s-cluster" {
        name = "k8s-cluster"
        service_account_id = "<service_account_ID_for_cluster>"
        node_service_account_id = "<service_account_ID_for_node_groups>"
        cluster_ipv4_range = "10.96.0.0/16"
        service_ipv4_range = "10.112.0.0/16"
        network_id = "<cloud_network_ID>"
        master {
          master_location {
            zone      = "{{ region-id }}-a"
            subnet_id = "<cloud_subnet_ID_in_zone>"
          }
          master_location {
            zone      = "{{ region-id }}-b"
            subnet_id = "<cloud_subnet_ID_in_zone>"
          }
          master_location {
            zone      = "{{ region-id }}-d"
            subnet_id = "<cloud_subnet_ID_in_zone>"
          }
          security_group_ids = [
            yandex_vpc_security_group.k8s-cluster-nodegroup-traffic.id,
            yandex_vpc_security_group.k8s-cluster-traffic.id
          ]
          public_ip = true
        }
      }

      resource "yandex_kubernetes_node_group" "worker-nodes-a" {
        cluster_id = yandex_kubernetes_cluster.k8s-cluster.id
        name       = "worker-nodes-a"
        allocation_policy {
          location {
            zone = "{{ region-id }}-a"
          }
        }
        scale_policy {
          fixed_scale {
            size = 1
          }
        }
        instance_template {
          network_interface {
            nat                = true
            subnet_ids         = [<cloud_subnet_ID>]
            security_group_ids = [
              yandex_vpc_security_group.k8s-cluster-nodegroup-traffic.id,
              yandex_vpc_security_group.k8s-nodegroup-traffic.id,
              yandex_vpc_security_group.k8s-services-access.id,
              yandex_vpc_security_group.k8s-ssh-access.id
            ]
          }
        }
      }
      ```

{% endlist %}
