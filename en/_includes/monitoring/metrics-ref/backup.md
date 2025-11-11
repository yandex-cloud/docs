The `name` label contains the metric name.

Labels shared by all {{ backup-name }} metrics:

#|
|| **Label** | **Value** ||
|| service | Service ID: `backup` ||
|| resource_id | ID of a [VM](../../../compute/concepts/vm.md) in [{{ compute-name }}](../../../compute/) or [{{ baremetal-name }} server](../../../baremetal/concepts/servers.md) in [{{ baremetal-full-name }}](../../../baremetal/) ||
|| resource_name | {{ compute-name }} VM or {{ baremetal-name }} server name ||
|| resource_type | Resource type. The possible values are:
* `vm`: {{ compute-name }} VM or {{ baremetal-name }} server.
* `backup`: [Backup](../../../backup/concepts/backup.md). ||
|#

Service metrics:

#|
|| **Metric name**
**Type, units** | **Description** ||
|| `agent_alive`
`DGAUGE` | [{{ backup-name }} agent](../../../backup/concepts/agent.md) agent activity indicator. The possible values are:
* `1`: Agent is active.
* `0`: Agent is inactive. The system is not creating backups.The user’s attention is required. ||
|| `agent_version_available`
`DGAUGE` | Availability indicator for a new {{ backup-name }} agent version. The possible values are:
* `1`: Update is available.
* `0`: Latest version is in use. ||
|| `protected`
`DGAUGE`, count | Number of {{ compute-name }} VMs and {{ baremetal-name }} servers using {{ backup-name }} ||
|| `BackupError`
`DGAUGE`, count | Number of backup creation errors. Additional labels:
* `action`: Action type.
* `event_type`: Event type.
* `level`: Logging level.
* `policy_id`: [Backup policy](../../../backup/concepts/policy.md) ID.
* `policy_name`: Name of the backup policy. ||
|| `used_space`
`DGAUGE`, bytes | Storage used by backups ||
|#