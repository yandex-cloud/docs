# Backups

{{ mrd-short-name }} provides automatic and manual database backups.

{{ mrd-short-name }} uses AOF (append-only file) with forced write to disk every second: the [appendfsync everysec](http://download.redis.io/redis-stable/redis.conf) parameter is set.

A backup of all cluster data (an RDB snapshot) is automatically created once a day and stored for 7 days. You can't disable automatic backups or change the retention period.

To restore a cluster from a backup, [follow the instructions](../operations/cluster-backups.md).

## Creating backups {#size}

Backups can be automatic or manual. In both cases, the following scheme is used:

* The first backup and every seventh backup are full backups of all databases.
* Other backups are incremental and store only the data that has changed since the previous backup to save space.

After a backup is created, it's compressed for storage. The exact backup size isn't displayed.

The backup start time is set when [creating](../operations/cluster-create.md) or [updating](../operations/update.md#change-additional-settings) a cluster. By default, the backup process starts at 22:00 UTC (Coordinated Universal Time). The backup will start within half an hour of the specified time.

Backups in {{ mrd-name }} are created based on a consistent snapshot of the process memory image, which is obtained by copying the original {{ RD }} process through a `fork()` system call. Due to the specifics of the `fork()` implementation in Linux, writing data to a {{ mrd-name }} cluster host during a backup increases memory usage, since new, updated data is added to the total memory of the process (the [Copy-on-Write]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Копирование_при_записи){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Copy-on-write){% endif %} mechanism).

{% note alert %}

This may cause the {{ mrd-name }} hosts to run out of memory: they will be restarted with the backup process interrupted. We recommend that you [choose](../operations/update.md#change-additional-settings) a time to start a backup when the cluster is under the least load or increase RAM by [increasing the host class](../operations/update.md#change-resource-preset).

{% endnote %}

Backups are only created on running clusters. If you don't use a {{ mrd-short-name }} cluster around the clock, check the [backup start time settings](../operations/update.md#change-additional-settings).

To learn how to manually create a backup, see [{#T}](../operations/cluster-backups.md).

## Storing backups {#storage}

Storing backups in {{ mrd-name }}:

* Backups are stored in Yandex internal storage as logical dumps and are encrypted using [GPG]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/GnuPG){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/GNU_Privacy_Guard){% endif %}. Each cluster has its own encryption keys.

* All backups (automatic or manual) are stored for 7 days.

* {% include [no-quotes-no-limits](../../_includes/mdb/backups/no-quotes-no-limits.md) %}

* {% include [using-storage](../../_includes/mdb/backups/storage.md) %}

    For more information, see the [Pricing policy for {{ mrd-name }}](../pricing.md#rules-storage).

## Checking backups {#verify}

### Checking backup integrity {#integrity}

Backup integrity is checked on synthetic data using integration tests available in the service.

### Checking backup recovery {#capabilities}

To test the backup feature, [restore a cluster from a backup](../operations/cluster-backups.md) and check the integrity of your data.
