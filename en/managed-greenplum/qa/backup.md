# Backups in {{ mgp-name }}

#### When are backups performed? Is a DB cluster available during backup? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. You can configure a backup window when [creating](../operations/cluster-create.md) or [editing](../operations/update.md) a cluster.

Clusters remain fully accessible during backups.

#### Is DB host backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ GP }}, a full backup is performed once a day, saving all the database cluster transaction logs. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

Automatically created backups of an existing cluster are kept for 7 days whereas those created manually are stored indefinitely. Once you delete a cluster, all its backups persist for 7 days.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
