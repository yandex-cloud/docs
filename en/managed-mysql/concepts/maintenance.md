---
title: Maintenance in {{ mmy-full-name }}
description: In {{ mmy-name }}, maintenance implies automatic installation of DBMS updates and patches for hosts (including for stopped clusters), introducing host class and storage space modifications, and other maintenance operations.
---

# Maintenance in {{ mmy-name }}

Maintenance in {{ mmy-name }} includes:

* Automatic installation of DBMS updates and patches for hosts (including for stopped clusters).
* Other maintenance activities.

Changing a DBMS version is not part of maintenance. For more information about version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the maintenance window when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/update.md):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

## Maintenance workflow {#maintenance-order}

In {{ mmy-name }} single-host clusters, a master host undergoes maintenance. Therefore, it may become unavailable in case it is restarted.

In multi-host clusters, the maintenance is run as follows:

1. [Replicas](replication.md) undergo maintenance one by one. The replicas are queued randomly. If a replica needs to be restarted during maintenance, it will become unavailable.
1. Master host undergoes maintenance and gets updated. If the master host needs restarting and becomes unavailable, one of the replicas will assume its role. If you access a cluster using the [FQDN of the master host](../operations/connect/fqdn.md), the cluster may become unavailable. To make your application continuously available, access the cluster using a [specific FQDN](../operations/connect/fqdn.md#special-fqdns) that always points to the master host.
