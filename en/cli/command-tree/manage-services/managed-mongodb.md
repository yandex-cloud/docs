# yc managed-mongodb

Managing {{ MG }}.

#### Command usage

Syntax:

`yc managed-mongodb <group>`

Aliases:

- `yc mongodb <group>`;
- `yc mongo <group>`.

#### Groups

- `yc managed-mongodb cluster`: Manage {{ MG }} clusters.
   - `get`: [Get information about the specified {{ MG }} cluster](../../../managed-mongodb/operations/cluster-list.md#get-cluster).
   - `list`: [Get a list of {{ MG }} clusters](../../../managed-mongodb/operations/cluster-list.md#list-clusters).
   - `create`: [Create a {{ MG }} cluster](../../../managed-mongodb/operations/cluster-create.md).
   - `restore`: [Restore a {{ MG }} cluster](../../../managed-mongodb/operations/cluster-backups.md#restore).
   - `update`: [Update the specified {{ MG }} cluster](../../../managed-mongodb/operations/update.md).
   - `update-config`: Update the configuration of the specified {{ MG }} cluster.
   - `delete`: [Delete the specified {{ MG }} cluster](../../../managed-mongodb/operations/cluster-delete.md).
   - `backup`: [Create a backup of the specified {{ MG }} cluster](../../../managed-mongodb/operations/cluster-backups.md#create-backup).
   - `list-backups`: Get a list of backups available for the specified {{ MG }} cluster.
   - `list-logs`: Get a list of logs for the specified {{ MG }} cluster.
   - `list-operations`: Get a list of operations for the specified {{ MG }} cluster.
- `yc managed-mongodb hosts`: Manage {{ MG }} cluster hosts.
   - `list`: [Get a list of hosts for the specified {{ MG }} cluster](../../../managed-mongodb/operations/hosts.md#list-hosts).
   - `add`: [Add a new host for a cluster in the specified availability zone](../../../managed-mongodb/operations/hosts.md#add-host).
   - `delete`: [Delete the specified host](../../../managed-mongodb/operations/hosts.md#remove-host).
- `yc managed-mongodb database`: Manage {{ MG }} databases.
   - `get`: Get information about the specified {{ MG }} database.
   - `list`: Get a list of {{ MG }} databases.
   - `create`: Create a {{ MG }} database.
   - `delete`: Delete the specified {{ MG }} database.
- `yc managed-mongodb user`: Manage {{ MG }} users.
   - `get`: Get information about the specified {{ MG }} user.
   - `list`: [Get a list of users for the specified {{ MG }} cluster](../../../managed-mongodb/operations/cluster-users.md#list-users).
   - `create`: [Create a {{ MG }} user](../../../managed-mongodb/operations/cluster-users.md#adduser).
   - `update`: [Update the specified {{ MG }} user](../../../managed-mongodb/operations/cluster-users.md#updateuser).
   - `delete`: [Delete the specified {{ MG }} user](../../../managed-mongodb/operations/cluster-users.md#removeuser).
   - `grant-permission`: Grant permissions to the specified {{ MG }} user.
   - `revoke-permission`: Revoke permissions from the specified {{ MG }} user.
- `yc managed-mongodb backup`: Manage [{{ MG }} backups](../../../managed-mongodb/concepts/backup.md).
   - `get`: [Get information about the specified {{ MG }} backup](../../../managed-mongodb/operations/cluster-backups.md#get-backup).
   - `list`: [Get a list of available {{ MG }} backups](../../../managed-mongodb/operations/cluster-backups.md#list-backups).
- `yc managed-mongodb resource-preset`: Manage [{{ MG }} host classes](../../../managed-mongodb/concepts/instance-types.md).
   - `get`: Get information about the specified {{ MG }} host classes.
   - `list`: Get information about the available {{ MG }} host classes.
