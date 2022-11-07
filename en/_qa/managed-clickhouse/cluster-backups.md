# Moving and restoring a cluster

#### How do I back up a {{ CH }} database? {#backup-overview}

Backups are created every 24 hours and stored for seven days after being created. You can restore data only as of backup creation time.

#### Is DB host backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ CH }}, a full backup is performed once a day with the possibility to restore it to any saved backup.

#### When are backups performed? Is a DB cluster available during backup? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. The backup window is from 01:00 to 05:00 (UTC+3).

Clusters remain fully accessible during the backup window.

#### How many backups are stored in {{ mch-name }}? For how long? {#how-many-backups}

The size and amount of backups are not limited. All backups (automatic and manual) are stored for seven days.

#### What does a daily backup include? {#daily-backups}

Backup data is stored only for the `MergeTree` engine family. For other engines, backups only store table schemas. For more information, see [{#T}](../../managed-clickhouse/concepts/backup.md).

#### Why does it take a long time to restore a cluster from a backup? {#long-restore}

The average speed when recovering a cluster from a backup is about 100 Mbps. Cluster recovery time may vary significantly depending on the host class and the nature of data being stored in the DB.

#### How do I move an existing {{ CH }} cluster to {{ yandex-cloud }}? {#migration}

Use [{{ data-transfer-full-name }}](../../data-transfer/quickstart.md).
