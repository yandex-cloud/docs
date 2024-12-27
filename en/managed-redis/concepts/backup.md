---
title: '{{ RD }} backups'
description: '{{ mrd-short-name }} provides automatic and manual {{ RD }} database backups. A backup of all cluster data (an RDB snapshot) is automatically created every day. You can set the backup start time when creating or updating a {{ RD }} cluster.'
keywords:
  - back up
  - backup
  - backups
  - Valkey backups
  - backup Valkey
  - Valkey
---

# Backups in {{ mrd-name }}

{{ mrd-short-name }} supports automatic and manual database backups.

{{ mrd-short-name }} uses AOF (append-only file) with forced write to disk every second through the [appendfsync everysec](https://github.com/valkey-io/valkey/blob/unstable/valkey.conf) parameter.

A backup of all cluster data (an RDB snapshot) is automatically created every day and stored for seven days. You cannot disable automatic backups or change the retention period.

To restore a cluster from a backup, follow [this guide](../operations/cluster-backups.md).

## Creating backups {#size}

You can create both automatic and manual backups. In both cases, the following method is used:

* The first backup and every seventh backup are full backups of all databases.
* Other backups are incremental and store only the data that has changed since the previous backup to save space.

After a backup is created, it is compressed for storage. The exact backup size is not displayed.

You can set the backup start time when [creating](../operations/cluster-create.md) or [updating](../operations/update.md#change-additional-settings) a cluster. By default, the backup process starts at 10 p.m. UTC. The backup will start within 30 minutes of the specified time.

{% note alert %}

When data is written intensively during backups, the cluster might become unavailable as hosts run out of memory. For more information, see [Memory management](memory-management.md).

To avoid crashes:
* Make sure to [start backups](../operations/update.md#change-additional-settings) when the cluster load is minimum.
* Increase the amount of RAM [by upgrading the host class](../operations/update.md#change-resource-preset).

{% endnote %}

Backups are only created on running clusters. If you are not using your {{ mrd-short-name }} cluster 24/7, check the [settings of backup start time](../operations/update.md#change-additional-settings).

For more information about creating a backup manually, see [Managing backups](../operations/cluster-backups.md).

## Storing backups {#storage}

Storing backups in {{ mrd-name }}:

* Backups are kept in {{ yandex-cloud }} internal storage as logical dumps and encrypted with [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

* All backups (automatic or manual) are stored for seven days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

   For more information, see the [{{ mrd-name }} pricing policy](../pricing.md#rules-storage).

## Checking backup recovery {#capabilities}

To test how backup works, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.
