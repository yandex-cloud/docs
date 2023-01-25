# yc managed-postgresql

Managing {{ PG }}.

#### Command usage

Syntax:

`yc managed-postgresql <group>`

Aliases:

- `yc postgresql <group>`;
- `yc postgres <group>`.

#### Groups

- `yc managed-postgresql cluster`: Manage {{ PG }} clusters.
   - `get`: [Get information about the specified {{ PG }} cluster](../../../managed-postgresql/operations/cluster-list.md#get-cluster).
   - `list`: [Get a list of {{ PG }} clusters](../../../managed-postgresql/operations/cluster-list.md#list-clusters).
   - `create`: [Create a {{ PG }} cluster](../../../managed-postgresql/operations/cluster-create.md).
   - `restore`: [Restore a {{ PG }} cluster](../../../managed-postgresql/operations/cluster-backups.md#restore).
   - `update`: [Update the specified {{ PG }} cluster](../../../managed-postgresql/operations/update.md).
   - `update-config`: Update the configuration of the specified {{ PG }} cluster.
   - `delete`: [Delete the specified {{ PG }} cluster](../../../managed-postgresql/operations/cluster-delete.md).
   - `backup`: [Create a backup of the specified {{ PG }} cluster](../../../managed-postgresql/operations/cluster-backups.md#create-backup).
   - `list-backups`: Get a list of backups available for the specified {{ PG }} cluster.
   - `list-logs`: Get a list of logs for the specified {{ PG }} cluster.
   - `list-operations`: Get a list of operations for the specified {{ PG }} cluster.
- `yc managed-postgresql hosts`: Manage {{ PG }} cluster hosts.
   - `list`: [Get a list of hosts for the specified {{ PG }} cluster](../../../managed-postgresql/operations/hosts.md#list).
   - `add`: [Add a new host for a cluster in the specified availability zone](../../../managed-postgresql/operations/hosts.md#add).
   - `update`: [Update the specified host](../../../managed-postgresql/operations/hosts.md#update).
   - `delete`: [Delete the specified host](../../../managed-postgresql/operations/hosts.md#remove).
   - `update-config`: Update the configuration of the specified {{ PG }} hosts.
- `yc managed-postgresql database`: Manage {{ PG }} databases.
   - `get`: Get information about the specified {{ PG }} database.
   - `list`: Get a list of {{ PG }} databases.
   - `create`: Create a {{ PG }} database.
   - `update`: Update the specified {{ PG }} database.
   - `delete`: Delete the specified {{ PG }} database.
- `yc managed-postgresql user`: Manage {{ PG }} users.
   - `get`: Get information about the specified {{ PG }} user.
   - `list`: [Get a list of users for the specified {{ PG }} cluster](../../../managed-postgresql/operations/cluster-users.md#list-users).
   - `create`: [Create a {{ PG }} user](../../../managed-postgresql/operations/cluster-users.md#adduser).
   - `update`: [Update the specified {{ PG }} user](../../../managed-postgresql/operations/cluster-users.md#updateuser).
   - `delete`: [Delete the specified {{ PG }} user](../../../managed-postgresql/operations/cluster-users.md#removeuser).
   - `grant-permission`: Grant permissions to the specified {{ PG }} user.
   - `revoke-permission`: Revoke permissions from the specified {{ PG }} user.
- `yc managed-postgresql backup`: Manage [{{ PG }} backups](../../../managed-postgresql/concepts/backup.md).
   - `get`: [Get information about the specified {{ PG }} backup](../../../managed-postgresql/operations/cluster-backups.md#get-backup).
   - `list`: [Get a list of available {{ PG }} backups](../../../managed-postgresql/operations/cluster-backups.md#list-backups).
- `yc managed-postgresql resource-preset`: Manage [{{ PG }} host classes](../../../managed-postgresql/concepts/instance-types.md).
   - `get`: Get information about the specified {{ PG }} host classes.
   - `list`: Get information about the available {{ PG }} host classes.
