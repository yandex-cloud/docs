#### When does a backup run? Is a database cluster available during backups? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. You can configure a backup window when [creating](../../managed-greenplum/operations/cluster-create.md) or [editing](../../managed-greenplum/operations/update.md) a cluster.

Clusters remain fully accessible during backups.

#### Are database host backups enabled by default? {#default-backup}

Yes, backups are on by default. For {{ GP }}, a full backup takes place once a day and saves all transaction logs for a DB cluster. The first and every second automatic backups are full backups of all databases. To save space, other backups are incremental and only store the data that has changed since the previous backup.

Automatically created backups of an existing cluster are kept for seven days, whereas those created manually are stored indefinitely. Once the cluster is deleted, all its backups are kept for seven days.

#### Can I run backup for a {{ GP }} cluster manually? {#manual-backup}

Yes, {{ mgp-name }} supports [manually running](../../managed-greenplum/operations/cluster-backups.md#create-backup) a cluster backup.

#### Can I select other resources when restoring a cluster from a backup? {#resource-restore}

Yes, with the following restrictions:

{% include [limits](../../_includes/mdb/mgp/restore-limits.md) %}
