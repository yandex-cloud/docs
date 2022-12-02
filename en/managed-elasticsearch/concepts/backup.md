# Backups in {{ mes-name }}

{{ mes-short-name }} supports automatic and manual [index](./indexing.md) backups.

A backup is automatically created every hour and stored for 7 days. You can't disable automatic backups or change the retention period.

To restore a cluster from a backup, [follow the instructions](../operations/cluster-backups.md#restore).

## Creating backups {#size}

You can create backups both automatically and [manually](../operations/cluster-backups.md#create-backup). After a backup is created, it's compressed for storage. The exact backup size isn't displayed.

Backups are only created on running clusters.

For more information about creating a backup manually, see [{#T}](../operations/cluster-backups.md).

## Storing backups {#storage}

Storing backups in {{ mes-name }}:

* Backups are stored in object storage as binaries.

* All backups (automatic or manual) are stored for 7 days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

   {% if audience != "internal" %}For more information, see the [Pricing policy for {{ mes-name }}](../pricing.md#rules-storage).{% endif %}

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service.

### Checking backup recovery {#capabilities}

To test the backup feature, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.
