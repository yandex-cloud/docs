# yc managed-mongodb

Manage [!KEYREF MG].

#### Usage

Syntax:

`yc managed-mongodb <group>`

Aliases: 

- `yc mongodb <group>`;
- `yc mongo <group>`.

#### Groups

- `yc managed-mongodb cluster` — manage [!KEYREF MG] clusters.
    - `get` — [show information about the specified [!KEYREF MG] cluster](../../../managed-mongodb/operations/cluster-list.md#get-cluster).
    - `list` — [list [!KEYREF MG] clusters](../../../managed-mongodb/operations/cluster-list.md#list-clusters).
    - `create` — [create [!KEYREF MG] cluster](../../../managed-mongodb/operations/cluster-create.md).
    - `restore` — [restore [!KEYREF MG] cluster](../../../managed-mongodb/operations/cluster-backups.md#restore).
    - `update` — [update the specified [!KEYREF MG] cluster](../../../managed-mongodb/operations/update.md).
    - `update-config` — update the specified [!KEYREF MG] cluster config.
    - `delete` — [delete the specified [!KEYREF MG] cluster](../../../managed-mongodb/operations/cluster-delete.md).
    - `backup` — [create a backup for the specified [!KEYREF MG] cluster](../../../managed-mongodb/operations/cluster-backups.md#create-backup).
    - `list-backups` — list available backups for the specified [!KEYREF MG] cluster.
    - `list-logs` — retrieves logs for the specified [!KEYREF MG] cluster.
    - `list-operations` — list operations for the specified [!KEYREF MG] cluster.
- `yc managed-mongodb hosts` — manage [!KEYREF MG] cluster hosts.
    - `list` — [list hosts for the specified [!KEYREF MG] cluster](../../../managed-mongodb/operations/hosts.md#list-hosts).
    - `add` — [create new hosts for the cluster in the specified availability zones](../../../managed-mongodb/operations/hosts.md#add-host).
    - `delete` — [delete the specified hosts](../../../managed-mongodb/operations/hosts.md#remove-host).
- `yc managed-mongodb database` — manage [!KEYREF MG] databases.
    - `get` — show information about the specified [!KEYREF MG] database.
    - `list` — list [!KEYREF MG] databases.
    - `create` — create [!KEYREF MG] database.
    - `delete` — delete the specified [!KEYREF MG] database.
- `yc managed-mongodb user` — manage [!KEYREF MG] users.
    - `get` — show information about the specified [!KEYREF MG] user.
    - `list` — [list users for the specified [!KEYREF MG] cluster](../../../managed-mongodb/operations/cluster-users.md#list-users).
    - `create` — [create a [!KEYREF MG] user](../../../managed-mongodb/operations/cluster-users.md#adduser).
    - `update` — [update the specified [!KEYREF MG] user](../../../managed-mongodb/operations/cluster-users.md#updateuser).
    - `delete` — [delete the specified [!KEYREF MG] user](../../../managed-mongodb/operations/cluster-users.md#removeuser).
    - `grant-permission` — grant permission to the specified [!KEYREF MG] user.
    - `revoke-permission` — revoke permission from the specified [!KEYREF MG] user.
- `yc managed-mongodb backup` — manage [!KEYREF MG] [backups](../../../managed-mongodb/concepts/backup.md).
    - `get` — [show information about the specified [!KEYREF MG] backup](../../../managed-mongodb/operations/cluster-backups.md#get-backup).
    - `list` — [list available backups](../../../managed-mongodb/operations/cluster-backups.md#list-backups).
- `yc managed-mongodb resource-preset` — manage [!KEYREF MG] [resource presets](../../../managed-mongodb/concepts/instance-types.md).
    - `get` — show information about the specified [!KEYREF MG] resource preset.
    - `list` — list available [!KEYREF MG] resource presets.
