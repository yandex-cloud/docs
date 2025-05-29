# Impersonation in {{ mtr-name }}

_Impersonation_ in {{ mtr-name }} is when an {{ TR }} cluster performs actions with user resources on behalf of a service account.

By default, an {{ TR }} cluster does not have permissions to access user resources. To provide access to such resources, [create a service account](../../iam/operations/sa/create.md#create-sa) with the required roles and link it to the {{ TR }} cluster when [creating](../operations/cluster-create.md#create-cluster) or [updating](../operations/cluster-update.md) the cluster. With that done, the [coordinator](index.md#coordinator) and [workers](index.md#workers) will be able to authenticate as this service account. For example, Hive, Iceberg, and Delta Lake [connectors](index.md#connector) authenticate in {{ objstorage-name }} as the cluster service account.

Impersonation enables an {{ TR }} cluster to support integration with other {{ yandex-cloud }} services. These include [{{ cloud-logging-full-name }}](../../logging/index.yaml) and [{{ monitoring-full-name }}](../../monitoring/concepts/index.md).

For a cluster to be able to interface with the services, assign the `managed-trino.integrationProvider` [role](../security.md#managed-trino-integrationProvider) to its service account. The role will allow the cluster to write logs to {{ cloud-logging-name }} or send metrics to {{ monitoring-name }}.

## Services available for integration {#services}

### {{ cloud-logging-name }} {#cloud-logging-integration}

{{ cloud-logging-name }} stores and reads logs collected by {{ yandex-cloud }} services. In a {{ mtr-name }} cluster with logging enabled, cluster logs will be saved to the selected {{ cloud-logging-name }} log group.


### {{ monitoring-name }} {#monitoring-integration}

{{ monitoring-name }} is a service that collects and stores metrics for {{ yandex-cloud }} services. Metrics are displayed as charts on the cluster page under **{{ ui-key.yacloud.common.monitoring }}**. They show the current state and health of the cluster. Metrics are available by default in all {{ mtr-name }} clusters.
