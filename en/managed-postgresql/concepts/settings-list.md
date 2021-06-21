# {{ PG }} settings

For {{ mpg-name }} clusters, you can configure settings that relate to {{ PG }}. Some settings are set [at the cluster level](#dbms-cluster-settings) and others [at the user level](#user-level-settings).

The label next to the setting name lets you determine which interface is used to set the value of this setting: the management console, CLI, API, SQL, or Terraform. The {{ tag-all }} label indicates that all of the above interfaces are supported.

Depending on the selected interface, the same setting is represented in a different way, for example:

- **Backend flush after** in the management console corresponds to:
  - `backend_flush_after` in the gRPC API, CLI, Terraform, and SQL.
  - `backendFlushAfter` in the REST API.
- **Default transaction isolation** in the user-level settings in the management console corresponds to:
  - `--default-transaction-isolation` in the CLI.
  - `default_transaction_isolation` in the gRPC API.
  - `defaultTransactionIsolation` in the REST API.

## Cluster-level DBMS settings {#dbms-cluster-settings}

You can use the following settings:

{% include [mpg-dbms-settings](../../_includes/mdb/mpg-dbms-settings.md) %}

## Custom settings {#dbms-user-settings}

These settings affect the behavior of {{ PG }} when handling user queries.

You can use the following settings:

{% include [mpg-dbms-user-settings](../../_includes/mdb/mpg-dbms-user-settings.md) %}

