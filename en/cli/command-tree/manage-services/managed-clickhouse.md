# yc managed-clickhouse

Manage ClickHouse.

#### Usage

Syntax:

`yc managed-clickhouse <group>`

Aliases:

- `yc clickhouse <group>`.

#### Groups

- `yc managed-clickhouse cluster` — manage ClickHouse clusters.
    - `get` — [show information about the specified ClickHouse cluster](../../../managed-clickhouse/operations/cluster-list.md#get-cluster).
    - `list` — [list ClickHouse clusters](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).
    - `create` — [create ClickHouse cluster](../../../managed-clickhouse/operations/cluster-create.md).
    - `restore` — [restore ClickHouse cluster](../../../managed-clickhouse/operations/cluster-backups.md#restore).
    - `update` — [update the specified ClickHouse cluster](../../../managed-clickhouse/operations/update.md).
    - `update-config` — update the specified ClickHouse cluster config
    - `delete` — [delete the specified ClickHouse cluster](../../../managed-clickhouse/operations/cluster-delete.md).
    - `backup` — [create a backup for the specified ClickHouse cluster](../../../managed-clickhouse/operations/cluster-backups.md#create-backup).
    - `list-backups` — list available backups for the specified ClickHouse cluster.
    - `list-logs` — retrieves logs for the specified ClickHouse cluster.
    - `list-operations` — list operations for the specified ClickHouse cluster.
    - `clear-compression` — clear compression settings of the specified ClickHouse cluster.
    - `set-compression` — set compression settings of the specified ClickHouse cluster.
    - `add-external-dictionary` — add external dictionary to the specified ClickHouse cluster.
    - `remove-external-dictionary` — remove external dictionary from the specified ClickHouse cluster.
    - `add-graphite-rollup` — add graphite rollup to the specified ClickHouse cluster config.
    - `remove-graphite-rollup` — remove graphite rollup from the specified ClickHouse cluster.
- `yc managed-clickhouse hosts` — manage ClickHouse cluster hosts.
    - `list` — [list hosts for the specified ClickHouse cluster](../../../managed-clickhouse/operations/hosts.md#list-hosts).
    - `add` — [create new hosts for the cluster in the specified availability zones](../../../managed-clickhouse/operations/hosts.md#add-host).
    - `delete` — [delete the specified hosts](../../../managed-clickhouse/operations/hosts.md#remove-host).
- `yc managed-clickhouse database` — manage ClickHouse databases.
    - `get` — show information about the specified ClickHouse database.
    - `list` — list ClickHouse databases.
    - `create` — create ClickHouse database.
    - `delete` — delete the specified ClickHouse database.
- `yc managed-clickhouse user` — manage ClickHouse users.
    - `get` — show information about the specified ClickHouse user.
    - `list` — [list users for the specified ClickHouse cluster](../../../managed-clickhouse/operations/cluster-users.md#list-users).
    - `create` — [create a ClickHouse user](../../../managed-clickhouse/operations/cluster-users.md#adduser).
    - `update` — [update the specified ClickHouse user](../../../managed-clickhouse/operations/cluster-users.md#updateuser).
    - `delete` — [delete the specified ClickHouse user](../../../managed-clickhouse/operations/cluster-users.md#removeuser).
    - `grant-permission` — grant permission to the specified ClickHouse user.
    - `revoke-permission` — revoke permission from the specified ClickHouse user.
- `yc managed-clickhouse backup` — manage ClickHouse [backups](../../../managed-clickhouse/concepts/backup.md).
    - `get` — [show information about the specified ClickHouse backup](../../../managed-clickhouse/operations/cluster-backups.md#get-backup).
    - `list` — [list available backups](../../../managed-clickhouse/operations/cluster-backups.md#list-backups).
- `yc managed-clickhouse resource-preset` — manage ClickHouse [resource presets](../../../managed-clickhouse/concepts/instance-types.md).
    - `get` — show information about the specified ClickHouse resource preset.
    - `list` — list available ClickHouse resource presets.
