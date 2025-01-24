---
title: Maintenance in {{ mos-full-name }}
description: In {{ mos-name }}, maintenance means automatic installation of DBMS updates and fixes for hosts (including for disabled clusters), changing host class and storage size, and other maintenance activities.
---

# Maintenance in {{ mos-name }}

Maintenance means:

* Automatic installation of {{ OS }} updates and revisions for host groups (including disabled clusters).
* Scheduled automatic increase of storage size.
* Other maintenance activities.

Changing a major DBMS version is not part of maintenance. For more information about migrating between major versions, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the preferred maintenance time when [creating a cluster](../operations/cluster-create.md) or [updating its settings](../operations/update.md):

{% include [Maintenance window](../../_includes/mdb/maintenance-window.md) %}

## Maintenance procedure {#maintenance-order}

In {{ mos-name }} single-host clusters, a single host undergoes maintenance. This means, if a cluster needs to be restarted during maintenance, it will become unavailable.

In multi-host clusters, hosts undergo maintenance one by one. The hosts are queued randomly. If a host needs to be restarted during maintenance, it becomes unavailable while being restarted. If you access a cluster using the [FQDN of the {{ OS }} host](../operations/connect.md#fqdn), the cluster may become unavailable. To make your application continuously available, access the cluster using a [special FQDN](../operations/connect.md#special-fqdns) always pointing to the available host.
