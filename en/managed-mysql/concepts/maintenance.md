---
title: "Maintenance in {{ mmy-name }}"
description: "Maintenance in {{ mmy-name }} means automatic installation of MySQL updates and fixes for your database hosts (including disabled clusters), changes to the host class and storage size, and other maintenance activities."
---

# Maintenance in {{ mmy-name }}

In {{ mmy-name }}, maintenance means:

* Automatic installation of MySQL updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

## Maintenance window {#maintenance-window}

You can set the preferred maintenance time when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/update.md):

* **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** (default): Maintenance can be performed at any time.
* **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}**: Set the preferred maintenance start time, i.e., the day and time (UTC) you want to perform maintenance at. For example, you can choose a time window when the cluster is least loaded.

## Maintenance procedure {#maintenance-order}

In {{ mmy-name }} single-host clusters, a master host undergoes maintenance. Therefore, it may become unavailable in case it is restarted.

In multi-host clusters, the maintenance is run as follows:

1. [Replicas](replication.md) undergo maintenance one by one. The replicas are queued randomly. A replica becomes unavailable while it is being restarted during maintenance.
1. Master host undergoes maintenance and gets updated. If it is restarted and becomes unavailable, one of the replicas takes its role. If you access a cluster using the [FQDN of the master host](../operations/connect.md#fqdn), the cluster may become unavailable. To make your application continuously available, access the cluster using a [special FQDN](../operations/connect.md#special-fqdns) that always points to the master host.
