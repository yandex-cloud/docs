# Backups in {{ mgp-name }}

#### When are backups performed? Is a DB cluster available during backup? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. You can configure a backup window when [creating](../../managed-greenplum/operations/cluster-create.md) or [editing](../../managed-greenplum/operations/update.md) a cluster.

Clusters remain fully accessible during backups.

#### Is DB host backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ GP }}, a full backup is performed once a day, saving all the database cluster transaction logs. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

Automatically created backups of an existing cluster are kept for seven days, whereas those created manually are stored indefinitely. After you delete a cluster, all its backups are kept for seven days.

#### Can I run {{ mgp-name }} cluster backups manually? {#manual-backup}

No, {{ mgp-name }} does not support manual cluster backups.

#### Can I select other resources when restoring a cluster from a backup? {#resource-restore}

Yes, with the following restrictions:

{% include [limits](../../_includes/mdb/mgp/restore-limits.md) %}
