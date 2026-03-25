The `managed-spark.editor` role enables managing Apache Spark™ clusters and jobs.

Users with this role can:
* View info on [Apache Spark™ clusters](../../managed-spark/concepts/index.md), as well as create, modify, run, stop, and delete them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for Apache Spark™ clusters.
* View info on [maintenance](../../managed-spark/concepts/maintenance.md) tasks for Apache Spark™ clusters and modify such tasks.
* Use the Apache Spark™ web interface.
* View info on [jobs](../../managed-spark/operations/index.md#jobs), as well as create, run, and cancel them.
* View info on [quotas](../../managed-spark/concepts/limits.md#quotas) for Managed Service for Apache Spark™.

This role includes the `managed-spark.user` and `managed-spark.maintenanceTask.editor` permissions.

To create Apache Spark™ clusters, you also need the `vpc.user` role.