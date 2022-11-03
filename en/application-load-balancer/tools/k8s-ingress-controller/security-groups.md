# Configuring {{ alb-name }} Ingress controller security groups

{% include [security-groups-note](../../_includes_service/security-groups-note.md) %}

For an [Ingress controller](index.md) to work properly, you need to configure security groups for your cluster, {{ managed-k8s-name }} node groups, and the {{ alb-name }} load balancer. You can use different security groups (recommended) or the same group for the cluster, the node groups, and the load balancer.

Within the security groups, you must configure:

* All the standard rules described in the relevant documentation sections:

   * For a cluster and node groups: see {{ managed-k8s-name }} documentation, [{#T}](../../../managed-kubernetes/operations/connect/security-groups.md).
   * For a load balancer: see [{#T}](../../concepts/application-load-balancer.md#security-groups). The final rule for outgoing traffic to the VM backends must allow connections to the cluster [node group](../../../managed-kubernetes/concepts/index.md#node-group) subnets and security groups.

* Backend state check rules, allowing:

   * The load balancer to send traffic to cluster nodes via TCP port 10501 (destination: cluster node group subnets or security groups).
   * Node groups to receive this traffic (traffic originates in the load balancer subnets or security group).

Cluster and node group security groups are specified in their settings. For more information, see the instructions below:

* [Creating](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and [updating](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md#update-cluster) a cluster.
* [Creating](../../../managed-kubernetes/operations/node-group/node-group-create.md) and [updating](../../../managed-kubernetes/operations/node-group/node-group-update.md) a group of nodes.

Load balancer security group IDs are specified in the `ingress.alb.yc.io/security-groups` annotation of the `Ingress` resource. If you create a load balancer for several `Ingress` resources, it is assigned all the security groups specified for these `Ingress` resources.

## Example configuration {#example}

Let us provide an example for the following conditions:

* You need to deploy a load balancer with a public IP to accept HTTPS traffic, on 3 subnets with CIDRs `10.128.0.0/24`, `10.129.0.0/24`, and `10.130.0.0/24`, hereafter marked \[B\].
* When creating the cluster, its CIDR was specified as `10.96.0.0/16` \[C\], and the service CIDR as `10.112.0.0/16` \[S\].
* The cluster's node group is located on a subnet with CIDR `10.140.0.0/24` \[Nod\].
* You can only connect to the nodes via SSH and control the cluster using the API, `kubectl`, and other utilities from CIDR `203.0.113.0/24` \[Con\].

Then, you need to create the following rules in the security groups:

* Cluster security group and housekeeping node groups:

   {% list tabs %}

   - Outgoing traffic

      | Port range | Protocol | Destination type | Purpose | Description |
      | ----- | ----- | ----- | ----- | ----- |
      | All (`{{ port-any }}`) | `Any` | CIDR | `0.0.0.0/0` | For all outgoing traffic |

   - Incoming traffic

      | Port range | Protocol | Source type | Source | Description |
      | ----- | ----- | ----- | ----- | ----- |
      | All (`{{ port-any }}`) | TCP | CIDR | `198.18.235.0/24`<br>`198.18.248.0/24` | For a network load balancer |
      | All (`{{ port-any }}`) | `Any` | Security group | `Self` | For traffic between [master](../../../managed-kubernetes/concepts/index.md#master) and nodes |
      | All (`{{ port-any }}`) | `Any` | CIDR | `10.96.0.0/16`[^\[C\]^](#example)<br>`10.112.0.0/16`[^\[S\]^](#example) | For traffic between [pods](../../../managed-kubernetes/concepts/index.md#pod) and [services](../../../managed-kubernetes/concepts/index.md#service) |
      | All (`{{ port-any }}`) | ICMP | CIDR | `10.0.0.0/8`<br>`192.168.0.0/16`<br>`172.16.0.0/12` | For functionality verification of nodes from subnets within {{ yandex-cloud }} |

   {% endlist %}

* Node group security group for connecting to services from the Internet:

   {% list tabs %}

   - Incoming traffic

      | Port range | Protocol | Source type | Source | Description |
      | ----- | ----- | ----- | ----- | ----- |
      | `30000-32767` | TCP | CIDR | `0.0.0.0/0` | For service access from the Internet and from the {{ yandex-cloud }} subnets |

   {% endlist %}

* Node group security group for connecting to nodes over SSH:

   {% list tabs %}

   - Incoming traffic

      | Port range | Protocol | Source type | Source | Description |
      | ----- | ----- | ----- | ----- | ----- |
      | `30000-32767` | TCP | CIDR | `203.0.113.0/24`[^\[Con\]^](#example) | For connecting to nodes over SSH |

   {% endlist %}

* Cluster security group for access to the Kubernetes API:

   {% list tabs %}

   - Outgoing traffic

      | Port range | Protocol | Destination type | Purpose | Description |
      | ----- | ----- | ----- | ----- | ----- |
      | `443` | TCP | CIDR | `203.0.113.0/24`[^\[Con\]^](#example) | For access to the Kubernetes API |
      | `6443` | TCP | CIDR | `203.0.113.0/24`[^\[Con\]^](#example) | For access to the Kubernetes API |

   {% endlist %}

* Node group security group for backend status checks:

   {% list tabs %}

   - Incoming traffic

      | Port range | Protocol | Source type | Source | Description |
      | ----- | ----- | ----- | ----- | ----- |
      | `10501` | TCP | CIDR | `10.128.0.0/24`[^\[B\]^](#example)<br>`10.129.0.0/24`[^\[B\]^](#example)<br>`10.130.0.0/24`[^\[B\]^](#example) | For backend status checks |

   {% endlist %}

* Load balancer security group:

   {% list tabs %}

   - Outgoing traffic

      | Port range | Protocol | Destination type | Purpose | Description |
      | ----- | ----- | ----- | ----- | ----- |
      | All (`{{ port-any }}`) | TCP | CIDR | `10.140.0.0/24`[^\[Nod\]^](#example) | For outgoing traffic to nodes, including status checks |

   - Incoming traffic

      | Port range | Protocol | Source type | Source | Description |
      | ----- | ----- | ----- | ----- | ----- |
      | `80` | TCP | CIDR | `0.0.0.0/0` | For receiving incoming HTTP traffic |
      | `443` | TCP | CIDR | `0.0.0.0/0` | For receiving outgoing HTTP traffic |
      | `30080` | TCP | CIDR | `198.18.235.0/24`<br>`198.18.248.0/24` | For load balancer node status checks |

   {% endlist %}