- **{{ ui-key.yacloud.mdb.forms.backup-window-start }}**{#setting-backup-start}

   The time in UTC (in 24-hour format) to start [backing up](../../managed-mongodb/operations/cluster-backups.md) the cluster. If the time is not set, the backup will start at 22:00 UTC.

- **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}**{#setting-backup-saving}
   
   The time to retain the automatically created backups. If an automatic backup expires, it is deleted. The default is {{ mmg-backup-retention }} days. This feature is at the [Preview stage](../../overview/concepts/launch-stages.md). For more information, see [{#T}](../../managed-mongodb/concepts/backup.md).


   Changing the retention period affects both new automatic backups and existing backups. For example, if the original retention period was 7 days and the remaining lifetime of a separate automatic backup is 1 day, then when the retention period increases to 9 days, the remaining lifetime of this backup becomes 3 days.

   For an existing cluster, automatic backups are stored for a specified number of days whereas manually created ones are stored indefinitely. After a cluster is deleted, all backups persist for {{ mmg-backup-retention }} days.

- **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance window](../../managed-mongodb/concepts/maintenance.md) settings:

  {% include [Maintenance window](console/maintenance-window-description.md) %}

- {% include [datatransfer access](console/datatransfer-access.md) %}

- **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}**: Enable this option to use the [{#T}](../../managed-mongodb/operations/performance-diagnostics.md) tool in the cluster. This feature is in the [Preview](../../overview/concepts/launch-stages.md) stage. 

- {% include [Deletion protection](console/deletion-protection.md) %}

   {% include [deletion-protection-limits-db](deletion-protection-limits-db.md) %}
