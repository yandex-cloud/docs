
The `managed-redis.editor` role enables managing {{ VLK }} clusters.

Users with this role can:
* View info on {{ VLK }} [clusters](../../managed-valkey/concepts/index.md), as well as create, use, modify, delete, run, and stop them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for {{ VLK }} clusters.
* View info on [maintenance](../../managed-valkey/concepts/maintenance.md) tasks for {{ VLK }} clusters and modify such tasks.
* View info on {{ VLK }} cluster [hosts](../../managed-valkey/concepts/instance-types.md), as well as create, modify, and delete them.
* Re-assign the master host in {{ VLK }} clusters.
* View info on {{ VLK }} cluster [shards](../../managed-valkey/concepts/sharding.md), as well as create and delete them.
* View [info](../../managed-valkey/operations/user-list.md) on {{ VLK }} users, as well as create, modify, and delete them.
* View info on {{ VLK }} cluster [backups](../../managed-valkey/concepts/backup.md), create cluster backups, and restore clusters from backups.
* View info on {{ VLK }} alerts, as well as create, modify, and delete them.
* View {{ VLK }} cluster logs.
* View info on [quotas](../../managed-valkey/concepts/limits.md#mrd-quotas) for {{ mrd-full-name }}.
* View info on resource operations for {{ mrd-full-name }}.

This role includes the `managed-redis.viewer`, `managed-redis.restorer`, `managed-redis.user`, `managed-redis.switcher`, and `managed-redis.maintenanceTask.editor` permissions.

To create {{ VLK }} clusters, you also need the `vpc.user` role.