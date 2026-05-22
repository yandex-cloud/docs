
The `managed-kafka.admin` role enables managing {{ KF }} clusters and access to them.

Users with this role can:
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for [{{ KF }} clusters](../../managed-kafka/concepts/index.md) and modify such permissions.
* View info on {{ KF }} clusters, as well as create, use, modify, delete, run, and stop them.
* Use [Kafka UI](../../managed-kafka/concepts/kafka-ui.md) for {{ KF }}.
* View info on [maintenance](../../managed-kafka/concepts/maintenance.md) tasks for {{ KF }} clusters and modify such tasks.
* View {{ KF }} cluster logs.
* View info on [quotas](../../managed-kafka/concepts/limits.md#mkf-quotas) for {{ mkf-name }}.
* View info on resource operations for {{ mkf-name }}.

This role includes the `managed-kafka.editor` permissions.

To create {{ KF }} clusters, you also need the `vpc.user` role.