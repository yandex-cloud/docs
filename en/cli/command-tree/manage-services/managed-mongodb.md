# yc managed-mongodb

Manage MongoDB.

#### Usage

Syntax:

`yc managed-mongodb <group>`

Aliases:

- `yc mongodb <group>`;
- `yc mongo <group>`.

#### Groups

- `yc managed-mongodb cluster` — manage MongoDB clusters.
    - `get` — [show information about the specified MongoDB cluster](../../../managed-mongodb/operations/cluster-list.md#get-cluster).
    - `list` — [list MongoDB clusters](../../../managed-mongodb/operations/cluster-list.md#list-clusters).
    - `create` — [create MongoDB cluster](../../../managed-mongodb/operations/cluster-create.md).
    - `restore` — [restore MongoDB cluster](../../../managed-mongodb/operations/cluster-backups.md#restore).
    - `update` — [update the specified MongoDB cluster](../../../managed-mongodb/operations/update.md).
    - `update-config` — update the specified MongoDB cluster config.
    - `delete` — [delete the specified MongoDB cluster](../../../managed-mongodb/operations/cluster-delete.md).
    - `backup` — [create a backup for the specified MongoDB cluster](../../../managed-mongodb/operations/cluster-backups.md#create-backup).
    - `list-backups` — list available backups for the specified MongoDB cluster.
    - `list-logs` — retrieves logs for the specified MongoDB cluster.
    - `list-operations` — list operations for the specified MongoDB cluster.
- `yc managed-mongodb hosts` — manage MongoDB cluster hosts.
    - `list` — [list hosts for the specified MongoDB cluster](../../../managed-mongodb/operations/hosts.md#list-hosts).
    - `add` — [create new hosts for the cluster in the specified availability zones](../../../managed-mongodb/operations/hosts.md#add-host).
    - `delete` — [delete the specified hosts](../../../managed-mongodb/operations/hosts.md#remove-host).
- `yc managed-mongodb database` — manage MongoDB databases.
    - `get` — show information about the specified MongoDB database.
    - `list` — list MongoDB databases.
    - `create` — create MongoDB database.
    - `delete` — delete the specified MongoDB database.
- `yc managed-mongodb user` — manage MongoDB users.
    - `get` — show information about the specified MongoDB user.
    - `list` — [list users for the specified MongoDB cluster](../../../managed-mongodb/operations/cluster-users.md#list-users).
    - `create` — [create a MongoDB user](../../../managed-mongodb/operations/cluster-users.md#adduser).
    - `update` — [update the specified MongoDB user](../../../managed-mongodb/operations/cluster-users.md#updateuser).
    - `delete` — [delete the specified MongoDB user](../../../managed-mongodb/operations/cluster-users.md#removeuser).
    - `grant-permission` — grant permission to the specified MongoDB user.
    - `revoke-permission` — revoke permission from the specified MongoDB user.
- `yc managed-mongodb backup` — manage MongoDB [backups](../../../managed-mongodb/concepts/backup.md).
    - `get` — [show information about the specified MongoDB backup](../../../managed-mongodb/operations/cluster-backups.md#get-backup).
    - `list` — [list available backups](../../../managed-mongodb/operations/cluster-backups.md#list-backups).
- `yc managed-mongodb resource-preset` — manage MongoDB [resource presets](../../../managed-mongodb/concepts/instance-types.md).
    - `get` — show information about the specified MongoDB resource preset.
    - `list` — list available MongoDB resource presets.
