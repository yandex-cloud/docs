---
title: High availability of a {{ mgp-name }} cluster
description: The availability of a {{ mgp-name }} cluster depends on its configuration, client connection settings, available storage, and other parameters.
---

# High availability of a {{ mgp-name }} cluster

High availability of a {{ mgp-name }} cluster depends on the client connection settings, available storage, and other parameters.

## Connecting to a database {#connect}

{{ mgp-name }} cluster availability depends on the client you use and database connection settings. To ensure cluster availability:
* [Configure security groups](../operations/connect/index.md#configuring-security-groups) correctly.
* When connecting, specify both the primary and standby master hosts or use the [special primary master FQDN](../operations/connect/fqdn.md#fqdn-master).

  {% note warning %}

  Using a special primary master FQDN makes the cluster temporarily unavailable during a failover to the standby master.  

  {% endnote %}

* Create a separate [resource group](../concepts/resource-groups.md) for cluster administration to be able to connect to and administer the cluster even when resource limits in other groups are exhausted.
* Only use [recommended clients](../operations/connect/clients.md) for connection.

## Available storage space {#storage}

If the database storage is 95% full, the cluster will switch to read-only mode. To keep your cluster writable, regularly [check its _Disk usage_ chart](../operations/monitoring.md#monitoring-hosts) or [create an alert](../concepts/storage.md#read-only-monitor).

## Restoring a cluster from a backup {#backup}

If a cluster goes down, e.g., if the cluster’s availability zone fails, you can restore it from a [backup](../concepts/backup.md).

To ensure data integrity and minimize cluster recovery time:
* Make sure automatic backups are created.
* Perform manual backups before making important changes. Manual backups are full copies of all databases, stored indefinitely.
* Conduct scheduled tests of cluster recovery from backups.

## Maintaining a cluster and modifying its parameters {#maintenance}

Running [unscheduled maintenance operations](../concepts/maintenance.md#irregular-ops) may reduce cluster performance or make your cluster unavailable for some time. Set the [maintenance start time](../concepts/maintenance.md#maintenance-window) to a day and hour when your cluster has no active workload.

Actions such as [changing the host class, disk type, or increasing the storage size](../operations/cluster-config.md) interrupt sessions and make the cluster unavailable for some time. Perform these operations when your cluster has no active workload.

{% note info %}

Automatic and manual [backups](../concepts/backup.md) may reduce cluster performance.

{% endnote %}
