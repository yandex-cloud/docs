The `managed-clickhouse.admin` role allows you to manage ClickHouse® clusters and view their logs, as well as get information about quotas and service resource operations.

Users with this role can:
* Manage access to ClickHouse® clusters.
* View information about [ClickHouse® clusters](../../managed-clickhouse/concepts/index.md), as well as create, modify, delete, run, and stop them.
* View ClickHouse® cluster logs.
* View information about [quotas](../../managed-clickhouse/concepts/limits.md#mch-quotas) of Managed Service for ClickHouse®.
* View information about operations with resources of Managed Service for ClickHouse®.

This role includes the `managed-clickhouse.editor` permissions.

To create ClickHouse® clusters, you also need the `vpc.user` role.