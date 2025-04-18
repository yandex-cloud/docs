Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**:

* Optionally, select or create a [service account](../../../iam/concepts/users/service-accounts.md). With a service account, you can flexibly configure access permissions for your resources.
* Optionally, enable access to the [serial console](../../../compute/operations/serial-console/index.md).
* Optionally, under **Backup**, enable **{{ ui-key.yacloud.compute.instances.create.action_activate-backup }}** and select or create a [backup policy](../../../backup/concepts/policy.md) to make automatic backups of your VMs using [{{ backup-name }}](../../../backup/index.yaml).

    For more information, see [{#T}](../../../backup/concepts/vm-connection.md).

* Optionally, to configure delivering [Linux metrics](../../../monitoring/operations/unified-agent/linux_metrics.md) and any additional metrics from your apps, enable **{{ ui-key.yacloud.compute.instances.create.section_monitoring }}** under **{{ ui-key.yacloud.compute.instances.create.unified-agent }}** and select:
  * **{{ monitoring-full-name }}**: [Install an agent](../../../monitoring/concepts/data-collection/unified-agent/index.md) to collect additional metrics from VM instances and apps.
  * **{{ managed-prometheus-name }}**: [Install and configure an agent](../../../monitoring/operations/prometheus/ingestion/prometheus-agent.md) to collect additional metrics from VM instances and apps in {{ prometheus-name }} format:
     * Select or create a workspace to store your metrics.
     * Optionally, describe the [delivery parameters](../../../monitoring/operations/prometheus/ingestion/prometheus-agent.md) for your custom metrics, in JSON format.
* Optionally, under **{{ ui-key.yacloud.compute.instances.create.section_placement }}**, select a VM [placement group](../../../compute/concepts/placement-groups.md).