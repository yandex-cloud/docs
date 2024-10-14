# Impersonation in {{ metastore-name }}

{% include [Preview](../../_includes/note-preview.md) %}

_Impersonation_ allows a [{{ metastore-name }}](metastore.md) cluster to work with cloud resources on behalf of a [service account](../../iam/concepts/users/service-accounts.md).

By default, a {{ metastore-name }} cluster does not have permissions to access user resources. To provide access to such resources, [create a service account](../../iam/operations/sa/create.md#create-sa) with the required roles and attach it to the {{ metastore-name }} cluster when [creating the cluster](../operations/metastore/cluster-create.md#create-cluster). After that, {{ metastore-name }} will have access to user resources by authorizing on behalf of a service account.

The roles required for the service account depend on which service you are going to use {{ metastore-name }} with. For example, you need the `{{ roles-logging-writer }}` role to configure cluster log export in [{{ cloud-logging-full-name }}](../../logging/index.yaml), and the `{{ roles-monitoring-editor }}`, to use [{{ monitoring-full-name }}](../../monitoring/index.yaml) dashboards.

When creating a service account for {{ metastore-name }}, we recommend using the `{{ roles.metastore.integrationProvider}}` role as it already includes the `{{ roles-logging-writer }}` and `{{ roles-monitoring-editor }}` roles. For more information about this role, see [this reference](../security/metastore-roles.md#managed-metastore-integrationProvider).
