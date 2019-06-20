# Backups

{{ mmg-short-name }} provides automatic and manual database backups. Backups take up space in the storage allocated to the cluster. If the total amount of data and backups exceeds the amount of storage, the excess is charged at the corresponding [rates](../pricing.md).

An automatic backup of all cluster data is created once a day. For each subsequent automatic backup, only the difference from the previous one is stored, which saves storage space. You can't disable automatic backups, but you can change the period for storing automatic backups (by default, it is seven days).

The size of each backup that you create manually is always equal to the current size of the databases (no incremental backup is enabled for manual backups).

To restore a cluster from a backup, [follow the instructions](../operations/cluster-backups.md).

