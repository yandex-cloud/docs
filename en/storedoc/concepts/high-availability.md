---
title: High availability of a {{ mmg-full-name }} cluster
description: High availability is the ability of a system to continue to operate when one or more of its components fail. High availability of a {{ mmg-name }} cluster depends on the number and placement of its hosts, replication settings, and other cluster parameters.
---

# High availability of a {{ mmg-name }} cluster

The [high availability of a {{ mmg-name }} cluster](../../architecture/fault-tolerance.md#mdb-ha) depends on the [SLA](https://yandex.com/legal/cloud_sla_mdb/en/)-related parameters and some other settings.

## Number and placement of cluster hosts {#host-configuration}

### For a non-sharded cluster

A single-host cluster does not provide high availability. If the primary replica fails, your cluster becomes unavailable for reading and writing until the replica is recovered.

If your cluster has at least two hosts, it remains available if one of them fails.


A cluster with two or more hosts located in different availability zones remains available for reading if one zone fails. To keep the cluster available for writing, each availability zone must contain no more than half of all the cluster's hosts.


Hidden hosts do not affect cluster availability and are not included in the calculations.

### For a cluster with standard sharding


A cluster remains tolerant to a single zone failure under the following conditions:
* The cluster has at least two `MONGOINFRA` hosts.
* No availability zone contains more than half of all `MONGOINFRA` hosts.
* Each shard has at least two `MONGOD` hosts.
* No availability zone contains more than half of `MONGOD` hosts that belong to a single shard.


Hidden hosts do not affect cluster availability and are not included in the calculations.

### For a cluster with advanced sharding


A cluster remains tolerant to a single zone failure under the following conditions:
* The cluster has at least two `MONGOS` hosts and two `MONGOCFG` hosts.
* No availability zone contains more than half of all `MONGOS` or `MONGOCFG` hosts.
* Each shard has at least two `MONGOD` hosts.
* No availability zone contains more than half of `MONGOD` hosts that belong to a single shard.


Hidden hosts do not affect cluster availability and are not included in the calculations.

## Backups {#backup}

If a cluster goes down, you can restore it from a [backup](../concepts/backup.md).

To ensure data integrity and acceptable cluster recovery time:
* Make sure the cluster is running and automatic backups are under way at the [scheduled backup start time](../operations/update.md#change-additional-settings).
* Set the [backup retention period](../concepts/backup.md#storage) as needed.
* Perform manual backups before making important changes. Manual backups are stored with no time limit.
* Regularly test cluster recovery from backups.

## Connecting to {{ mmg-name }} {#connect}

{{ mmg-name }} cluster availability depends on the connection method and settings:
* Only use [recommended clients](../concepts/supported-clients.md) for connection.
* Enable [public access](../concepts/network.md#Public-access-to-host) and [configure security groups](../concepts/network.md#security-groups) for each cluster host.

  {% note warning %}

  If public access is not configured for all cluster hosts, [automatic primary replica failover](../concepts/replication.md) may render the cluster unavailable from the internet.

  {% endnote %}

## Available storage space {#storage-settings}

{{ mmg-name }} monitors how much disk space is used and automatically activates **Read only** mode for those cluster hosts that have:
* Less than 500 MB of free disk space left (if the host storage size is less than 600 GB).
* Less than 5 GB of free disk space left (if the host storage size is 600 GB or more).

To keep your cluster's hosts writable, regularly [check its _Disk space usage per host_ chart](../operations/monitoring.md#cluster) or [create an alert with the `disk.free_bytes` metric](../operations/monitoring.md#monitoring-integration).

## Virtual machine type {#vm-type}

Cluster availability depends on the type of VMs you use to deploy your hosts. A highly available cluster should use a VM type with a 100% vCPU guarantee. The **burstable** VM type with a 50% vCPU guarantee does not ensure high availability and should only be used for test environments.

## Maintaining a cluster and modifying its parameters {#maintenance}

The following operations may lead to interrupted database connections and temporary performance degradation:
* [Maintenance](../concepts/maintenance.md) start (you set the start time when you select the [maintenance window](../concepts/maintenance.md#maintenance-window)).
* [Host class change](../operations/update.md#change-resource-preset).
* Automatic and manual database [backups](../concepts/backup.md).

Run these operations when the cluster load is minimal.

{% note warning %}

These operations may trigger a primary replica switch. If the cluster has no hosts that can become the new primary replica, it is rendered temporarily unavailable.

{% endnote %}
