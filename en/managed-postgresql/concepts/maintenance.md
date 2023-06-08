---
title: "Maintenance in {{ mpg-name }}"
description: "Maintenance in {{ mpg-name }} means automatic installation of DBMS updates and fixes for your database hosts (including disabled clusters), changes to the host class and storage size, and other maintenance activities."
---

# Maintenance in {{ mpg-name }}

In {{ mpg-name }}, maintenance means:

* Automatic installation of DBMS updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

Changing a major DBMS version is not part of maintenance. For more information about major version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the preferred maintenance time when [creating a cluster](../operations/cluster-create.md) or updating [its settings](../operations/update.md):

* **Unspecified time** (default): Maintenance is possible at any time.
* **On schedule**: Set the preferred maintenance start time, i.e., the day and time (UTC) you want to perform maintenance at. For example, you can choose a time when the cluster is least loaded.

## Maintenance procedure {#maintenance-order}

In {{ mpg-name }} single-host clusters, a master host undergoes maintenance. Therefore, it may become unavailable in case it is restarted.

In multi-host clusters, the maintenance is run as follows:

1. [Replica hosts](replication.md) undergo maintenance one by one. The replicas are queued randomly. A replica becomes unavailable while it is being restarted during maintenance.
1. Master host undergoes maintenance and gets updated. If it is restarted and becomes unavailable, one of the replicas takes its role.

   If you access the cluster using the FQDN or IP address of the master host, such a cluster may become unavailable. To make your application continuously available, access the cluster using a [special FQDN](../operations/connect.md#fqdn-master) that always points to the master host.
