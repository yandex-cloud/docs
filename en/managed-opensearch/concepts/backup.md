# Backups in {{ mos-name }}

{{ mos-short-name }} supports automatic and manual [index](./indexing.md) backups.

## Creating backups {#size}

Backups are only created on running clusters.

Automatic backup takes place every hour, and you cannot turn it off. All automatic backups as well as all [manually created](../operations/cluster-backups.md) backups are incremental and store only the data that has changed since the previous backup to save storage space.

After a backup is created, it is compressed for storage. The exact backup size is not displayed.

For more information about creating a backup manually, see [Managing backups](../operations/cluster-backups.md).

## Storing backups {#storage}

Storing backups in {{ mos-name }}:

* Backups are stored in object storage as binaries.

* Automatic backups are stored for two weeks, and you cannot change that period. Manual backups are stored until the user deletes them.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

   
   For more information, see the [{{ mos-name }} pricing policy](../pricing.md#rules-storage).


## Checking backup recovery {#capabilities}

To test how backup works, you can [restore a cluster from a backup](../operations/cluster-backups.md#restore) and check the integrity of your data.
