The `managed-kafka.editor` role enables managing Apache Kafka® clusters.

Users with this role can:
* View info on [Apache Kafka® clusters](../../managed-kafka/concepts/index.md), as well as create, use, modify, delete, run, and stop them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for Apache Kafka® clusters.
* Use [Kafka UI](../../managed-kafka/concepts/kafka-ui.md) for Apache Kafka®.
* View info on [maintenance](../../managed-kafka/concepts/maintenance.md) tasks for Apache Kafka® clusters and modify such tasks.
* View Apache Kafka® cluster logs.
* View info on [quotas](../../managed-kafka/concepts/limits.md#mkf-quotas) for Managed Service for Apache Kafka®.
* View info on resource operations for Managed Service for Apache Kafka®.

This role includes the `managed-kafka.viewer`, `managed-kafka.user`, `managed-kafka.interfaceUser`, and `managed-kafka.maintenanceTask.editor` permissions.

To create Apache Kafka® clusters, you also need the `vpc.user` role.