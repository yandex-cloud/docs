The `managed-spark.integrationProvider` role enables an Apache Spark™ cluster to work with user resources required for its operation on behalf of a service account. You need to assign this role to a service account linked to an Apache Spark™ cluster.

Users with this role can:
* Add entries to [log groups](../../logging/concepts/log-group.md).
* View info on log groups.
* View info on log sinks.
* View info on granted [access permissions](../../iam/concepts/access-control/index.md) for Cloud Logging resources.
* View info on log exports.
* View info on [metrics](../../monitoring/concepts/data-model.md#metric) and their [labels](../../monitoring/concepts/data-model.md#label), as well as upload and download metrics.
* View lists of [dashboards](../../monitoring/concepts/visualization/dashboard.md) and [widgets](../../monitoring/concepts/visualization/widget.md) and info on them, as well as create, modify, and delete them.
* View [notification](../../monitoring/concepts/alerting/notification-channel.md) history.
* View details on [Monitoring quotas](../../monitoring/concepts/limits.md#monitoring-quotas).
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `logging.writer` and `monitoring.editor` permissions.
