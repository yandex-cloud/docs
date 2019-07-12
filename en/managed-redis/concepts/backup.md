# Backups

Managed Service for Redis provides automatic and manual database backups. Backups take up space in the storage allocated to the cluster. If the total amount of data and backups exceeds the amount of storage, the excess is charged at the corresponding [rates](../pricing.md).

# Backup settings Managed Service for Redis

Managed Service for Redis uses AOF (append-only file) with forced write to disk every second: the [appendfsync everysec](http://download.redis.io/redis-stable/redis.conf) parameter is set.

An automatic backup of all cluster data (an RDB snapshot) is created once a day. You can't disable automatic backups, but you can change the period for storing automatic backups (by default, seven days) by sending a request to technical support.

The size of each backup that you create manually is always equal to the current size of the databases (no incremental backup is enabled for manual backups).

