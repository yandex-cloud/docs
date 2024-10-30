Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**:

* (Optional) Select or create a [service account](../../../iam/concepts/users/service-accounts.md). With a service account, you can flexibly configure access rights for your resources.
* (Optional) Grant access to the [serial console](../../../compute/operations/serial-console/index.md).
* (Optional) Under **Backup**, enable **{{ ui-key.yacloud.compute.instances.create.action_activate-backup }}** and select or create a [backup policy](../../../backup/concepts/policy.md) to back up your VMs automatically using [{{ backup-name }}](../../../backup/index.yaml).

    For more information, see [{#T}](../../../backup/concepts/vm-connection.md).
* (Optional) Under **{{ ui-key.yacloud.compute.instances.create.section_monitoring }}**, enable the **{{ ui-key.yacloud.compute.instances.create.unified-agent }}** option to configuire delivery of [metrics](../../../compute/metrics.md) to [{{ monitoring-full-name }}](../../../compute/monitoring/).
* (Optional) Under **{{ ui-key.yacloud.compute.instances.create.section_placement }}**, select a VM [placement group](../../../compute/concepts/placement-groups.md).