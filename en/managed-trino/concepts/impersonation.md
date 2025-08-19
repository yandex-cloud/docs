# Impersonation in {{ mtr-name }}

_Impersonation_ in {{ mtr-name }} is when an {{ TR }} cluster performs actions with user resources on behalf of a service account.

By default, an {{ TR }} cluster does not have permissions to access user resources. To provide access to such resources, [create a service account](../../iam/operations/sa/create.md#create-sa) with the required roles and link it to the {{ TR }} cluster when [creating](../operations/cluster-create.md#create-cluster) or [updating](../operations/cluster-update.md) the cluster. With that done, the [coordinator](index.md#coordinator) and [workers](index.md#workers) will be able to authenticate as this service account. For example, Hive, Iceberg, and Delta Lake [connectors](index.md#connector) authenticate in {{ objstorage-name }} as the cluster service account.

Impersonation enables an {{ TR }} cluster to support integration with other {{ yandex-cloud }} services. These include [{{ cloud-logging-full-name }}](../../logging/index.yaml), [{{ monitoring-full-name }}](../../monitoring/concepts/index.md), and [{{ connection-manager-full-name }}](../../metadata-hub/concepts/connection-manager.md).

For a cluster to be able to interface with the services, assign the `managed-trino.integrationProvider` [role](../security.md#managed-trino-integrationProvider) to its service account. The role will allow the cluster to write logs to {{ cloud-logging-name }} or send metrics to {{ monitoring-name }}. To use connections from {{ connection-manager-name }} and their [secrets](../../metadata-hub/concepts/secret.md), assign the additional `connection-manager.user` and `lockbox.payloadViewer` roles to the cluster service account.

## Services available for integration {#services}

### {{ connection-manager-name }} {#connection-manager-integration}

{{ connection-manager-name }} is a service for managing parameters of connections to user database installations and secure password storage. If a {{ mtr-name }} cluster [folder](index.md#catalog) indicates **Connection Manager** as connection type, the cluster service account gets connection parameters, such as network addresses, ports, encrypted username and password, by its ID in {{ connection-manager-name }}.

### {{ cloud-logging-name }} {#cloud-logging-integration}

{{ cloud-logging-name }} stores and reads logs collected by {{ yandex-cloud }} services. If logging is enabled in a {{ mtr-name }} cluster, the cluster logs will be saved to the [default log group](../../logging/concepts/log-group.md) of the selected folder or to the custom log group in {{ cloud-logging-name }}.

You can enable logging when [creating](../operations/cluster-create.md) or [updating](../operations/cluster-update.md) a cluster.

### {{ monitoring-name }} {#monitoring-integration}

{{ monitoring-name }} enables collecting and storing the metrics of {{ yandex-cloud }} services. Metrics are displayed as charts on the cluster page under **{{ ui-key.yacloud.common.monitoring }}**. They show the current state and health of the cluster. Metrics are available by default in all {{ mtr-name }} clusters. For a list of available metrics, see the relevant [reference](../metrics.md).
