- {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}

- **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}**{#setting-backup-saving}
  
  Retention period for automatic backups. If an automatic backup expires, it is deleted. The default is {{ mmg-backup-retention }} days. This feature is at the [Preview stage](../../overview/concepts/launch-stages.md). For more information, see [Backups](../../managed-mongodb/concepts/backup.md).


  Changing the retention period affects both new automatic backups and existing backups. For example, if the initial retention period was 7 days, and the remaining lifetime of a separate automatic backup is 1 day, increasing the retention period to 9 days will change the remaining lifetime of this backup to 3 days.

  For an existing cluster, automatic backups are stored for a specified number of days whereas manually created ones are stored indefinitely. After a cluster is deleted, all backups persist for {{ mmg-backup-retention }} days.

- **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance window](../../managed-mongodb/concepts/maintenance.md) settings:

    {% include [Maintenance window](console/maintenance-window-description.md) %}


- **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}**: Enable this option to use the built-in [performance diagnostics](../../managed-mongodb/operations/performance-diagnostics.md) tool in the cluster. This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage.

- {% include [Deletion protection](console/deletion-protection.md) %}

    {% include [deletion-protection-limits-db](deletion-protection-limits-db.md) %}

