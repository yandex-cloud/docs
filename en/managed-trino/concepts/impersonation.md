# Impersonation in {{ mtr-name }}

_Impersonation_ in {{ mtr-name }} is when an {{ TR }} cluster performs actions with user resources on behalf of a service account.

By default, an {{ TR }} cluster does not have permissions to access user resources. To provide access to such resources, [create a service account](../../iam/operations/sa/create.md#create-sa) with the required roles and link it to the {{ TR }} cluster when [creating](../operations/cluster-create.md#create-cluster) or [updating](../operations/cluster-update.md#change-sa) the cluster. With that done, the [coordinator](index.md#coordinator) and [workers](index.md#workers) will be able to authenticate as this service account. For example, Hive, Iceberg, and Delta Lake [connectors](index.md#connector) authenticate in {{ objstorage-name }} as the cluster service account.

Impersonation enables an {{ TR }} cluster to support integration with other {{ yandex-cloud }} services. These include [{{ cloud-logging-full-name }}](../../logging/index.yaml), [{{ monitoring-full-name }}](../../monitoring/concepts/index.md), [{{ connection-manager-full-name }}](../../metadata-hub/concepts/connection-manager.md), and [{{ objstorage-full-name }}](../../storage/index.yaml).

For a cluster to be able to interface with the services, assign the following roles to its service account:
* [managed-trino.integrationProvider](../security.md#managed-trino-integrationProvider): This role will allow the cluster to write logs to {{ cloud-logging-name }} or send metrics to {{ monitoring-name }}.
* [connection-manager.user](../../metadata-hub/security/connection-manager-roles.md#connection-manager-user): For using connections from {{ connection-manager-name }}.
* [lockbox.payloadViewer](../../lockbox/security/index.md#lockbox-payloadViewer): For using {{ lockbox-full-name }} [secrets](../../metadata-hub/concepts/secret.md).
* [storage.editor](../../storage/security/index.md#storage-editor): For interfacing with the {{ objstorage-name }} bucket.

## Services available for integration {#services}

### {{ connection-manager-name }} {#connection-manager-integration}

{{ connection-manager-name }} is a service for managing parameters of connections to user database installations and secure password storage. If a {{ mtr-name }} cluster [folder](index.md#catalog) indicates **Connection Manager** as connection type, the cluster service account gets connection parameters, such as network addresses, ports, encrypted username and password, by its ID in {{ connection-manager-name }}.

### {{ cloud-logging-name }} {#cloud-logging-integration}

{{ cloud-logging-name }} stores and reads logs collected by {{ yandex-cloud }} services. If logging is enabled in a {{ mtr-name }} cluster, the cluster logs will be saved to the [default log group](../../logging/concepts/log-group.md) of the selected folder or to the custom log group in {{ cloud-logging-name }}.

You can enable logging when [creating](../operations/cluster-create.md) or [updating](../operations/cluster-update.md#change-additional-settings) a cluster.

### {{ monitoring-name }} {#monitoring-integration}

{{ monitoring-name }} enables collecting and storing the metrics of {{ yandex-cloud }} services. Metrics are displayed as charts on the cluster page under **{{ ui-key.yacloud.common.monitoring }}**. They show the current state and health of the cluster. Metrics are available by default in all {{ mtr-name }} clusters. For a list of available metrics, see the relevant [reference](../metrics.md).

### {{ objstorage-name }} {#objstorage-integration}

{{ objstorage-name }} is a service for data storage. To enable {{ mtr-full-name }} to interface with an {{ objstorage-name }} bucket, you need a {{ metastore-full-name }} cluster. The service accounts associated with the {{ mtr-name }} and {{ metastore-full-name }} clusters must be assigned the `storage.editor` role.
