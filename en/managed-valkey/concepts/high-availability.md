---
title: High availability of a {{ mrd-name }} cluster
description: The high availability of a {{ mrd-name }} cluster is ensured by the replication and master failover mechanism, the number of hosts, storage and persistence settings, and cluster maintenance scheduling.
---

# High availability of a {{ mrd-name }} cluster

[High availability](../../architecture/fault-tolerance.md#mdb-ha) is the ability of a system to quickly recover functionality in the event of failure, ensuring continuous service operation for clients.

The high availability of a {{ mrd-name }} cluster depends on the [SLA](https://yandex.com/legal/cloud_sla_mdb/en/)-related parameters and some other settings.

## Number and placement of cluster hosts {#host-configuration}

### For a non-sharded cluster

A single-host cluster does not provide high availability. If the master fails, your cluster becomes unavailable for reading and writing until the master is recovered.

If your cluster has at least two hosts, it remains available if one of them fails. A cluster is resilient to a failure of one availability zone if no zone contains more than half of all its hosts.

### For a sharded cluster

If each cluster shard has at least two hosts, such a cluster remains available if one of the hosts fails. A cluster is resilient to a failure of one availability zone if no zone contains more than half of the hosts belonging to a single shard.

## Replication and master failover settings {#replication-settings}

High availability is achieved through [replication and master failover](replication.md), which work as follows:

* [rdsync](https://github.com/yandex/rdsync), a host status management agent by Yandex, was integrated into the {{ mrd-name }} architecture; this agent automatically selects a new master and switches over to it in the event of a master failure. To ensure the optimal performance of `rdsync`, the number of hosts in the cluster must be even.
* You can influence new master selection in a {{ mrd-name }} cluster by [configuring priorities](replication.md#master-failover) for cluster hosts.
* You can [manually](../operations/failover.md) select a new master and switch over to it.
* If you use public access for the host, you must also enable it for the replicas, otherwise the cluster will become unavailable following master failover.
* {{ mrd-name }} clusters use [asynchronous replication](replication.md#replication), i.e., the result of a write request is committed to the master host, which then forwards the data to the cluster replicas.

## Connecting to a database {#connect}

Cluster availability depends on the connection method and settings:
* Only use [recommended clients](../concepts/supported-clients.md) for connection.
* [Configure security groups](../operations/connect/index.md#configuring-security-groups).
* Set the values of the [Timeout](settings-list.md#settings-timeout), [Maxmemory policy](settings-list.md#settings-maxmemory-policy), [Maxmemory percent](settings-list.md#settings-maxmemory-percent), [Client output buffer limit normal](settings-list.md#settings-limit-normal), and [Client output buffer limit pubsub](settings-list.md#settings-limit-pubsub) {{ VLK }} settings so that under there are no write operation failures or mass connection interruptions normal operating conditions.

## Storage settings {#storage-settings}

If the database storage is 100% full, the cluster will switch to read-only mode. To keep your cluster writable:
* Enable [automatic storage expansion](../concepts/storage.md#auto-rescale).
* Create an [alert](../concepts/storage.md#read-only-monitor) to monitor storage utilization.

## Persistence settings and the WAIT command {#persistence-settings}

To increase fault tolerance:
* Enable persistence on replicas.
* Use the `WAIT` command with `N/2` available replicas, where `N` is the number of cluster hosts.

## Virtual machine type {#vm-type}

Cluster availability depends on the type of VMs you use to deploy your hosts. A highly available cluster should use a VM type with a 100% vCPU guarantee. The **burstable** VM type with a 50% vCPU guarantee does not ensure high availability and should only be used for test environments.

## Other settings {#other-settings}

The following cluster parameters and settings may also affect its availability:

* [Backup settings](backup.md).
* [Storage disk type](storage.md) you selected.
* [Host classes](instance-types.md).
* [Quotas and limits](limits.md).

## Maintaining a cluster and modifying its parameters {#maintenance}

The following operations may lead to interrupted connections, temporary performance degradation, or temporary cluster unavailability:
* Starting [maintenance operations](../concepts/maintenance.md) (the start time is set by selecting a [maintenance window](../concepts/maintenance.md#maintenance-window)) may cause interrupted connections and temporary write unavailability of the cluster.
* [Updating the {{ VLK }} version](../operations/cluster-version-update.md), [changing the host class](../operations/update.md#change-resource-preset), [changing the disk type, or increasing the storage size](../operations/update.md#change-disk-size) leads to interrupted connections, temporary performance degradation, or temporary write unavailability of the cluster.
* Updating the [Databases {{ VLK }} setting](settings-list.md#settings-databases) leads to interrupted connections and temporary write unavailability of the cluster.
* Automatic and manual database [backups](../concepts/backup.md) may cause temporary performance degradation of the cluster.

Run these operations when the cluster load is minimal.
