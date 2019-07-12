# yc managed-postgresql

Manage PostgreSQL.

#### Usage

Syntax:

`yc managed-postgresql <group>`

Aliases:

- `yc postgresql <group>`;
- `yc postgres <group>`.

#### Groups

- `yc managed-postgresql cluster` — manage PostgreSQL clusters.
    - `get` — [show information about the specified PostgreSQL cluster](../../../managed-postgresql/operations/cluster-list.md#get-cluster).
    - `list` — [list PostgreSQL clusters](../../../managed-postgresql/operations/cluster-list.md#list-clusters).
    - `create` — [create PostgreSQL cluster](../../../managed-postgresql/operations/cluster-create.md).
    - `restore` — [restore PostgreSQL cluster](../../../managed-postgresql/operations/cluster-backups.md#restore).
    - `update` — [update the specified PostgreSQL cluster](../../../managed-postgresql/operations/update.md).
    - `update-config` — update the specified PostgreSQL cluster config.
    - `delete` — [delete the specified PostgreSQL cluster](../../../managed-postgresql/operations/cluster-delete.md).
    - `backup` — [create a backup for the specified PostgreSQL cluster](../../../managed-postgresql/operations/cluster-backups.md#create-backup).
    - `list-backups` — list available backups for the specified PostgreSQL cluster.
    - `list-logs` — retrieves logs for the specified PostgreSQL cluster.
    - `list-operations` — list operations for the specified PostgreSQL cluster.
- `yc managed-postgresql hosts` — manage PostgreSQL cluster hosts.
    - `list` — [list hosts for the specified PostgreSQL cluster](../../../managed-postgresql/operations/hosts.md#list).
    - `add` — [create new hosts for the cluster in the specified availability zones](../../../managed-postgresql/operations/hosts.md#add).
    - `update` — [update the specified hosts](../../../managed-postgresql/operations/hosts.md#update).
    - `delete` — [delete the specified hosts](../../../managed-postgresql/operations/hosts.md#remove).
    - `update-config` — updates PostgreSQL config for the specified hosts.
- `yc managed-postgresql database` — manage PostgreSQL databases.
    - `get` — show information about the specified PostgreSQL database.
    - `list` — list PostgreSQL databases.
    - `create` — create PostgreSQL database.
    - `update` — update the specified PostgreSQL database.
    - `delete` — delete the specified PostgreSQL database.
- `yc managed-postgresql user` — manage PostgreSQL users.
    - `get` — show information about the specified PostgreSQL user.
    - `list` — [list users for the specified PostgreSQL cluster](../../../managed-postgresql/operations/cluster-users.md#list-users).
    - `create` — [create a PostgreSQL user](../../../managed-postgresql/operations/cluster-users.md#adduser).
    - `update` — [update the specified PostgreSQL user](../../../managed-postgresql/operations/cluster-users.md#updateuser).
    - `delete` — [delete the specified PostgreSQL user](../../../managed-postgresql/operations/cluster-users.md#removeuser).
    - `grant-permission` — grant permission to the specified PostgreSQL user.
    - `revoke-permission` — revoke permission from the specified PostgreSQL user.
- `yc managed-postgresql backup` — manage PostgreSQL [backups](../../../managed-postgresql/concepts/backup.md).
    - `get` — [show information about the specified PostgreSQL backup](../../../managed-postgresql/operations/cluster-backups.md#get-backup)
    - `list` — [list available backups](../../../managed-postgresql/operations/cluster-backups.md#list-backups).
- `yc managed-postgresql resource-preset` — manage PostgreSQL [resource presets](../../../managed-postgresql/concepts/instance-types.md).
    - `get` — show information about the specified PostgreSQL resource preset.
    - `list` — list available PostgreSQL resource presets.
