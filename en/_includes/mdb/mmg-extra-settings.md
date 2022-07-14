- **Backup start (UTC)**{#setting-backup-start}

   The time in UTC (in 24-hour format) to start [backing up](../../managed-mongodb/operations/cluster-backups.md) the cluster. If the time is not set, the backup will start at 22:00 UTC.

- **Retention period for automatic backups, days**{#setting-backup-saving}
   {% if audience != "internal" %}

   The time to retain the automatically created backups. If an automatic backup expires, it is deleted. The default is {{ mmg-backup-retention }} days. This feature is in the [Preview stage](../../overview/concepts/launch-stages.md). For more information, see [{#T}](../../managed-mongodb/concepts/backup.md).

   {% else %}

   The time to retain the automatically created backups. If an automatic backup expires, it is deleted. The default is {{ mmg-backup-retention }} days. This feature is in the Preview stage. For more information, see [{#T}](../../managed-mongodb/concepts/backup.md).

   {% endif %}

   Changing the retention period affects both new automatic backups and existing backups. For example, if the original retention period was 7 days and the remaining lifetime of a separate automatic backup is 1 day, then when the retention period increases to 9 days, the remaining lifetime of this backup becomes 3 days.

   For an existing cluster, automatic backups are stored for a specified number of days whereas manually created ones are stored indefinitely. After a cluster is deleted, all backups persist for {{ mmg-backup-retention }} days.

- {% include [Maintenance window](console/maintenance-window.md) %}

- {% include [datatransfer access](console/datatransfer-access.md) %}

- **Statistics sampling**: Enable this option to use the [{#T}](../../managed-mongodb/operations/performance-diagnostics.md) tool in the cluster. {% if audience != "internal" %}This feature is in the [Preview](../../overview/concepts/launch-stages.md) stage. {% else %}This feature is in the Preview stage.{% endif %}

- {% include [Deletion protection](console/deletion-protection.md) %}

   {% include [deletion-protection-limits-db](deletion-protection-limits-db.md) %}
