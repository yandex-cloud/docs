# yc managed-mongodb

Manage {{ MG }}.

#### Usage

Syntax:

`yc managed-mongodb <group>`

Aliases:

- `yc mongodb <group>`;
- `yc mongo <group>`.

#### Groups

- `yc managed-mongodb cluster` — manage {{ MG }} clusters.
    - `get` — [show information about the specified {{ MG }} cluster](../../../managed-mongodb/operations/cluster-list.md#get-cluster).
    - `list` — [list {{ MG }} clusters](../../../managed-mongodb/operations/cluster-list.md#list-clusters).
    - `create` — [create {{ MG }} cluster](../../../managed-mongodb/operations/cluster-create.md).
    - `restore` — [restore {{ MG }} cluster](../../../managed-mongodb/operations/cluster-backups.md#restore).
    - `update` — [update the specified {{ MG }} cluster](../../../managed-mongodb/operations/update.md).
    - `update-config` — update the specified {{ MG }} cluster config.
    - `delete` — [delete the specified {{ MG }} cluster](../../../managed-mongodb/operations/cluster-delete.md).
    - `backup` — [create a backup for the specified {{ MG }} cluster](../../../managed-mongodb/operations/cluster-backups.md#create-backup).
    - `list-backups` — list available backups for the specified {{ MG }} cluster.
    - `list-logs` — retrieves logs for the specified {{ MG }} cluster.
    - `list-operations` — list operations for the specified {{ MG }} cluster.
- `yc managed-mongodb hosts` — manage {{ MG }} cluster hosts.
    - `list` — [list hosts for the specified {{ MG }} cluster](../../../managed-mongodb/operations/hosts.md#list-hosts).
    - `add` — [create new hosts for the cluster in the specified availability zones](../../../managed-mongodb/operations/hosts.md#add-host).
    - `delete` — [delete the specified hosts](../../../managed-mongodb/operations/hosts.md#remove-host).
- `yc managed-mongodb database` — manage {{ MG }} databases.
    - `get` — show information about the specified {{ MG }} database.
    - `list` — list {{ MG }} databases.
    - `create` — create {{ MG }} database.
    - `delete` — delete the specified {{ MG }} database.
- `yc managed-mongodb user` — manage {{ MG }} users.
    - `get` — show information about the specified {{ MG }} user.
    - `list` — [list users for the specified {{ MG }} cluster](../../../managed-mongodb/operations/cluster-users.md#list-users).
    - `create` — [create a {{ MG }} user](../../../managed-mongodb/operations/cluster-users.md#adduser).
    - `update` — [update the specified {{ MG }} user](../../../managed-mongodb/operations/cluster-users.md#updateuser).
    - `delete` — [delete the specified {{ MG }} user](../../../managed-mongodb/operations/cluster-users.md#removeuser).
    - `grant-permission` — grant permission to the specified {{ MG }} user.
    - `revoke-permission` — revoke permission from the specified {{ MG }} user.
- `yc managed-mongodb backup` — manage {{ MG }} [backups](../../../managed-mongodb/concepts/backup.md).
    - `get` — [show information about the specified {{ MG }} backup](../../../managed-mongodb/operations/cluster-backups.md#get-backup).
    - `list` — [list available backups](../../../managed-mongodb/operations/cluster-backups.md#list-backups).
- `yc managed-mongodb resource-preset` — manage {{ MG }} [resource presets](../../../managed-mongodb/concepts/instance-types.md).
    - `get` — show information about the specified {{ MG }} resource preset.
    - `list` — list available {{ MG }} resource presets.
