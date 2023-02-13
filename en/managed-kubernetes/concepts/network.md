# Network in {{ managed-k8s-name }}

When [creating a {{ k8s }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md), you can configure the:
* [Network and subnet](../../vpc/concepts/network.md#network) for the [master](./index.md#master).
* Range of IP addresses for [pods](./index.md#pod).
* Range of IP addresses for [services](./index.md#service).
* Node subnet mask.

You can also:
* Request a [public IP address](../../vpc/concepts/ips.md) to access the [cluster](./index.md#kubernetes-cluster) from outside {{ yandex-cloud }}.
* Configure [network policy controllers](network-policy.md) to manage the address space within the cluster.

## Network resources {#network-resources}

{{ k8s }} clusters in the {{ yandex-cloud }} infrastructure use the following resources:
* Subnets.

  When creating a cluster without tunnel mode, {{ managed-k8s-name }} reserves two subnets: for pods and services. For a cluster with [tunnel mode](network-policy.md#cilium), subnets in the address space of the cloud network are not reserved.
* Public IP addresses.

  By [creating a node group](../operations/node-group/node-group-create.md) with a public address, each node in the group will be assigned a public IP address.

## Managing address space {#address-space}

{{ k8s }} clusters that don't use tunnel mode are subject to the following limitations:
* The ranges of the subnets being created should not overlap with the existing ranges.
* Only half of the possible subnet range is available for nodes.

The following subnet ranges are available for the pods, nodes, and services of such clusters:
* `10.0.0.0/8`.
* `172.16.0.0/12`.
* `192.168.0.0/16`.

The node subnet mask and the subnet size for the pods determines the maximum number of nodes in the cluster and the maximum number of pods per node.

For clusters in [tunnel mode](network-policy.md#cilium), the following subnet ranges are available:
* `10.0.0.0/8`.
* `172.16.0.0/12`.
* `192.168.0.0/16`.
* `100.64.0.0/10`.

{% note info %}

For such clusters, restrictions regarding half the possible subnet range or the overlapping of ranges do not apply.

{% endnote %}

For example, when [creating a cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md) with the following parameters:
* Tunnel mode is not enabled.
* Range of IP addresses for pods: `10.1.0.0/16`.
* Range of IP addresses for services: `10.2.0.0/16`.
* Node subnet mask: `24`.

The cluster will have:
* Ranges of IP addresses for nodes: `10.1.128.0/24` – `10.1.255.0/24`.
* IP addresses for pods on each node: `10.1.128.2` – `10.1.128.255`, `10.1.129.2` – `10.1.129.255`, and so on.

## Node name and FQDN {#hostname}

{{ managed-k8s-name }} generates a name for each node when it is created. This name will be the host's fully qualified [domain name (FQDN)](../../compute/concepts/network.md#hostname). You cannot change the node name or FQDN.

Use the FQDN to access the node within a single cloud network. For more information, see [{#T}](../../vpc/concepts/address.md).

## Public access to cluster nodes {#public-access-to-a-host}

Any {{ k8s }} cluster node can be accessed from outside {{ yandex-cloud }} provided that you requested a public address when creating the node group.

To connect to this kind of node from the internet, use its public IP address.

You can request a public IP address:
* For the master, only when [creating a cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md).
* For nodes, when [creating](../operations/node-group/node-group-create.md) or [changing](../operations/node-group/node-group-update.md#node-internet-access) a group.

When a node is deleted, its corresponding public IP address is revoked.