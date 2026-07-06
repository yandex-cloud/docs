# Networking in {{ msp-full-name }}

When creating a cluster, you can specify the following network settings:

* [Network and subnet](../../vpc/concepts/network.md) within it.

  There are certain [requirements](#subnet-requirements) for the subnet, since a cluster allocates special [network addresses](#addresses).

* [Security groups](#security-groups) to allow only specific outbound traffic.

## Cluster network addresses {#addresses}

A {{ msp-full-name }} cluster allocates special network addresses in its subnet. It uses them to establish connections to {{ yandex-cloud }} resources. For example, you can [set up a connection to a database](../../managed-spark/tutorials/job-pyspark-secret-access.md) in a {{ mpg-full-name }} cluster.

The {{ msp-full-name }} cluster connects to {{ yandex-cloud }} resources within the internal network; therefore, it only uses internal allocated network addresses. To give your cluster access to resources on the internet, [configure a NAT gateway](../../vpc/operations/create-nat-gateway.md). When setting it up, link the route table with the NAT gateway to the {{ msp-full-name }} cluster subnet.

The {{ msp-full-name }} cluster allocates only dynamic network addresses. These may change, e.g., during maintenance.

## Connecting a cluster to your on-premise resources {#on-premise}

You can set up network connectivity between a {{ msp-full-name }} cluster in the cloud and your on-premise resources. In which case the cluster will be able to connect to your on-premise resources.

Limit access to your on-premise resources using a firewall. In order to only allow access for traffic from a {{ msp-full-name }} cluster, create a dedicated subnet for it and specify its range in the firewall settings. When configuring, do not use specific network addresses and do not place other resources in the created subnet.

For more information about setting up such network connectivity, see the [{{ interconnect-full-name }} documentation](../../interconnect/concepts/index.md).

## Requirements for cluster subnets {#subnet-requirements}

Make sure your {{ msp-full-name }} cluster subnet meets the following conditions:

* The cluster network range does not overlap with the {{ airflow-service-address }} address range. This range is used by the the auxiliary network in which {{ yandex-cloud }} manages the {{ msp-full-name }} cluster's components.

  The cluster network range combines the ranges of all subnets in this network. This includes subnets not assigned for the cluster. For example, if the cluster is in `subnet-a`, while the network also features `subnet-b` and `subnet-d`, none of these subnets can have its range overlapping with {{ spark-service-address }}.

  If this condition is not met, you will get an error when creating the cluster.

  This requirement also applies to your [on-premise](#on-premise) networks. From a {{ msp-full-name }} cluster, you will not be able to connect to resources with IPs from the {{ spark-service-address }} range.

* The subnet range includes at least `2 × N + 2` vacant IP addresses, where `N` is the total number of nodes that factors in maximum autoscaling. For example, a cluster consists of two hosts for drivers and of `1` to `8` hosts for executors. Then, `N = 10`, and the subnet must have at least `22` vacant addresses.

  This is the number of addresses you need for the cluster's special [network addresses](#addresses). If there are not enough vacant addresses in the subnet, the cluster will not operate properly.

  As the number of occupied IP addresses may vary, it is recommended to select a subnet with a sufficiently large number of addresses. To figure out the number of vacant IP addresses in the subnet, calculate its size by mask and then [learn how many addresses are occupied](../../vpc/operations/subnet-used-addresses.md).

## Security groups {#security-groups}

[Security group](../../vpc/concepts/security-groups.md) settings only apply to outgoing traffic for connections from the {{ msp-full-name }} cluster. Therefore, you only need to configure rules for outgoing traffic to access specific resources.

Security group settings do not affect cluster functions or access to {{ SPRK }} web interfaces (Spark History, Spark UI).

If you assign no security group to the {{ msp-full-name }} cluster, it is automatically assigned the default group used in the cluster network. In such a security group, all traffic is allowed by default.

Make sure the security group settings of the {{ yandex-cloud }} resource allow connections from the cloud network of the {{ msp-full-name }} cluster.

## Use cases {#examples}

[Automating operations using {{ maf-full-name }}](../../managed-spark/tutorials/airflow-automation.md)
