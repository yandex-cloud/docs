#### How are {{ CH }} databases backed up? {#backup-overview}

Backups are created every 24 hours and retained for seven days. You can only restore data as of the backup creation time.

#### Are database host backups enabled by default? {#default-backup}

Yes, backups are enabled by default. For {{ CH }}, a full backup is performed once a day with the possibility to restore it to any saved backup.

#### When does a backup run? Is a database cluster available during backups? {#backup-window}

When [creating](../../managed-clickhouse/operations/cluster-create.md) or [updating](../../managed-clickhouse/operations/update.md#change-additional-settings) a cluster, you can set the backup start window. The default value is `22:00 - 23:00` UTC (Coordinated Universal Time).

Clusters remain fully available during the backup window.

#### How many backups does {{ mch-name }} store? For how long? {#how-many-backups}

The size and number of backups are not limited. Automatically created backups are retained for seven days, while manually created ones, indefinitely.

#### Can I delete a backup? {#delete-backup}

Yes, if you created it manually. To delete a backup, [follow this guide](../../managed-clickhouse/operations/cluster-backups.md#delete-backup).

#### Can I change the automatic backup retention period? {#backup-retain-days}

You can set the retention period for automatic backups when [creating](../../managed-clickhouse/operations/cluster-create.md) or [updating](../../managed-clickhouse/operations/update.md#change-additional-settings) a cluster.

#### What does a daily backup include? {#daily-backups}

Backups contain data solely for the `MergeTree` engine family. For other engines, backups only contain table schemas. For more information, see [Backups](../../managed-clickhouse/concepts/backup.md).

#### Why does it take a long time to restore a cluster from a backup? {#long-restore}

The approximate average speed of restoring a cluster from a backup is 100 Mbps. The recovery time may vary significantly depending on the host class and nature of the database data.

#### How do I move an existing {{ CH }} cluster to {{ yandex-cloud }}? {#migration}

Use [{{ data-transfer-full-name }}](../../data-transfer/quickstart.md).

#### Can I restore a shard from a backup into a shard in an existing cluster? {#shard-to-shard}

This option is not currently supported.

However, you can [restore your shard](../../managed-clickhouse/operations/cluster-backups.md#restore) from a backup to a new {{ CH }} cluster and transfer data from that cluster into an existing one. To do this, explore the options below:

* [{{ data-transfer-name }}](../../managed-clickhouse/tutorials/ch-to-mch-migration.md) enables you to transfer a database or individual tables to a {{ mch-name }} cluster.
* [{{ CH }} built-in `remote` function](../../managed-clickhouse/tutorials/data-migration.md#transfer-remote) allows you to transfer individual tables to a {{ mch-name }} cluster.
* [{{ CH }} `BACKUP` and `RESTORE` commands](../../managed-clickhouse/tutorials/data-migration.md#backup-objstorage) help you back up a database or individual table to a [{{ objstorage-full-name}}](../../storage) bucket and then restore your data from the bucket to a {{ mch-name }} cluster.
