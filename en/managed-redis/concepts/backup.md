---
title: "{{ RD }} backups"
description: "{{ mrd-short-name }} provides automatic and manual {{ RD }} database backups. A backup of all cluster data (an RDB snapshot) is automatically created once a day. The backup process start time is set when a {{ RD }} cluster is created or updated."
keywords:
  - backup
  - backups
  - Redis backups
  - backup Redis
  - Redis
---

# Backups in {{ mrd-name }}

{{ mrd-short-name }} provides automatic and manual database backups.

{{ mrd-short-name }} uses AOF (append-only file) with forced write to disk every second: the [appendfsync everysec](http://download.redis.io/redis-stable/redis.conf) parameter is set.

A backup of all cluster data (an RDB snapshot) is automatically created once a day and stored for 7 days. You can't disable automatic backups or change the retention period.

To restore a cluster from a backup, [follow the instructions](../operations/cluster-backups.md).

## Creating backups {#size}

Backups can be automatic or manual. In both cases, the following scheme is used:

* The first backup and every seventh backup are full backups of all databases.
* Other backups are incremental and store only the data that has changed since the previous backup to save space.

After a backup is created, it's compressed for storage. The exact backup size isn't displayed.

The backup process start time is set when a cluster is [created](../operations/cluster-create.md) or [updated](../operations/update.md#change-additional-settings). By default, the backup process starts at 22:00 UTC (Coordinated Universal Time). The backup will start within half an hour of the specified time.

{% note alert %}

When data is written intensively during backups, the cluster might become unavailable as hosts run out of memory. For more information, see [{#T}](memory-management.md).

To avoid crashes:
* [Make sure](../operations/update.md#change-additional-settings) to start backups when the cluster load is minimum.
* Increase the amount of RAM [by upgrading the host class](../operations/update.md#change-resource-preset).

{% endnote %}

Backups are only created on running clusters. If you don't use a {{ mrd-short-name }} cluster around the clock, check the [backup start time settings](../operations/update.md#change-additional-settings).

For more information about creating a backup manually, see [{#T}](../operations/cluster-backups.md).

## Storing backups {#storage}

Storing backups in {{ mrd-name }}:

* Backups are kept in {{ yandex-cloud }} internal storage as logical dumps and encrypted with [GPG](https://en.wikipedia.org/wiki/GNU_Privacy_Guard). Each cluster has its own encryption keys.

* All backups (automatic or manual) are stored for 7 days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

   For more information, see the [Pricing policy for {{ mrd-name }}](../pricing.md#rules-storage).

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service.

### Checking backup recovery {#capabilities}

To test the backup feature, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.
