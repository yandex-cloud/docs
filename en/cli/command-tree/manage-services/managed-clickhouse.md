# yc managed-clickhouse

Managing {{ CH }}.

#### Command usage

Syntax:

`yc managed-clickhouse <group>`

Aliases:

- `yc clickhouse <group>`.

#### Groups

- `yc managed-clickhouse cluster`: Manage {{ CH }} clusters.
   - `get`: [Get information about the specified {{ CH }} cluster](../../../managed-clickhouse/operations/cluster-list.md#get-cluster).
   - `list`: [Get a list of {{ CH }} clusters](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).
   - `create`: [Create a {{ CH }} cluster](../../../managed-clickhouse/operations/cluster-create.md).
   - `restore`: [Restore a {{ CH }} cluster](../../../managed-clickhouse/operations/cluster-backups.md#restore).
   - `update`: [Update the specified {{ CH }} cluster](../../../managed-clickhouse/operations/update.md).
   - `update-config`: Update the configuration of the specified {{ CH }} cluster.
   - `delete`: [Delete the specified {{ CH }} cluster](../../../managed-clickhouse/operations/cluster-delete.md).
   - `backup`: [Create a backup of the specified {{ CH }} cluster](../../../managed-clickhouse/operations/cluster-backups.md#create-backup).
   - `list-backups`: Get a list of backups available for the specified {{ CH }} cluster.
   - `list-logs`: Get a list of logs for the specified {{ CH }} cluster.
   - `list-operations`: Get a list of operations for the specified {{ CH }} cluster.
   - `clear-compression`: Reset the compression parameters for the specified {{ CH }} cluster.
   - `set-compression`: Set compression parameters for the specified {{ CH }} cluster.
   - `add-external-dictionary`: Add an external dictionary to the specified {{ CH }} cluster.
   - `remove-external-dictionary`: Remove an external dictionary from the specified {{ CH }} cluster.
   - `add-graphite-rollup`: Apply graphite rollup configuration to the specified {{ CH }} cluster.
   - `remove-graphite-rollup`: Remove graphite rollup configuration from the specified {{ CH }} cluster.
- `yc managed-clickhouse hosts`: Manage {{ CH }} cluster hosts.
   - `list`: [Get a list of hosts for the specified {{ CH }} cluster](../../../managed-clickhouse/operations/hosts.md#list-hosts).
   - `add`: [Add a new host for a cluster in the specified availability zone](../../../managed-clickhouse/operations/hosts.md#add-host).
   - `delete`: [Delete the specified host](../../../managed-clickhouse/operations/hosts.md#remove-host).
- `yc managed-clickhouse database`: Manage {{ CH }} databases.
   - `get`: Get information about the specified {{ CH }} database.
   - `list`: Get a list of {{ CH }} databases.
   - `create`: Create a {{ CH }} database.
   - `delete`: Delete the specified {{ CH }} database.
- `yc managed-clickhouse user`: Manage {{ CH }} users.
   - `get`: Get information about the specified {{ CH }} user.
   - `list`: [Get a list of users for the specified {{ CH }} cluster](../../../managed-clickhouse/operations/cluster-users.md#list-users).
   - `create`: [Create a {{ CH }} user](../../../managed-clickhouse/operations/cluster-users.md#adduser).
   - `update`: [Update the specified {{ CH }} user](../../../managed-clickhouse/operations/cluster-users.md#updateuser).
   - `delete`: [Delete the specified {{ CH }} user](../../../managed-clickhouse/operations/cluster-users.md#removeuser).
   - `grant-permission`: Grant permissions to the specified {{ CH }} user.
   - `revoke-permission`: Revoke permissions from the specified {{ CH }} user.
- `yc managed-clickhouse backup`: Manage [{{ CH }} backups](../../../managed-clickhouse/concepts/backup.md).
   - `get`: [Get information about the specified {{ CH }} backup](../../../managed-clickhouse/operations/cluster-backups.md#get-backup).
   - `list`: [Get a list of available {{ CH }} backups](../../../managed-clickhouse/operations/cluster-backups.md#list-backups).
- `yc managed-clickhouse resource-preset`: Manage [{{ CH }} host classes](../../../managed-clickhouse/concepts/instance-types.md).
   - `get`: Get information about the specified {{ CH }} host classes.
   - `list`: Get information about the available {{ CH }} host classes.
