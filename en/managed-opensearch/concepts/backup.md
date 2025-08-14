# Backups in {{ mos-name }}

{{ mos-short-name }} supports automatic and manual [index](./indexing.md) backups.

## Creating backup {#size}

Backups are only created on running clusters.

Automatic backup takes place every hour, and you cannot turn it off.

For more information about creating a backup manually, see [Managing backups](../operations/cluster-backups.md).

## Storing backups {#storage}

Storing backups in {{ mos-name }}:

* All automatic and [manual](../operations/cluster-backups.md) backups are incremental. This means the initial backup contains all index segments, and all subsequent backups contain only the _increment_, i.e., changes made since the previous backup. This saves storage space and reduces the cost of using resources.

* When [requesting information about a backup](../operations/cluster-backups.md#get-backup), you will get the full size of restorable data, but you only pay for the incremental part.

* Backups are stored in object storage as binaries.

* After a backup is created, it is compressed for storage.

* Automatic backups are stored for two weeks, and you cannot change that period. Manual backups are stored until the user deletes them.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

    
    For more information, see the [{{ mos-name }} pricing policy](../pricing.md#rules-storage).


## Checking backup recovery {#capabilities}

To test how backup works, you can [restore a cluster from a backup](../operations/cluster-backups.md#restore) and check the integrity of your data.
