---
title: High availability of a {{ mpg-full-name }} cluster
description: High availability is the ability of a system to continue to operate when one or more of its components fail. High availability of a {{ mpg-name }} cluster depends on the number and placement of its hosts, replication settings, and other cluster parameters.
---

# High availability of a {{ mpg-name }} cluster

[High availability of a {{ mpg-name }} cluster](../../architecture/fault-tolerance.md#mdb-ha) depends on the number and placement of its hosts, replication settings, and other cluster parameters.

## Number and placement of cluster hosts {#host-configuration}

A cluster may consist of one or more hosts.

A single-host cluster does not provide high availability. If the master host VM fails, your cluster will be unavailable for reading and writing until the VM recovers completely. Single-host clusters are not covered by the [Service level agreement (SLA)](https://yandex.com/legal/cloud_sla_mdb/en/#yandex-managed-service-for-sharded-postgresql-that-fall-under-the-service-level).

{% note warning %}

We do not recommend creating a single-host cluster.

{% endnote %}

A cluster with two hosts located in different availability zones is considered highly available and is subject to the [SLA](https://yandex.com/legal/cloud_sla_mdb/en/). This option is suitable for medium-sized applications in a production environment. The default cluster configuration offered in the management console includes two hosts.

A cluster with three or more hosts located in three different availability zones is considered highly available and is subject to the [SLA](https://yandex.com/legal/cloud_sla_mdb/en/#yandex-managed-service-for-sharded-postgresql-that-fall-under-the-service-level). Such clusters are suitable for production environments subject to high availability and performance requirements.

For more information, see [Planning cluster topology](planning-cluster-topology.md).

## Replication settings {#replication-settings}

High cluster availability is achieved through [replication and master failover](replication.md) mechanisms, which have the following features:

* Clusters uses streaming replication. Each replica host receives a replication stream from another host, typically the master. {{ mpg-name }} manages replication streams in the cluster [automatically](replication.md#replication-auto), but you can [manage them manually](../operations/hosts.md#update) if you need to. When you set the replication source manually, the replicas will [have a number of limitations](replication.md#replication-manual).
* If you have configured public access for the host, you must also enable it for the replicas, otherwise the cluster may become unavailable after a master failover.
* The cluster uses automatic master selection and failover in case the current master fails.

Replication management and automatic failover ensure the highest possible write availability for clusters with any number of hosts.  

In a cluster of three or more hosts:
   * If the master fails, the system automatically switches to a new master.
   * Loss of a replica does not affect cluster availability.

In a two-host cluster:
   * If the master fails, the system automatically fails over to a synchronous replica with zero data loss.
   * If a replica fails, the cluster automatically switches to asynchronous replication mode within 15 seconds. During this period, transactions may pause while awaiting confirmation but resume and complete successfully once the cluster switches to asynchronous mode. While recovering from the failure, the replica fully synchronizes with the master, and the cluster resumes operation in synchronous replication mode.

To minimize the risk of a cluster being unavailable for writes, we recommend deploying {{ mpg-name }} clusters with three or more hosts.

{% note warning %}

Using a [special FQDN](../operations/connect/fqdn.md#special-fqdns) simplifies application development, but your cluster will be unavailabile during master failover. To quickly switch to a new master, you need to implement [monitoring of master replacement](planning-cluster-topology.md#cluster-availability) on the application side.

{% endnote %}

## Maintenance settings {#maintenance-settings}

In some cases, [maintenance](maintenance.md) is impossible without connection loss. Therefore, any application that accesses the database must be resilient to connection drops.

During maintenance, a cluster with two or more hosts may be unavailable for writes while switching masters. The host being restarted becomes unreadable. Single-host clusters are completely unavailable during restarts. We recommend selecting [maintenance day and hour](maintenance.md#maintenance-window) based on estimated cluster load.

[{{ PG }} version upgrades](../operations/cluster-version-update.md) make a cluster unavailable for writes. Replicas become unreadable one by one, i.e., at least one replica remains readable in a three-host cluster, two in a four-host cluster, etc. Single-host and two-host clusters become completely unavailable during {{ PG }} version upgrades. Take this into account when planning to upgrade your cluster version.

## Other settings {#other-settings}

The following settings may also affect cluster availability:

* [Backup settings](backup.md).
* [Storage disk type you selected](storage.md).
* [Host classes](instance-types.md).
* [Connection pooler's operation mode and settings](pooling.md).
* [Quotas and limits](limits.md).
* [Write-ahead log (WAL) settings](replication.md#write-sync-and-read-consistency).
