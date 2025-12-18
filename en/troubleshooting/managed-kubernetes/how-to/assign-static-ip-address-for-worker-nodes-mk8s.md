# How to assign static external IP addresses to {{ managed-k8s-name }} cluster nodes


## Case description {#case-description}

You need to assign a static external IP address to nodes in a {{ managed-k8s-name }} node group.

## Solution {#case-resolution}

You cannot set a static IP address for a {{ k8s }} cluster or its nodes. When using a public IP address, {{ yandex-cloud }} randomly [assigns](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) one from its pool.

To assign a static public IP address to your cluster nodes, use one of these options:

* Host your cluster behind a [load balancer with an external static IP address](../../../managed-kubernetes/operations/create-load-balancer.md).
* Set up egress traffic routing via a [NAT instance](../../../tutorials/routing/nat-instance/index.md) having a static external IP address.
