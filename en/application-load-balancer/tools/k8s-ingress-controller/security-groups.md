---
title: "Configuring security groups for {{ alb-name }} tools for {{ managed-k8s-name }}"
description: "For an Ingress controller or Gateway API to work properly, you need to configure security groups for your {{ managed-k8s-full-name }} cluster and node groups, and the {{ alb-name }} load balancer."
---

# Configuring security groups for {{ alb-name }} tools for {{ managed-k8s-name }}


For the [Ingress controller](index.md) or [Gateway API](../k8s-gateway-api/index.md) to work properly, you need to configure [security groups](../../../vpc/concepts/security-groups.md) for your [cluster](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster), [{{ managed-k8s-full-name }} node groups](../../../managed-kubernetes/concepts/index.md#node-group), and {{ alb-name }} [load balancer](../../concepts/application-load-balancer.md).

You can use different security groups (recommended) or the same group for the cluster, the node groups, and the load balancer.

Within the security groups, you must configure:
* All standard rules described in the relevant documentation sections:
   * For a cluster and node groups: see the {{ managed-k8s-name }} documentation, [{#T}](../../../managed-kubernetes/operations/connect/security-groups.md).
   * For a load balancer: see [{#T}](../../concepts/application-load-balancer.md#security-groups). The last rule for outgoing traffic to [backend](../../concepts/backend-group.md) VMs must allow connections in the [subnet](../../../vpc/concepts/network.md#subnet) of the cluster [node groups](../../../managed-kubernetes/concepts/index.md#node-group) or its security group.
* Backend state check rules, allowing:
   * The load balancer to send traffic to cluster nodes via TCP to port 10501 (destination: cluster node group subnets or security groups).
   * Node groups to receive this traffic (traffic originates in the load balancer subnets or security group).
      Cluster and node group security groups are specified in their settings. For more information, see the guides below:
* [Creating](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and [updating](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md#update-cluster) a cluster
* [Creating](../../../managed-kubernetes/operations/node-group/node-group-create.md) and [updating](../../../managed-kubernetes/operations/node-group/node-group-update.md) a node group


Security group IDs are specified in:
* The `Ingress` resource: In the `ingress.alb.yc.io/security-groups` annotation. If you create a load balancer for several `Ingress` resources, it is assigned all the security groups specified for these `Ingress` resources.
* The `Gateway` resource: In the `gateway.alb.yc.io/security-groups` annotation.



## Example configuration {#example}

Let us provide an example for the following conditions:
* You need to deploy a load balancer with a [public IP](../../../vpc/concepts/address.md#public-addresses) to accept HTTPS traffic, on 3 subnets with CIDRs `10.128.0.0/24`, `10.129.0.0/24`, and `10.130.0.0/24`, hereafter marked \[B\].
* When creating the cluster, its CIDR was specified as `10.96.0.0/16` \[C\], and the service CIDR as `10.112.0.0/16` \[S\].
* The cluster's node group is located on a subnet with CIDR `10.140.0.0/24` \[Nod\].
* You can only [connect](../../../managed-kubernetes/operations/node-connect-ssh.md) to the nodes via SSH and control the cluster using the API, `kubectl`, and other utilities from CIDR `203.0.113.0/24` \[Con\].

Then, you need to create the following rules in the security groups:
* Cluster security group and housekeeping node groups:

   {% list tabs group=traffic %}

   - Egress traffic {#outgoing}

      | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} |
      --- | --- | --- | --- | ---
      | `All` (`{{ port-any }}`) | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`) | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | For all outgoing traffic |

   - Incoming traffic {#incoming}

      | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} |
      --- | --- | --- | --- | ---
      | `All` (`{{ port-any }}`) | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | — | For a network load balancer |
      | `All` (`{{ port-any }}`) | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`) | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`) | For traffic between [master](../../../managed-kubernetes/concepts/index.md#master) and nodes |
      | `All` (`{{ port-any }}`) | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`) | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.96.0.0/16`[^\[C\]^](#example)<br>`10.112.0.0/16`[^\[S\]^](#example) | For traffic between [pods](../../../managed-kubernetes/concepts/index.md#pod) and [services](../../../managed-kubernetes/concepts/index.md#service) |
      | `All` (`{{ port-any }}`) | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_ipv6-icmp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.0.0.0/8`<br>`192.168.0.0/16`<br>`172.16.0.0/12` | For functionality verification of nodes from subnets within {{ yandex-cloud }} |

   {% endlist %}

* Node group security group for connecting to services from the Internet:

   {% list tabs group=traffic %}

   - Incoming traffic {#incoming}

      | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} |
      --- | --- | --- | --- | ---
      | `30000-32767` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | For service access from the Internet and from the {{ yandex-cloud }} subnets |

   {% endlist %}

* Node group security group for connecting to nodes over SSH:

   {% list tabs group=traffic %}

   - Incoming traffic {#incoming}

      | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} |
      --- | --- | --- | --- | ---
      | `30000-32767` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `203.0.113.0/24`[^\[Con\]^](#example) | For connecting to nodes over SSH |

   {% endlist %}

* Cluster security group for access to the {{ k8s }} API:

   {% list tabs group=traffic %}

   - Egress traffic {#outgoing}

      | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} |
      --- | --- | --- | --- | ---
      | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `203.0.113.0/24`[^\[Con\]^](#example) | For access to the {{ k8s }} API |
      | `6443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `203.0.113.0/24`[^\[Con\]^](#example) | For access to the {{ k8s }} API |

   {% endlist %}

* Node group security group for backend status checks:

   {% list tabs group=traffic %}

   - Incoming traffic {#incoming}

      | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} |
      --- | --- | --- | --- | ---
      | `10501` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.128.0.0/24`[^\[B\]^](#example)<br>`10.129.0.0/24`[^\[B\]^](#example)<br>`10.130.0.0/24`[^\[B\]^](#example) | For backend status checks |

   {% endlist %}

* Load balancer security group:

   {% list tabs group=traffic %}

   - Egress traffic {#outgoing}

      | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} |
      --- | --- | --- | --- | ---
      | `All` (`{{ port-any }}`) | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.140.0.0/24`[^\[Nod\]^](#example) | For outgoing traffic to nodes, including status checks |

   - Incoming traffic {#incoming}

      | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} |
      --- | --- | --- | --- | ---
      | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | For receiving incoming HTTP traffic |
      | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | For receiving outgoing HTTP traffic |
      | `30080` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | — | For load balancer node status checks |

   {% endlist %}