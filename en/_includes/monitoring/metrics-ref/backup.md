The `name` label contains the metric name.

Labels shared by all {{ backup-name }} metrics:

#|
|| **Label** | **Value** ||
|| service | Service ID: `backup` ||
|| resource_id | ID of a [VM](../../../compute/concepts/vm.md) in [{{ compute-name }}](../../../compute/) or [{{ baremetal-name }} server](../../../baremetal/concepts/servers.md) in [{{ baremetal-full-name }}](../../../baremetal/) ||
|| resource_name | {{ compute-name }} VM or {{ baremetal-name }} server name ||
|| resource_type | Resource type. The possible values are:
* `agent`: [{{ backup-name }} agent](../../../backup/concepts/agent.md).
* `vm`: {{ compute-name }} VM or {{ baremetal-name }} server.
* `backup`: [Backup](../../../backup/concepts/backup.md). ||
|#

Service metrics:

#|
|| **Metric name**
**Type, units** | **Description** ||
|| `agent_alive`
`DGAUGE` | [{{ backup-name }} agent](../../../backup/concepts/agent.md) activity indicator. The possible values are:
* `1`: Agent is active.
* `0`: Agent is inactive. The system is not creating backups.The user’s attention is required.

Resource type: `agent`. ||
|| `agent_version_available`
`DGAUGE` | Availability indicator for a new {{ backup-name }} agent version. The possible values are:
* `1`: Update is available.
* `0`: Latest version is in use.

Resource type: `agent`. ||
|| `protected`
`DGAUGE`, count | Number of {{ compute-name }} VMs and {{ baremetal-name }} servers covered by {{ backup-name }}.

Resource type: `vm`. ||
|| `BackupError`
`DGAUGE`, count | Number of backup creation errors. Additional labels:
* `action`: Action type.
* `event_type`: Event type.
* `level`: Logging level.
* `policy_id`: [Backup policy](../../../backup/concepts/policy.md) ID.
* `policy_name`: Name of the backup policy.

Resource type: `backup`. ||
|| `used_space`
`DGAUGE`, bytes | Storage used by backups

Resource type: `backup`. ||
|#