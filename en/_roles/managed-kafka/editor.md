
The `managed-kafka.editor` role enables managing {{ KF }} clusters.

Users with this role can:
* View info on [{{ KF }} clusters](../../managed-kafka/concepts/index.md), as well as create, use, modify, delete, run, and stop them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for {{ KF }} clusters.
* Use [Kafka UI](../../managed-kafka/concepts/kafka-ui.md) for {{ KF }}.
* View info on [maintenance](../../managed-kafka/concepts/maintenance.md) tasks for {{ KF }} clusters and modify such tasks.
* View {{ KF }} cluster logs.
* View info on [quotas](../../managed-kafka/concepts/limits.md#mkf-quotas) for {{ mkf-name }}.
* View info on resource operations for {{ mkf-name }}.

This role includes the `managed-kafka.viewer`, `managed-kafka.user`, `managed-kafka.interfaceUser`, and `managed-kafka.maintenanceTask.editor` permissions.

To create {{ KF }} clusters, you also need the `vpc.user` role.