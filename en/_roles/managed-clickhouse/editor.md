The `managed-clickhouse.editor` role grants read and write access to ClickHouse clusters.

Users with this role can create, edit, delete, run, and stop ClickHouse clusters, read and write to databases, and view information about clusters, runtime logs, and quotas.

It includes the permissions of the `managed-clickhouse.viewer` role.

To create ClickHouse clusters, you also need the `vpc.user` role.