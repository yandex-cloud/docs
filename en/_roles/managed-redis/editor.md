The `managed-redis.editor` role enables managing Valkey™ clusters.

Users with this role can:
* View info on Valkey™ [clusters](../../managed-valkey/concepts/index.md), as well as create, use, modify, delete, run, and stop them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for Valkey™ clusters.
* View info on [maintenance](../../managed-valkey/concepts/maintenance.md) tasks for Valkey™ clusters and modify such tasks.
* View info on Valkey™ cluster [hosts](../../managed-valkey/concepts/instance-types.md), as well as create, modify, and delete them.
* Re-assign the master host in Valkey™ clusters.
* View info on Valkey™ cluster [shards](../../managed-valkey/concepts/sharding.md), as well as create and delete them.
* View [info](../../managed-valkey/operations/user-list.md) on Valkey™ users, as well as create, modify, and delete them.
* View info on Valkey™ cluster [backups](../../managed-valkey/concepts/backup.md), create cluster backups, and restore clusters from backups.
* View info on Valkey™ alerts, as well as create, modify, and delete them.
* View Valkey™ cluster logs.
* View info on [quotas](../../managed-valkey/concepts/limits.md#mrd-quotas) for Yandex Managed Service for Valkey™.
* View info on resource operations for Yandex Managed Service for Valkey™.

This role includes the `managed-redis.viewer`, `managed-redis.restorer`, `managed-redis.user`, `managed-redis.switcher`, and `managed-redis.maintenanceTask.editor` permissions.

To create Valkey™ clusters, you also need the `vpc.user` role.