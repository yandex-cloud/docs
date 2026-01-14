---
title: High availability of a {{ mch-full-name }} cluster
description: High availability is the ability of a system to continue to operate when one or more of its components fail. High availability of a {{ mch-name }} cluster depends on the number and placement of its hosts, replication and sharding settings, as well as other cluster properties.
---

# High availability of a {{ mch-full-name }} cluster

[High availability](../../architecture/fault-tolerance.md#mdb-ha) of a {{ mch-name }} cluster depends on the number and placement of its hosts, replication and sharding settings, as well as other cluster properties.

## Number and placement of cluster hosts {#host-configuration}

A {{ mch-name }} cluster consists of one or more shards, where each has one or more hosts.

### Single-host cluster {#one-host}

A cluster with a single {{ CH }} host does not provide high availability. If the host VM fails, such a cluster will be unavailable until the VM recovery is completed. Single-host clusters are not covered by the [Service level agreement (SLA)](https://yandex.ru/legal/cloud_sla_mdb/).

### Cluster with two or more hosts {#two-hosts}

The [Service Level Agreement (SLA)](https://yandex.com/legal/cloud_sla_mdb/en/) defines a high-availability cluster as the one made up of two or more {{ CH }} hosts residing in different [availability zones](../../overview/concepts/geo-scope.md).

A cluster consisting of two or more hosts supports [replication](replication.md): {{ CH }} hosts can step in for one another as the cluster’s primary replica. Such clusters come with a dedicated [coordination service](replication.md), {{ CK }} or {{ ZK }}, which manages replication and query distribution across hosts. You can select the coordination service when [creating a cluster](../operations/cluster-create.md) or add it later. According to the SLA, the coordination service of a high-availability cluster must be deployed on separate hosts. A configuration where {{ CH }} and {{ CK }} share the hosts is not highly available.

A cluster may have three to five coordination service hosts. The optimal number of coordination service hosts for a highly available cluster is three. Increasing the number of {{ ZK }} or {{ CK }} hosts affects cluster availability as follows:

* As opposed to clusters with three coordination service hosts, clusters with four host have lower availability: two out of four hosts are more likely to fail than two out of three.
* Five coordination service hosts ensure the cluster remains highly available: even if two coordination service hosts fail at the same time, this will not lead to cluster failure.

{{ mch-name }} does not support clusters with more than five coordination service hosts.

### Multi-shard cluster {#shards}

Sharding improves cluster availability, but a cluster with multiple single-host shards is not highly available. According to the SLA, to ensure high availability of a sharded cluster, it should have:

* At least two {{ CH }} hosts in each shard, located in different [availability zones](../../overview/concepts/geo-scope.md).
* At least three {{ ZK }} or {{ CK }} hosts located in different [availability zones](../../overview/concepts/geo-scope.md).

[Learn more about the impact of sharding on cluster availability](sharding.md#high-availability).

## Storage settings {#storage-settings}

If storage runs out of space, `INSERT` queries, background merges, and mutations are suspended. [Set up alerts in {{ monitoring-full-name }}](../operations/monitoring.md#monitoring-integration) to monitor storage usage, or enable [automatic storage expansion](storage.md#autoscaling).

## Maintenance settings {#maintenance-settings}

Hosts may require a reboot during maintenance. A cluster consisting of a single {{ CH }} host will be unavailable during a reboot.

If a cluster consists of multiple hosts or shards, the hosts become unavailable one by one. To ensure your applications run continuously, to connect to a cluster or shard, use a [special FQDN](../operations/connect/fqdn.md#auto) always pointing to the available host.

[Learn more about maintenance](maintenance.md).

## Other settings {#other-settings}

Cluster availability may also be affected by:

* [Backup settings](backup.md).
* [Storage disk type](storage.md) you selected.
* [Host classes](instance-types.md).
* [Quotas and limits](limits.md).
* [Security group setup](../operations/connect/index.md#configuring-security-groups).

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
