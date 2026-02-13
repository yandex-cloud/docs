---
title: High availability of a {{ mmy-full-name }} cluster
description: High availability is the ability of a system to continue to operate when one or more of its components fail. High availability of a {{ mmy-name }} cluster depends on the number and placement of its hosts, replication settings, and other cluster parameters.
---

# High availability of a {{ mmy-name }} cluster

This article describes the cluster settings referred to in the [service level agreement (SLA)](https://yandex.com/legal/cloud_sla_mdb/en/), as well as other settings and parameters affecting [high availability of a {{ mmy-name }} cluster](../../architecture/fault-tolerance.md#mdb-ha).

## Number and placement of cluster hosts {#host-configuration}

A cluster may consist of one or more hosts.

A single-host cluster does not provide high availability. If the master host fails, your cluster will be unavailable for reading and writing until the host is fully recovered.

A cluster with two or more hosts located in different availability zones is tolerant of a single zone failure. For production environments with strict requirements for availability and performance, we recommend using clusters with three or more hosts: if one zone fails, redundancy is maintained and there is no significant drop in performance.

{% note info %}

A host with a [manually set replication source](replication.md#manual-source) is not counted into the minimum number of hosts required to ensure the high availability of a cluster.

{% endnote %}

## Replication and master failover settings {#replication-settings}

High availability is achieved through [replication and master failover](replication.md), which work as follows:
* Clusters use a mechanism for automatic selection and failover to a new master. If the master host fails, one of its replicas becomes a new master. You can also select a new master and [switch to it](../operations/update.md#start-manual-failover) manually.
* For any replica, you can [manually select](replication.md#manual-source) a host as the replication source. Such a replica will not be involved in the master selection and failover mechanism.
* If you use public access for the host, you must also enable it for the replicas, otherwise the cluster will become unavailable following master failover.
* Using the [current master's FQDN](../operations/connect/fqdn.md#fqdn-master) simplifies application development; however, your cluster will be temporarily unavailable while switching to a new master. To quickly switch to a new master, you need to implement the new master definition on the application side.
* {{ mmy-name }} clusters use [semi-sync replication](https://dev.mysql.com/doc/refman/5.7/en/replication-semisync.html): by default, the master waits for a transaction to be completed in at least one replica. You can increase the minimum number of replicas that must confirm a transaction using the {{ MY }} [Rpl semi sync master wait for slave count](settings-list.md#setting-rpl-wait-slave-count) setting. We recommend to set **Rpl semi sync master wait for slave count** to at least the maximum number of hosts per zone, not including hosts with a manually selected replication source. Then each transaction will be confirmed by at least one replica in another availability zone, so that even if an entire zone fails, the transactions will not be lost.

## Available storage space {#storage-settings}

If the database storage reaches 95% capacity, the cluster will switch to read-only mode. To keep your cluster writable, regularly [check its _Disk usage_ chart](../operations/monitoring.md#monitoring-cluster) or [create an alert with the `disk.used_bytes` metric](../operations/monitoring.md#monitoring-integration).

## Maintenance settings {#maintenance-settings}

During cluster [maintenance](maintenance.md) and [{{ MY }}](../operations/cluster-version-update.md) version updates, read performance may temporarily drop and the cluster may become temporarily unavailable for writing. Consider the expected load on your cluster when deciding on:
* [Maintenance window](maintenance.md#maintenance-window).
* Time for the {{ MY }} version upgrade.

## Other settings {#other-settings}

The following settings may also affect cluster availability:

* [Backup settings](backup.md).
* [Storage disk type](storage.md) you selected.
* [Host classes](instance-types.md).
* [Quotas and limits](limits.md).
* [Configuring security groups](../operations/connect/index.md#configuring-security-groups).
* {{ MY }} [Max connections](settings-list.md#setting-max-connections) and [Sync binlog](settings-list.md#setting-sync-binlog) settings.
