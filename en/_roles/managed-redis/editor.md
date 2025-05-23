The `managed-redis.editor` role allows you to manage Valkey™ clusters and view their logs, as well as get information on service quotas and resource operations.

Users with this role can:
* View information on Valkey™ [clusters](../../managed-redis/concepts/index.md), as well as create, modify, delete, run, and stop them.
* View information on Valkey™ cluster [hosts](../../managed-redis/concepts/instance-types.md), as well as create, modify, and delete them.
* View information on Valkey™ cluster [shards](../../managed-redis/concepts/sharding.md), as well as create and delete them.
* View information on Valkey™ DB [backups](../../managed-redis/concepts/backup.md) and create those.
* View information on Valkey™ alerts, as well as create, modify, and delete them.
* View Valkey™ cluster logs.
* View information on [quotas](../../managed-redis/concepts/limits.md#mrd-quotas) of Yandex Managed Service for Valkey™.
* View information on resource operations for Yandex Managed Service for Valkey™.

This role includes the `managed-redis.viewer` permissions.

To create Valkey™ clusters, you also need the `vpc.user` role.