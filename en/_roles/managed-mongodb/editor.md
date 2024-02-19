The `managed-mongodb.editor` role allows you to manage MongoDB clusters and view their logs, as well as get information about quotas and service resource operations.

Users with this role can:
* Create, modify, delete, run and stop [MongoDB clusters](../../managed-mongodb/concepts/index.md) and view information about them.
* Create, modify, and delete MongoDB cluster [hosts](../../managed-mongodb/concepts/instance-types.md) and view information about them.
* Create and delete MongoDB cluster [shards](../../managed-mongodb/concepts/sharding.md) and view information about them.
* Create and delete MongoDB databases and view information about them.
* Create, modify, and delete MongoDB [users](../../managed-mongodb/concepts/users-and-roles.md) and view information about them.
* Create MongoDB [backups](../../managed-mongodb/concepts/backup.md) and view information about them.
* Create, modify, and delete MongoDB alerts and view information about them.
* View MongoDB cluster logs.
* View information about the results of MongoDB cluster performance diagnostics.
* View information about [quotas](../../managed-mongodb/concepts/limits.md#mmg-quotas) of Managed Service for MongoDB.
* View information about resource operations for Managed Service for MongoDB.

It includes the permissions of the `managed-mongodb.viewer` role.

To create MongoDB clusters, you also need the `vpc.user` role.