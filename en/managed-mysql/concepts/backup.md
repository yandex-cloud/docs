# Backups

{{ mmy-short-name }} provides automatic and manual database backups. Backups take up space in the storage allocated to the cluster. If the total amount of data and backups exceeds the amount of storage, the excess is charged at the corresponding [rates](../pricing.md).

Automatic [physical backups](https://dev.mysql.com/doc/refman/5.7/en/backup-types.html) of all data in a cluster are created once a day. You can't disable automatic backups, and you can't change the period for storing automatic backups (seven days) at this time.

The backup process start time is set when a cluster is created or updated. The backup will start within half an hour of the specified time. By default, backups start at 22:00.

To restore a cluster from a backup, [follow the instructions](../operations/cluster-backups.md).

