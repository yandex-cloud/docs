
The `managed-redis.switcher` enables re-assigning the master host in {{ VLK }} clusters and viewing info on {{ VLK }} hosts, clusters and their logs, as well as on quotas and resource operations.

Users with this role can:
* Re-assign the master host in {{ VLK }} [clusters](../../managed-valkey/concepts/index.md).
* View info on {{ VLK }} clusters and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [maintenance](../../managed-valkey/concepts/maintenance.md) tasks for {{ VLK }} clusters.
* View info on {{ VLK }} cluster [hosts](../../managed-valkey/concepts/instance-types.md).
* View info on {{ VLK }} cluster [shards](../../managed-valkey/concepts/sharding.md).
* View [info](../../managed-valkey/operations/user-list.md) on {{ VLK }} users.
* View info on {{ VLK }} cluster [backups](../../managed-valkey/concepts/backup.md).
* View info on {{ VLK }} alerts.
* View {{ VLK }} cluster logs.
* View info on [quotas](../../managed-valkey/concepts/limits.md#mrd-quotas) for {{ mrd-full-name }}.
* View info on resource operations for {{ mrd-full-name }}.

This role includes the `managed-redis.viewer` permissions.