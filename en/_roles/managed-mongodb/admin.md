The `managed-mongodb.admin` role allows you to manage Yandex StoreDoc clusters and view their logs, as well as get information about quotas and service resource operations.

Users with this role can:
* Manage access to Yandex StoreDoc clusters.
* Create, modify, delete, run and stop [Yandex StoreDoc clusters](../../storedoc/concepts/index.md) and view information about them.
* Create, modify, and delete Yandex StoreDoc cluster [hosts](../../storedoc/concepts/instance-types.md) and view information about them.
* Create and delete Yandex StoreDoc cluster [shards](../../storedoc/concepts/sharding.md) and view information about them.
* Create and delete Yandex StoreDoc databases and view information about them.
* Create, modify, and delete Yandex StoreDoc [users](../../storedoc/concepts/users-and-roles.md) and view information about them.
* Create Yandex StoreDoc [backups](../../storedoc/concepts/backup.md) and view information about them.
* Create, modify, and delete Yandex StoreDoc alerts and view information about them.
* View Yandex StoreDoc cluster logs.
* View information about the results of Yandex StoreDoc cluster performance diagnostics.
* View information about [quotas](../../storedoc/concepts/limits.md#mmg-quotas) of Yandex StoreDoc.
* View information about resource operations for Yandex StoreDoc.

This role includes the `managed-mongodb.editor` permissions.

To create Yandex StoreDoc clusters, you also need the `vpc.user` role.