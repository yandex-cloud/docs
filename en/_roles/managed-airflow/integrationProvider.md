The `managed-airflow.integrationProvider` role allows the Apache Airflow™ cluster to work with user resources required for its operation on behalf of the service account. You can assign this role to a service account linked to the Apache Airflow™ cluster.

{% cut "Service accounts with this role can:" %}

* Add entries to [log groups](../../logging/concepts/log-group.md).
* View info on log groups.
* View info on log sinks.
* View info on granted [access permissions](../../iam/concepts/access-control/index.md) for Cloud Logging resources.
* View info on log exports.
* View info on Monitoring [metrics](../../monitoring/concepts/data-model.md#metric) and their [labels](../../monitoring/concepts/data-model.md#label), as well as upload and download metrics.
* View the list of Monitoring [dashboards](../../monitoring/concepts/visualization/dashboard.md) and [widgets](../../monitoring/concepts/visualization/widget.md) and info on them, as well as create, modify, and delete them.
* View the Monitoring [notification](../../monitoring/concepts/alerting/notification-channel.md) history.
* View the list of [buckets](../../storage/concepts/bucket.md) and info on them, including their deployment region, [versioning](../../storage/concepts/versioning.md), [encryption](../../storage/concepts/encryption.md), [CORS](../../storage/concepts/cors.md) configuration, [static website hosting](../../storage/concepts/hosting.md) configuration, [HTTPS](../../storage/concepts/bucket.md#bucket-https) configuration, [logging](../../storage/concepts/server-logs.md) settings, granted access permissions, [public access](../../storage/concepts/bucket.md#bucket-access), and default [storage class](../../storage/concepts/storage-class.md#default-storage-class).
* View lists of [objects](../../storage/concepts/object.md) in buckets and info on these objects, including object [lifecycle](../../storage/concepts/lifecycles.md) configuration, granted access permissions for these objects, current [multipart uploads](../../storage/concepts/multipart.md), object versions with their [metadata](../../storage/concepts/object.md#metadata), and [object locks](../../storage/concepts/object-lock.md) (both with a retention period and legal hold).
* View bucket, object, and object version [labels](../../storage/concepts/tags.md), as well as Object Storage statistics.
* View info on [Yandex Lockbox secrets](../../lockbox/concepts/secret.md#secret) and granted access permissions for them.
* View details on [Object Storage](../../storage/concepts/limits.md#storage-quotas), [Monitoring](../../monitoring/concepts/limits.md#monitoring-quotas), and [Yandex Lockbox](../../lockbox/concepts/limits.md#quotas) quotas.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

This role also includes the `logging.writer`, `monitoring.editor`, `storage.viewer`, and `lockbox.viewer` permissions.

The role does not provide access to Yandex Lockbox secret contents. To grant the Apache Airflow™ cluster access to Yandex Lockbox secret contents, additionally assign the `lockbox.payloadViewer` [role](../../lockbox/security/index.md#lockbox-payloadViewer)to the [service account](../../iam/concepts/users/service-accounts.md) either for the relevant folder or for specific secrets.