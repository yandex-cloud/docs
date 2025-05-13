# Networking in {{ maf-name }}

When creating a cluster, you can specify the following network settings:

* [Availability zones](../../overview/concepts/geo-scope.md) that can host [cluster components](index.md#components).
* [Network and subnets](../../vpc/concepts/network.md) within it. Subnets correspond to the selected availability zones.

   There are certain [requirements](#subnet-requirements) for subnets, because a cluster allocates special [network addresses](#addresses).

* [Security groups](#security-groups) to allow strictly defined outgoing traffic.

## Cluster network addresses {#addresses}

A {{ maf-name }} cluster allocates special network addresses in its subnets. It uses them to establish connections to {{ yandex-cloud }} resources (the connections are specified in [directed acyclic graphs (DAGs)](index.md#about-the-service)). For example, you can [set up a connection to a database](../operations/lockbox-secrets-in-maf-cluster.md) in a {{ mpg-full-name }} cluster.

The allocated network addresses are internal: the cluster connects to {{ yandex-cloud }} resources within the internal network. If you need to grant the cluster access to internet resources, [configure a NAT gateway](../../vpc/operations/create-nat-gateway.md). When configuring it, link the route table with the NAT gateway to all the {{ maf-name }} cluster subnets.

The cluster allocates dynamic network addresses. These may change, e.g., during maintenance. Therefore, you should use cluster subnet ranges instead of particular addresses, e.g., in your [on-premise](#on-premise) firewall settings.

## Connecting a cluster to your on-premise resources {#on-premise}

You can set up network connectivity between a {{ maf-name }} cluster in the cloud and your on-premise resources. In which case the cluster will be able to connect to your on-premise resources.

Limit access to your on-premise resources using a firewall. In order to grant access only for traffic from an {{ AF }} cluster, create separate subnets for it and specify their ranges in firewall settings. Do not place any other resources in the subnets you created.

For more information about setting up such network connectivity, see the [{{ interconnect-full-name }} documentation](../../interconnect/concepts/index.md).

## Requirements for cluster subnets {#subnet-requirements}

Each {{ maf-name }} cluster subnet must meet the following conditions:

* The cluster network range does not overlap with the {{ airflow-service-address }} address range of the auxiliary network {{ yandex-cloud }} manages the {{ maf-name }} cluster components in.

   The cluster network range combines the ranges of all subnets in this network. This includes subnets not assigned for the cluster. For example, if the cluster is in `subnet-a`, while the network also features `subnet-b` and `subnet-d`, none of these subnets can have its range overlapping with {{ airflow-service-address }}.

   If this condition is not met, you will get an error when creating the cluster.

   This requirement also applies to your [on-premise](#on-premise) networks. From an {{ AF }} cluster, you will not be able to connect to resources with IPs from the {{ airflow-service-address }} range.

* The subnet range includes at least `2 × N` vacant IP addresses, where `N` is the total number of instances of all components. Let's assume that the cluster consists of two web servers, three schedulers, five workers, and one Triggerer service. Then, `N = 11`, and the subnet must have at least `22` vacant addresses.

   This is the number of addresses you need for the cluster's special [network addresses](#addresses). If there are not enough vacant addresses in the subnet, the cluster will not be able to operate properly.

   To figure out the number of vacant IP addresses in the subnet, calculate its size by mask and then [learn how many addresses are occupied](../../vpc/operations/subnet-used-addresses.md). However, as the number of occupied IP addresses may vary, it is better to select a large enough subnet.

## Security groups {#security-groups}

[Security group](../../vpc/concepts/security-groups.md) settings do not affect a {{ maf-name }} cluster's functions; you need them only for outgoing connections from the cluster.

Security groups allow limiting only outgoing traffic for a {{ maf-name }} cluster, so there is no need to set rules for incoming traffic. Outgoing traffic rules allow the cluster to connect only to specified resources. But security group settings affect neither access to the [{{ AF }} web interface](../operations/af-interfaces.md#web-gui) nor incoming traffic, which only enters the cluster’s web server.

If you assign no security group for the {{ maf-name }} cluster, it will automatically be assigned the cluster network's default security group. When this network is created, all traffic is allowed in the default security group.

{% note tip %}

When connecting to a {{ yandex-cloud }} resource from the cloud network of a {{ maf-name }} cluster, also set up security groups for the resource the cluster is connecting to.

{% endnote %}


## Use cases {#examples}

* [{#T}](../tutorials/airflow-auto-tasks.md)