---
title: High availability of a {{ mpg-full-name }} cluster
description: High availability is the ability of a system to continue to operate when one or more of its components fail. High availability of a {{ mpg-name }} cluster depends on the number and placement of its hosts, replication settings, and other cluster parameters.
---

# High availability of a {{ mpg-name }} cluster

[High availability of a {{ mpg-name }} cluster](../../architecture/fault-tolerance.md#mdb-ha) depends on the number and placement of its hosts, replication settings, and other cluster parameters.

## Number and placement of cluster hosts {#host-configuration}

A single-host cluster does not provide high availability. If the master host VM fails, your cluster will be unavailable for reading and writing until the VM recovers completely. Single-host clusters are not covered by the [Service level agreement (SLA)](https://yandex.ru/legal/cloud_sla_mdb/).

A cluster with two hosts located in different availability zones is considered highly available and is subject to the [SLA](https://yandex.ru/legal/cloud_sla_mdb/). This option is sutable for medium-sized applications in a production environment.

A cluster with three or more hosts located in three different availability zones is considered highly available and is subject to the [SLA](https://yandex.ru/legal/cloud_sla_mdb/). Such clusters are suitable for production environments with high availability and performance requirements.

For more information, see [Planning cluster topology](planning-cluster-topology.md).

## Replication and master failover settings {#replication-settings}

High availability is achived through [replication and master failover](replication.md), which work as follows:

* Clusters uses streaming replication. Each replica host receives a replication stream from another host, typically the master. {{ mpg-name }} manages replication streams in the cluster [automatically](replication.md#replication-auto), but you can [manage them manually](../operations/hosts.md#update) if you need to. When you set the replication source manually, the replicas will [have a number of limitations](replication.md#replication-manual).
* By default, clusters provide automatic failover of master hosts. You can disable auto failover, but if the master fails, you will need to select a new master and [perform the failover](../operations/update.md#start-manual-failover) manually.
* If you use public access for the host, you must also enable it for the replicas, otherwise the cluster will become unavailable after master failover.

{% note warning %}

Using a [special FQDN](../operations/connect.md#special-fqdns) simplifies application development, but your cluster will be unavailabile during master failover. To quickly switch to a new master, you need to implement [monitoring of master replacement](planning-cluster-topology.md#cluster-availability) on the application side.

{% endnote %}

## Maintenance settings {#maintenance-settings}

During [maintenance](maintenance.md), a cluster with two or more hosts may not be available for writes until the master automatically fails over. A single host cluster is completely unavailable during maintenance. Therefore, consider the expected load on your cluster when selecting the [maintenance day and hour](maintenance.md#maintenance-window).

When updating a [{{ PG }} version](../operations/cluster-version-update.md), a cluster with three or more hosts is unavailable for writes but has at least one readable replica. A cluster with one or two hosts is completely unavailable during {{ PG }} version updates. Consider the expected load on your cluster when planning updates.

## Other settings {#other-settings}

The following settings may also affect cluster availability:

* [Backup settings](backup.md).
* [Storage disk type you selected](storage.md).
* [Host classes](instance-types.md).
* [Connection pooler's operation mode and settings](pooling.md).
* [Quotas and limits](limits.md).
* [Write-ahead log (WAL) settings](replication.md#write-sync-and-read-consistency).
