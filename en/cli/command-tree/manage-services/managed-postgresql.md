# yc managed-postgresql

Manage {{ PG }}.

#### Usage

Syntax:

`yc managed-postgresql <group>`

Aliases:

- `yc postgresql <group>`;
- `yc postgres <group>`.

#### Groups

- `yc managed-postgresql cluster` — manage {{ PG }} clusters.
    - `get` — [show information about the specified {{ PG }} cluster](../../../managed-postgresql/operations/cluster-list.md#get-cluster).
    - `list` — [list {{ PG }} clusters](../../../managed-postgresql/operations/cluster-list.md#list-clusters).
    - `create` — [create {{ PG }} cluster](../../../managed-postgresql/operations/cluster-create.md).
    - `restore` — [restore {{ PG }} cluster](../../../managed-postgresql/operations/cluster-backups.md#restore).
    - `update` — [update the specified {{ PG }} cluster](../../../managed-postgresql/operations/update.md).
    - `update-config` — update the specified {{ PG }} cluster config.
    - `delete` — [delete the specified {{ PG }} cluster](../../../managed-postgresql/operations/cluster-delete.md).
    - `backup` — [create a backup for the specified {{ PG }} cluster](../../../managed-postgresql/operations/cluster-backups.md#create-backup).
    - `list-backups` — list available backups for the specified {{ PG }} cluster.
    - `list-logs` — retrieves logs for the specified {{ PG }} cluster.
    - `list-operations` — list operations for the specified {{ PG }} cluster.
- `yc managed-postgresql hosts` — manage {{ PG }} cluster hosts.
    - `list` — [list hosts for the specified {{ PG }} cluster](../../../managed-postgresql/operations/hosts.md#list).
    - `add` — [create new hosts for the cluster in the specified availability zones](../../../managed-postgresql/operations/hosts.md#add).
    - `update` — [update the specified hosts](../../../managed-postgresql/operations/hosts.md#update).
    - `delete` — [delete the specified hosts](../../../managed-postgresql/operations/hosts.md#remove).
    - `update-config` — updates {{ PG }} config for the specified hosts.
- `yc managed-postgresql database` — manage {{ PG }} databases.
    - `get` — show information about the specified {{ PG }} database.
    - `list` — list {{ PG }} databases.
    - `create` — create {{ PG }} database.
    - `update` — update the specified {{ PG }} database.
    - `delete` — delete the specified {{ PG }} database.
- `yc managed-postgresql user` — manage {{ PG }} users.
    - `get` — show information about the specified {{ PG }} user.
    - `list` — [list users for the specified {{ PG }} cluster](../../../managed-postgresql/operations/cluster-users.md#list-users).
    - `create` — [create a {{ PG }} user](../../../managed-postgresql/operations/cluster-users.md#adduser).
    - `update` — [update the specified {{ PG }} user](../../../managed-postgresql/operations/cluster-users.md#updateuser).
    - `delete` — [delete the specified {{ PG }} user](../../../managed-postgresql/operations/cluster-users.md#removeuser).
    - `grant-permission` — grant permission to the specified {{ PG }} user.
    - `revoke-permission` — revoke permission from the specified {{ PG }} user.
- `yc managed-postgresql backup` — manage {{ PG }} [backups](../../../managed-postgresql/concepts/backup.md).
    - `get` — [show information about the specified {{ PG }} backup](../../../managed-postgresql/operations/cluster-backups.md#get-backup)
    - `list` — [list available backups](../../../managed-postgresql/operations/cluster-backups.md#list-backups).
- `yc managed-postgresql resource-preset` — manage {{ PG }} [resource presets](../../../managed-postgresql/concepts/instance-types.md).
    - `get` — show information about the specified {{ PG }} resource preset.
    - `list` — list available {{ PG }} resource presets.
