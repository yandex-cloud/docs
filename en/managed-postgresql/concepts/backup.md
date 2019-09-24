# Backups

{{ mpg-short-name }} provides automatic and manual database backups. Backups take up space in the storage allocated to the cluster. If the total amount of data and backups exceeds the amount of storage, the excess is charged at the corresponding [rates](../pricing.md).

An automatic backup of all cluster data is created once a day. For each subsequent automatic backup, only the difference from the previous one is stored, which saves storage space. You can't disable automatic backups, and you can't change the period for storing automatic backups (seven days) at this time.

The backup process start time is set when a cluster is created or updated. The backup will start within half an hour of the specified time. By default, backups start at 22:00.

The size of each backup that you create manually is always equal to the current size of the databases (no incremental backup is enabled for manual backups).

To restore a cluster from a backup, [follow the instructions](../operations/cluster-backups.md).

