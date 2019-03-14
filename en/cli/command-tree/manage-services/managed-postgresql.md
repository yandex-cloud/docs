# yc managed-postgresql

Manage [!KEYREF PG].

#### Usage

Syntax:

`yc managed-postgresql <group>`

Aliases:

- `yc postgresql <group>`;
- `yc postgres <group>`.

#### Groups

- `yc managed-postgresql cluster` — manage [!KEYREF PG] clusters.
    - `get` — [show information about the specified [!KEYREF PG] cluster](../../../managed-postgresql/operations/cluster-list.md#get-cluster).
    - `list` — [list [!KEYREF PG] clusters](../../../managed-postgresql/operations/cluster-list.md#list-clusters).
    - `create` — [create [!KEYREF PG] cluster](../../../managed-postgresql/operations/cluster-create.md).
    - `restore` — [restore [!KEYREF PG] cluster](../../../managed-postgresql/operations/cluster-backups.md#restore).
    - `update` — [update the specified [!KEYREF PG] cluster](../../../managed-postgresql/operations/update.md).
    - `update-config` — update the specified [!KEYREF PG] cluster config.
    - `delete` — [delete the specified [!KEYREF PG] cluster](../../../managed-postgresql/operations/cluster-delete.md).
    - `backup` — [create a backup for the specified [!KEYREF PG] cluster](../../../managed-postgresql/operations/cluster-backups.md#create-backup).
    - `list-backups` — list available backups for the specified [!KEYREF PG] cluster.
    - `list-logs` — retrieves logs for the specified [!KEYREF PG] cluster.
    - `list-operations` — list operations for the specified [!KEYREF PG] cluster.
- `yc managed-postgresql hosts` — manage [!KEYREF PG] cluster hosts.
    - `list` — [list hosts for the specified [!KEYREF PG] cluster](../../../managed-postgresql/operations/hosts.md#list).
    - `add` — [create new hosts for the cluster in the specified availability zones](../../../managed-postgresql/operations/hosts.md#add).
    - `update` — [update the specified hosts](../../../managed-postgresql/operations/hosts.md#update).
    - `delete` — [delete the specified hosts](../../../managed-postgresql/operations/hosts.md#remove).
    - `update-config` — updates [!KEYREF PG] config for the specified hosts.
- `yc managed-postgresql database` — manage [!KEYREF PG] databases.
    - `get` — show information about the specified [!KEYREF PG] database.
    - `list` — list [!KEYREF PG] databases.
    - `create` — create [!KEYREF PG] database.
    - `update` — update the specified [!KEYREF PG] database.
    - `delete` — delete the specified [!KEYREF PG] database.
- `yc managed-postgresql user` — manage [!KEYREF PG] users.
    - `get` — show information about the specified [!KEYREF PG] user.
    - `list` — [list users for the specified [!KEYREF PG] cluster](../../../managed-postgresql/operations/cluster-users.md#list-users).
    - `create` — [create a [!KEYREF PG] user](../../../managed-postgresql/operations/cluster-users.md#adduser).
    - `update` — [update the specified [!KEYREF PG] user](../../../managed-postgresql/operations/cluster-users.md#updateuser).
    - `delete` — [delete the specified [!KEYREF PG] user](../../../managed-postgresql/operations/cluster-users.md#removeuser).
    - `grant-permission` — grant permission to the specified [!KEYREF PG] user.
    - `revoke-permission` — revoke permission from the specified [!KEYREF PG] user.
- `yc managed-postgresql backup` — manage [!KEYREF PG] [backups](../../../managed-postgresql/concepts/backup.md).
    - `get` — [show information about the specified [!KEYREF PG] backup](../../../managed-postgresql/operations/cluster-backups.md#get-backup)
    - `list` — [list available backups](../../../managed-postgresql/operations/cluster-backups.md#list-backups).
- `yc managed-postgresql resource-preset` — manage [!KEYREF PG] [resource presets](../../../managed-postgresql/concepts/instance-types.md).
    - `get` — show information about the specified [!KEYREF PG] resource preset.
    - `list` — list available [!KEYREF PG] resource presets.
