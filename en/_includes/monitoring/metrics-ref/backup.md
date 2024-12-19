The name of the metric is written to the `name` label.

Common labels for all {{ backup-name }} metrics:

Label | Value
----|----
service | Service ID: `baas`
resource_id | [VM](../../../compute/concepts/vm.md) ID in [{{ compute-name }}](../../../compute/) or [{{ baremetal-name }} server](../../../baremetal/concepts/servers.md) ID in [{{ baremetal-full-name }}](../../../baremetal/).
resource_name | VM or {{ baremetal-name }} server name.
resource_type | Resource type. The possible values are:<br/><ul><li>`vm`: {{ compute-name }} VM or {{ baremetal-name }} server.</li><li>`backup`: [Backup](../../../backup/concepts/backup.md).</li>

{% include [baremetal-note](../../../_includes/backup/baremetal-note.md) %}

Service metrics:

Metric name<br/>Type, units | Description
--- | ---
`protected`<br/>`DGAUGE`, number | Number of VMs and {{ baremetal-name }} servers protected by {{ backup-name }}.
`used_space`<br/>`DGAUGE`, bytes | Amount of storage used by backups.