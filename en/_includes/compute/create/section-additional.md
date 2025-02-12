Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**:

* Optionally, select or create a [service account](../../../iam/concepts/users/service-accounts.md). With a service account, you can flexibly configure access permissions for your resources.
* Optionally, enable access to the [serial console](../../../compute/operations/serial-console/index.md).
* Optionally, under **Backup**, enable **{{ ui-key.yacloud.compute.instances.create.action_activate-backup }}** and select or create a [backup policy](../../../backup/concepts/policy.md) to make automatic backups of your VMs using [{{ backup-name }}](../../../backup/index.yaml).

    For more information, see [{#T}](../../../backup/concepts/vm-connection.md).
* Optionally, under **{{ ui-key.yacloud.compute.instances.create.section_monitoring }}**, enable **{{ ui-key.yacloud.compute.instances.create.unified-agent }}** to configure delivering [metrics](../../../compute/metrics.md) to [{{ monitoring-full-name }}](../../../compute/monitoring/).
* Optionally, under **{{ ui-key.yacloud.compute.instances.create.section_placement }}**, select a VM [placement group](../../../compute/concepts/placement-groups.md).