---
title: High availability of a {{ mmy-full-name }} cluster
description: High availability is the ability of a system to continue to operate when one or more of its components fail. High availability of a {{ mmy-name }} cluster depends on the number and placement of its hosts, replication settings, and other cluster parameters.
---

# High availability of a {{ mmy-name }} cluster

[High availability of a {{ mmy-name }} cluster](../../architecture/fault-tolerance.md#mdb-ha) depends on the number and placement of its hosts, replication settings, and other cluster parameters.

## Number and placement of cluster hosts {#host-configuration}

A single-host cluster does not provide high availability. If the master host VM fails, your cluster will be unavailable for reading and writing until the VM recovers completely. Single-host clusters are not covered by the [Service level agreement (SLA)](https://yandex.com/legal/cloud_sla_mdb/).

A cluster with two hosts located in different availability zones is considered highly available and is subject to the [SLA](https://yandex.com/legal/cloud_sla_mdb/). This option is suitable for medium-sized applications in a production environment.

A cluster with three or more hosts located in three different availability zones is considered highly available and is subject to the [SLA](https://yandex.com/legal/cloud_sla_mdb/). Such clusters are suitable for production environments subject to high availability and performance requirements.

{% note info %}

A host with a [manually set replication source](replication.md#manual-source) is not counted into the minimum number of hosts required to ensure the high availability of a cluster.

{% endnote %}

## Replication and master failover settings {#replication-settings}

High availability is achieved through [replication and master failover](replication.md), which work as follows:
* Clusters use a mechanism for automatic selection and failover to a new master. If the master host fails, one of its replicas becomes a new master.
* For any replica, you can [manually select](replication.md#manual-source) a host as the replication source. Such a replica will not be involved in the master selection and failover mechanism.
* If you use public access for the host, you must also enable it for the replicas, otherwise the cluster will become unavailable following master failover.
* Using the [current master's FQDN](../operations/connect.md#fqdn-master) simplifies application development; however, your cluster will be temporarily unavailable while switching to a new master. To quickly switch to a new master, you need to implement the new master definition on the application side.
* {{ mmy-name }} clusters use [semi-sync replication](https://dev.mysql.com/doc/refman/5.7/en/replication-semisync.html): by default, the master waits for a transaction to be completed in at least one replica. You can increase the minimum number of replicas that must confirm a transaction using the {{ MY }} [Rpl semi sync master wait for slave count](settings-list.md#setting-rpl-wait-slave-count) setting. We recommend to set **Rpl semi sync master wait for slave count** to at least the maximum number of hosts per zone, not including hosts with a manually selected replication source.

## Storage settings {#storage-settings}

If database storage is 95% full, the cluster will switch to **read-only** mode. To keep the cluster writable, we recommend to regularly [check free storage space](../qa/monitoring.md#disk-space-percentage) or [create an alert](../qa/read-write.md#write-failure). 

## Maintenance settings {#maintenance-settings}

During cluster [maintenance](maintenance.md) and [{{ MY }} version updates](../operations/cluster-version-update.md), read performance may temporarily drop and the cluster may become temporarily unavailable for writing. Therefore, we recommend selecting suitable [maintenance day and hour](maintenance.md#maintenance-window), as well as {{ MY }} version update time, based on expected cluster load.

## Other settings {#other-settings}

The following settings may also affect cluster availability:

* [Backup settings](backup.md).
* [Storage disk type](storage.md) you selected.
* [Host classes](instance-types.md).
* [Quotas and limits](limits.md).
* [Configuring security groups](../operations/connect.md#configuring-security-groups).
* {{ MY }} [Max connections](settings-list.md#setting-max-connections) and [Sync binlog](settings-list.md#setting-sync-binlog) settings.
