---
title: Configuring security groups for {{ managed-k8s-name }} {{ alb-name }} tools
description: To ensure proper operation of the ingress controller and Gateway API, you must configure appropriate security groups for your cluster, {{ managed-k8s-full-name }} node groups, and {{ alb-name }}.
---

# Configuring security groups for {{ managed-k8s-name }} {{ alb-name }} tools 

To ensure proper operation of the [ingress controller](index.md) and [Gateway API](../k8s-gateway-api/index.md), you must configure appropriate [security groups](../../../vpc/concepts/security-groups.md) for your [cluster](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster), [{{ managed-k8s-full-name }} node groups](../../../managed-kubernetes/concepts/index.md#node-group), and [load balancer](../../concepts/application-load-balancer.md).

We recommend using separate security groups for your cluster, node groups, and load balancer, although a shared group is also permitted.

Within each security group, you must configure:
* All required security group rules documented in the relevant guides:
  * For cluster and node groups, see the [{#T}](../../../managed-kubernetes/operations/connect/security-groups.md) section of the {{ managed-k8s-name }} documentation.
  * For the load balancer, see [{#T}](../../concepts/application-load-balancer.md#security-groups). The final outbound rule for [backend](../../concepts/backend-group.md) VMs must allow connections to either the CIDR range of your cluster’s [node group](../../../managed-kubernetes/concepts/index.md#node-group) [subnet](../../../vpc/concepts/network.md#subnet) or the security group associated with your node groups.
* Backend health check rules, allowing:
  * The load balancer to send TCP traffic to port 10501 on cluster nodes, targeting either the node groups’ subnet CIDR ranges or their security groups.
  * Node groups to receive this traffic (traffic originates in the load balancer subnets or security group).

Security groups for both the cluster and node groups are specified in their respective configurations. For more information, see the guides below:
* [Creating](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and [updating](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md#update-cluster) a cluster.
* [Creating](../../../managed-kubernetes/operations/node-group/node-group-create.md) and [updating](../../../managed-kubernetes/operations/node-group/node-group-update.md) a node group.

Security group IDs are specified in the following configuration locations:
* For the `Ingress` resource, in the `ingress.alb.yc.io/security-groups` annotation. A load balancer associated with multiple `Ingress` resources aggregates all security groups defined in their configurations.
* For the `Gateway` resource, in the `gateway.alb.yc.io/security-groups` annotation.

## Configuration example {#example}

Consider an example for the following conditions:
* You need to deploy a load balancer with a [public IP address](../../../vpc/concepts/address.md#public-addresses) to accept HTTPS traffic in three subnets with `10.128.0.0/24`, `10.129.0.0/24`, and `10.130.0.0/24` CIDR blocks (\[B\]).
* The cluster’s CIDR block is `10.96.0.0/16` (\[C\]), and the service CIDR block is `10.112.0.0/16` (\[S\]).
* The cluster's node group resides in a subnet with the CIDR block `10.140.0.0/24` (\[Nod\]).
* SSH [access](../../../managed-kubernetes/operations/node-connect-ssh.md) to nodes and cluster management (via API, `kubectl`, etc.) are restricted to CIDR `203.0.113.0/24` (\[Con\]).

To meet these conditions, you need to create the following rules in the security groups:

* [Load balancer security group](../../concepts/application-load-balancer.md#security-groups):

  {% list tabs group=traffic %}

  - Outgoing traffic {#outgoing}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `{{ port-any }}` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.140.0.0/24`[^\[Nod\]^](#example) | For outgoing traffic to nodes, including status checks

  - Incoming traffic {#incoming}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | For receiving incoming HTTP traffic
    `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | For receiving incoming HTTPS traffic
    `30080` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | — | For load balancer node status checks

  {% endlist %}

* Node group’s security group for backend health checks:

  {% list tabs group=traffic %}

  - Incoming traffic {#incoming}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `10501` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.128.0.0/24`[^\[B\]^](#example)<br>`10.129.0.0/24`[^\[B\]^](#example)<br>`10.130.0.0/24`[^\[B\]^](#example) | For backend health checks

  {% endlist %}

* Cluster and node group’s security group for control plane traffic:

  {% list tabs group=traffic %}

  - Outgoing traffic {#outgoing}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`) | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`) | For traffic between the [control plane](../../../managed-kubernetes/concepts/index.md#master) components and worker nodes

  - Incoming traffic {#incoming}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `{{ port-any }}` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | — | For a network load balancer
    `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`) | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`) | For traffic between the control plane components and worker nodes
    `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_ipv6-icmp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.0.0.0/8`<br>`192.168.0.0/16`<br>`172.16.0.0/12` | For node health checks within {{ yandex-cloud }} subnets

  {% endlist %}

* Node group’s security group for control plane traffic:

  {% list tabs group=traffic %}

  - Outgoing traffic {#outgoing}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`) | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | For external resource access

  - Incoming traffic {#incoming}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`) | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.96.0.0/16`[^\[C\]^](#example)<br>`10.112.0.0/16`[^\[S\]^](#example) | For [pod](../../../managed-kubernetes/concepts/index.md#pod) to [service](../../../managed-kubernetes/concepts/index.md#service) communication

  {% endlist %}

* Cluster security group for control plane traffic:

  {% list tabs group=traffic %}

  - Outgoing traffic {#outgoing}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `4443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.96.0.0/16`[^\[C\]^](#example) | For traffic between the control plane components and `metric-server` [pods](../../../managed-kubernetes/concepts/index.md#pod)

  - Incoming traffic {#incoming}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `203.0.113.0/24`[^\[Con\]^](#example) | For {{ k8s }} API access
    `6443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `203.0.113.0/24`[^\[Con\]^](#example) | For {{ k8s }} API access

  {% endlist %}

* Node group’s security group for internet service access:

  {% list tabs group=traffic %}

  - Incoming traffic {#incoming}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `30000-32767` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | For internet and {{ yandex-cloud }} access

  {% endlist %}

* Security group for SSH access to node group instances:

  {% list tabs group=traffic %}

  - Incoming traffic {#incoming}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `203.0.113.0/24`[^\[Con\]^](#example) | For SSH access to nodes

  {% endlist %}

For details on cluster and node group’s security groups, see the [{#T}](../../../managed-kubernetes/operations/connect/security-groups.md) section of the {{ managed-k8s-name }} guides.
