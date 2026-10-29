---
title: Large clusters in {{ managed-k8s-full-name }}
description: '{{ managed-k8s-name }} features for clusters from hundreds to thousands of nodes: expanding address space in pods, autoscaling, and NLB target groups.'
---

# Large clusters

In {{ managed-k8s-name }}, you can scale clusters from a few hundred to several thousand nodes to support resource-intensive applications and large numbers of services. As a cluster scales, its demand for compute resources and IP addresses grows, increasing the load on the master nodes, DNS servers, and network load balancers.

To maintain application performance under such loads, use the following {{ managed-k8s-name }} features.

## Multiple pod IP ranges {#multi-cidr}

Every new node requires a block of IP addresses for its pods. If available blocks run out, the cluster cannot scale even if you have sufficient computing resources. Support for multiple ranges of pod IP addresses (Cluster Multi-CIDR) allows you to add ranges without downtime or recreating the cluster. The existing nodes and pods preserve their IP addresses.

For more on requirements and adding ranges, see [{#T}](cluster-multi-cidr.md).

## Network load balancer target groups {#load-balancers}

Dedicated target groups allow you to restrict health checks to the nodes that host the pods of your target application. This reduces loads induced by checks in large clusters.

Learn more about target group management in [{#T}](load-balancer-target-groups.md).

## Cluster resource autoscaling {#autoscaling}

Autoscaling helps adapt cluster resources to changing workloads. The following autoscaling types are available in {{ managed-k8s-name }}:

* Master scaling ({{ k8s-ma }}): Adjusts the master node vCPU count and RAM size based on current cluster load.
* Node group scaling ({{ k8s-ca }}): Adds or removes nodes based on cluster load.
* Horizontal pod scaling ({{ k8s-hpa }}): Changes the number of application pod replicas.
* Vertical pod scaling ({{ k8s-vpa }}): Adjusts the vCPU and RAM resources allocated to individual pods. 

Learn more about the operation, configuration, and limitations of these methods in [{#T}](autoscale.md).

## DNS autoscaling {#dns-autoscaling}

As the number of pods grows, so does the number of requests sent to the cluster DNS. The `kube-dns-autoscaler` application adjusts the number of CoreDNS replicas depending on the number of nodes and vCPUs. This ensures name resolution remains stable as the cluster expands.

To set up scaling, follow the steps in [{#T}](../tutorials/dns-autoscaler.md). You can also implement [local DNS caching on nodes](../tutorials/node-local-dns.md) to further reduce the load on CoreDNS.

## Quota increase and resource reserve {#quotas}

Before creating or scaling a cluster, estimate how many nodes, node groups, vCPUs, and how much RAM and disk space you will need. Provide a reserve for load spikes and temporary nodes. For autoscaling groups, calculate your requirements based on the maximum group size: this value is used to calculate quotas regardless of the current number of nodes.

Check the [{{ managed-k8s-name }} quotas](limits.md) as well as [{{ compute-name }}](../../compute/concepts/limits.md), [{{ vpc-name }}](../../vpc/concepts/limits.md), and [{{ network-load-balancer-name }} quotas](../../network-load-balancer/concepts/limits.md). If the quotas are not sufficient, [request their increase](../../overview/concepts/quotas-limits.md#quotas) in advance.

## Get started with large clusters {#get-started}

[Create a cluster from scratch](../operations/kubernetes-cluster/kubernetes-cluster-create.md) or [migrate your existing workloads](../tutorials/migration/index.md) to {{ managed-k8s-name }}.
