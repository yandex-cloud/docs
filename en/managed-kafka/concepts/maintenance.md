---
title: Maintenance in {{ mkf-full-name }}
description: In {{ mkf-name }}, maintenance means automatic installation of DBMS updates and fixes for hosts (including disabled clusters), changing host class and storage size, and other maintenance activities.
---

# Maintenance in {{ mkf-name }}

Maintenance means:

* Automatic installation of {{ KF }} updates and revisions for hosts (including disabled clusters).
* Scheduled [automatic increase](./storage.md#auto-rescale) of storage size.
* Other maintenance activities.

Maintenance includes changes within one {{ KF }} major version. For information about migrating between major versions, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the preferred maintenance time when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/cluster-update.md):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

## Maintenance procedure {#maintenance-order}

In single-host {{ mkf-name }} clusters, a single [broker host](brokers.md) undergoes maintenance. This means, if a cluster needs to be restarted during maintenance, it will become unavailable.

In multi-host clusters, broker hosts undergo maintenance one by one. The hosts are queued randomly. A broker host becomes unavailable while it is being restarted during maintenance.
