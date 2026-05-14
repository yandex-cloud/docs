
The `managed-metastore.integrationProvider` role allows the {{ metastore-name }} cluster to work with user resources required for its operation on behalf of the service account. You can assign this role to a service account linked to a {{ metastore-name }} cluster.

Users with this role can:
* Add entries to [log groups](../../logging/concepts/log-group.md).
* View info on log groups.
* View info on log sinks.
* View info on granted [access permissions](../../iam/concepts/access-control/index.md) for {{ cloud-logging-name }} resources.
* View info on log exports.
* View info on {{ monitoring-name }} [metrics](../../monitoring/concepts/data-model.md#metric) and their [labels](../../monitoring/concepts/data-model.md#label), as well as upload and download metrics.
* View the list of {{ monitoring-name }} [dashboards](../../monitoring/concepts/visualization/dashboard.md) and [widgets](../../monitoring/concepts/visualization/widget.md) and info on them, as well as create, modify, and delete them.
* View the {{ monitoring-name }} [notification](../../monitoring/concepts/alerting/notification-channel.md) history.
* View details on [{{ monitoring-name }}](../../monitoring/concepts/limits.md#monitoring-quotas) quotas.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `logging.writer` and `monitoring.editor` permissions.
