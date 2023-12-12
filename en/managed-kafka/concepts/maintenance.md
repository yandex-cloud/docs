---
title: "Maintenance in {{ mkf-full-name }}"
description: "Maintenance in {{ mkf-name }} means automatic installation of ClickHouse updates and fixes for your database hosts (including disabled clusters), changes to the host class and storage size, and other maintenance activities."
---

# Maintenance in {{ mkf-name }}

Maintenance means:

* Automatic installation of {{ KF }} updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

Maintenance includes changes within one {{ KF }} major version. For more information about major version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the preferred maintenance time when [creating a cluster](../operations/cluster-create.md) or updating [its settings](../operations/cluster-update.md):

* **Unspecified time** (default): Maintenance can be performed at any time.
* **On schedule**: Set the preferred maintenance start time, i.e., the day and time (UTC) you want to perform maintenance at. For example, you can choose a time window when the cluster is least loaded.

## Maintenance procedure {#maintenance-order}

In single-host {{ mkf-name }} clusters, a single [broker host](brokers.md) undergoes maintenance. This means, if a cluster needs to be restarted during maintenance, it will become unavailable.

In multi-host clusters, broker hosts undergo maintenance one by one. The hosts are queued randomly. A broker host becomes unavailable while it is being restarted during maintenance.
