The `managed-mongodb.admin` role enables managing Yandex StoreDoc clusters and access to them.

Users with this role can:
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for [Yandex StoreDoc clusters](../../storedoc/concepts/index.md) and modify such permissions.
* Create, use, modify, delete, run and stop Yandex StoreDoc clusters and view info on them.
* View info on [maintenance](../../storedoc/concepts/maintenance.md) tasks for Yandex StoreDoc clusters and modify such tasks.
* Create, modify, and delete Yandex StoreDoc cluster [hosts](../../storedoc/concepts/instance-types.md) and view info on them.
* Re-assign the master host in Yandex StoreDoc clusters.
* Create and delete Yandex StoreDoc cluster [shards](../../storedoc/concepts/sharding.md) and view info on them.
* Create and delete Yandex StoreDoc databases and view info on them.
* Create, modify, and delete Yandex StoreDoc [users](../../storedoc/concepts/users-and-roles.md) and view info on them.
* Create Yandex StoreDoc cluster [backups](../../storedoc/concepts/backup.md), view info on them, as well as restore clusters from backups.
* Create, modify, and delete Yandex StoreDoc alerts and view info on them.
* View Yandex StoreDoc cluster logs.
* View info on the results of Yandex StoreDoc cluster performance diagnostics.
* View info on Yandex StoreDoc [quotas](../../storedoc/concepts/limits.md#mmg-quotas).
* View info on resource operations for Yandex StoreDoc.

This role includes the `managed-mongodb.editor` permissions.

To create Yandex StoreDoc clusters, you also need the `vpc.user` role.