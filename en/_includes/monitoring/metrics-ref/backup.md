The metric name is written to the `name` label.

Common labels for all {{ backup-name }} metrics:

| Label | Value |
----|----
| service | Service ID: `baas`. |
| resource_id | [VM](../../../compute/concepts/vm.md) ID in [{{ compute-name }}](../../../compute/). |
| resource_name | VM name. |
| resource_type | Resource type. Possible values:<br/><ul><li>`vm`: {{ compute-name }} virtual machine.</li><li>`backup`: [Backup](../../../backup/concepts/backup.md).</li> |

Service metrics:

| Metric name<br/>Type, unit | Description |
--- | ---
| `protected`<br/>`DGAUGE`, number | Number of VMs protected by {{ backup-name }}. |
| `used_space`<br/>`DGAUGE`, bytes | Amount of storage used by backups. |