# Assigning static external IP addresses to Managed Service for Kubernetes cluster nodes

## Issue description {#case-description}
You need to assign a static external IP address to nodes in a Managed Service for Kubernetes node group.

## Solution {#case-resolution}
You can't set a static IP for a Kubernetes cluster or its nodes. When assigning a public IP, a random IP address is [taken](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) from the Yandex Cloud IP pool.

To assign a static public IP to your cluster nodes, use one of these options:
- Host your cluster behind a [Load balancer with an external static IP](../../../managed-kubernetes/operations/create-load-balancer.md).
- Set up egress traffic routing via a [NAT instance](../../../tutorials/routing/nat-instance/index.md) having a static external IP.
