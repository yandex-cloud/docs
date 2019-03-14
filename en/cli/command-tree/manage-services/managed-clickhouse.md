# yc managed-clickhouse

Manage [!KEYREF CH].

#### Usage

Syntax:

`yc managed-clickhouse <group>`

Aliases: 

- `yc clickhouse <group>`.

#### Groups

- `yc managed-clickhouse cluster` — manage [!KEYREF CH] clusters.
    - `get` — [show information about the specified [!KEYREF CH] cluster](../../../managed-clickhouse/operations/cluster-list.md#get-cluster).
    - `list` — [list [!KEYREF CH] clusters](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).
    - `create` — [create [!KEYREF CH] cluster](../../../managed-clickhouse/operations/cluster-create.md).
    - `restore` — [restore [!KEYREF CH] cluster](../../../managed-clickhouse/operations/cluster-backups.md#restore).
    - `update` — [update the specified [!KEYREF CH] cluster](../../../managed-clickhouse/operations/update.md).
    - `update-config` — update the specified [!KEYREF CH] cluster config
    - `delete` — [delete the specified [!KEYREF CH] cluster](../../../managed-clickhouse/operations/cluster-delete.md).
    - `backup` — [create a backup for the specified [!KEYREF CH] cluster](../../../managed-clickhouse/operations/cluster-backups.md#create-backup).
    - `list-backups` — list available backups for the specified [!KEYREF CH] cluster.
    - `list-logs` — retrieves logs for the specified [!KEYREF CH] cluster.
    - `list-operations` — list operations for the specified [!KEYREF CH] cluster.
    - `clear-compression` — clear compression settings of the specified [!KEYREF CH] cluster.
    - `set-compression` — set compression settings of the specified [!KEYREF CH] cluster.
    - `add-external-dictionary` — add external dictionary to the specified [!KEYREF CH] cluster.
    - `remove-external-dictionary` — remove external dictionary from the specified [!KEYREF CH] cluster.
    - `add-graphite-rollup` — add graphite rollup to the specified [!KEYREF CH] cluster config.
    - `remove-graphite-rollup` — remove graphite rollup from the specified [!KEYREF CH] cluster.
- `yc managed-clickhouse hosts` — manage [!KEYREF CH] cluster hosts.
    - `list` — [list hosts for the specified [!KEYREF CH] cluster](../../../managed-clickhouse/operations/hosts.md#list-hosts).
    - `add` — [create new hosts for the cluster in the specified availability zones](../../../managed-clickhouse/operations/hosts.md#add-host).
    - `delete` — [delete the specified hosts](../../../managed-clickhouse/operations/hosts.md#remove-host).
- `yc managed-clickhouse database` — manage [!KEYREF CH] databases.
    - `get` — show information about the specified [!KEYREF CH] database.
    - `list` — list [!KEYREF CH] databases.
    - `create` — create [!KEYREF CH] database.
    - `delete` — delete the specified [!KEYREF CH] database.
- `yc managed-clickhouse user` — manage [!KEYREF CH] users.
    - `get` — show information about the specified [!KEYREF CH] user.
    - `list` — [list users for the specified [!KEYREF CH] cluster](../../../managed-clickhouse/operations/cluster-users.md#list-users).
    - `create` — [create a [!KEYREF CH] user](../../../managed-clickhouse/operations/cluster-users.md#adduser).
    - `update` — [update the specified [!KEYREF CH] user](../../../managed-clickhouse/operations/cluster-users.md#updateuser).
    - `delete` — [delete the specified [!KEYREF CH] user](../../../managed-clickhouse/operations/cluster-users.md#removeuser).
    - `grant-permission` — grant permission to the specified [!KEYREF CH] user.
    - `revoke-permission` — revoke permission from the specified [!KEYREF CH] user.
- `yc managed-clickhouse backup` — manage [!KEYREF CH] [backups](../../../managed-clickhouse/concepts/backup.md).
    - `get` — [show information about the specified [!KEYREF CH] backup](../../../managed-clickhouse/operations/cluster-backups.md#get-backup).
    - `list` — [list available backups](../../../managed-clickhouse/operations/cluster-backups.md#list-backups).
- `yc managed-clickhouse resource-preset` — manage [!KEYREF CH] [resource presets](../../../managed-clickhouse/concepts/instance-types.md).
    - `get` — show information about the specified [!KEYREF CH] resource preset.
    - `list` — list available ClickHouse resource presets.
