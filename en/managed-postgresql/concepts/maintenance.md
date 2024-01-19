---
title: "Maintenance in {{ mpg-full-name }}"
description: "Maintenance in {{ mpg-name }} means automatic installation of DBMS updates and fixes for your database hosts (including disabled clusters), changes to the host class and storage size, and other maintenance activities."
---

# Maintenance in {{ mpg-name }}

In {{ mpg-name }}, maintenance means:

* Automatic installation of DBMS updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

Changing a major DBMS version is not part of maintenance. For more information about major version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the preferred maintenance time when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/update.md):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

## Maintenance procedure {#maintenance-order}

In {{ mpg-name }} single-host clusters, a master host undergoes maintenance. Therefore, it may become unavailable in case it is restarted.

In multi-host clusters, the maintenance is run as follows:

1. [Replica hosts](replication.md) undergo maintenance one by one. Their queue positions are random. A replica becomes temporarily unavailable if it needs to be restarted during maintenance.
1. Master host undergoes maintenance and gets updated. If it is restarted and becomes unavailable, one of the replicas takes its role.

   If you access a cluster using the [FQDN](../operations/connect.md#fqdn) of the master host, the cluster may become unavailable. To make your application continuously available, access the cluster using a [special FQDN](../operations/connect.md#fqdn-master) that always points to the master host.
