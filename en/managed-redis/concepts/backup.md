# Backups

{{ mrd-short-name }} provides automatic and manual database backups. Backups take up space in the storage allocated to the cluster. If the total amount of data and backups exceeds the amount of storage, the excess is charged at the corresponding [rates](../pricing.md).

# Backup settings {{ mrd-short-name }}

{{ mrd-short-name }} uses AOF (append-only file) with forced write to disk every second: the [appendfsync everysec](http://download.redis.io/redis-stable/redis.conf) parameter is set.

An automatic backup of all cluster data (an RDB snapshot) is created once a day. You can't disable automatic backups, and you can't change the period for storing automatic backups (seven days) at this time.

The backup process start time is set when a cluster is created or updated. The backup will start within half an hour of the specified time. By default, backups start at 22:00.

The size of each backup that you create manually is always equal to the current size of the databases (no incremental backup is enabled for manual backups).

