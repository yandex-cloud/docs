#### When are backups performed? Is a DB cluster available during backup? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. You can configure a backup window when [creating](../../managed-greenplum/operations/cluster-create.md) or [editing](../../managed-greenplum/operations/update.md) a cluster.

Clusters remain fully accessible during backups.

#### Is DB host backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ GP }}, a full backup is performed every day, saving all DB cluster transaction logs. The first and every second automatic backups are full backups of all databases. Other backups are incremental and store only the data that has changed since the previous backup to save space.

Automatically created backups of an existing cluster are kept for seven days, whereas those created manually are stored indefinitely. Once the cluster is deleted, all its backups are kept for seven days.

#### Can I run {{ mgp-name }} cluster backups manually? {#manual-backup}

Yes, {{ mgp-name }} supports [manually running](../../managed-greenplum/operations/cluster-backups.md#create-backup) a cluster backup.

#### Can I select other resources when restoring a cluster from a backup? {#resource-restore}

Yes, with the following restrictions:

{% include [limits](../../_includes/mdb/mgp/restore-limits.md) %}
