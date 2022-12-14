---
title: "MongoDB backups"
description: "{{ mmg-short-name }} provides automatic and manual MongoDB database backups. Backups take up space in the storage allocated to the cluster. You can recover the cluster data from a given point in time (Point-in-Time-Recovery, PITR)."
keywords:
  - backup MongoDB
  - MongoDB backup
  - backups
  - backup
  - MongoDB
---

# Backups in {{ mmg-name }}

{{ mmg-short-name }} provides automatic and manual database backups.

{{ mmg-name }} lets you restore the state of a cluster to _any point in time_ (Point-in-Time-Recovery, PITR) between the time you create the oldest backup to the moment when you archive the most recent oplog collection. For this purpose, the backup selected as the starting point of recovery is updated with entries from the cluster oplog.

When creating backups and restoring data from them to a given point in time, keep in mind the following:

* The oplog is archived in a running cluster several times a minute and then uploaded to object storage.

* It takes some time to create and upload an oplog archive to object storage. This is why the cluster state stored in object storage may differ from the actual one.

To use PITR, the cluster must meet the following criteria:

* {{ MG }} version in the cluster: 4.2 or higher.
* [Sharding](../tutorials/sharding.md) is disabled. PITR works only for a cluster with a single replica set.

To restore a cluster from a backup, [follow the instructions](../operations/cluster-backups.md#restore).

## Creating backups {#size}

You can create backups both automatically and manually making a full backup of all the databases in both cases.

All cluster data is backed up once a day. You can't disable an automatic backup. However, when [creating](../operations/cluster-create.md) or [editing](../operations/update.md#change-additional-settings) a cluster, you can set the following parameters for automatic backups:

* [Retention time](#storage).
* Backup start time. By default, the backup process starts at 22:00 UTC (Coordinated Universal Time). The backup will start within half an hour of the specified time.

After a backup is created, it's compressed for storage. To find out its exact size, request a [list of backups](../operations/cluster-backups.md#list-backups).

Backups are only created on running clusters. If you don't use a {{ mmg-short-name }} cluster around the clock, check the [backup start time settings](../operations/update.md#change-additional-settings).

For more information about creating a backup manually, see [{#T}](../operations/cluster-backups.md).

## Storing backups {#storage}

Storing backups in {{ mmg-name }}:

* Backups are kept in Yandex internal storage as logical dumps and encrypted with [GPG]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/GnuPG){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/GNU_Privacy_Guard){% endif %}. Each cluster has its own encryption keys.

* The retention time for backups of an existing cluster depends on the method used to create such backups:

   * Automatic backups are stored for {{ mmg-backup-retention }} days by default. When [creating](../operations/cluster-create.md) a cluster or [editing](../operations/update.md#change-additional-settings) its settings, you can specify a different retention period of between {{ mmg-backup-retention-min }} and {{ mmg-backup-retention-max }} days.

   * Manually created backups are kept indefinitely.

* Once you delete a cluster, all its backups persist for 7 days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}
* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

   {% if audience != "internal" %}For more information, see the [Pricing policy for {{ mmg-name }}](../pricing.md#rules-storage).{% endif %}

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service.

### Checking backup recovery {#capabilities}

To test the backup feature, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.
