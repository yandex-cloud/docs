The `managed-redis.editor` role allows you to manage Redis clusters and view their logs, as well as get information on service quotas and resource operations.

Users with this role can:
* View information on Redis [clusters](../../managed-redis/concepts/index.md), as well as create, modify, delete, run, and stop them.
* View information on Redis cluster [hosts](../../managed-redis/concepts/instance-types.md), as well as create, modify, and delete them.
* View information on Redis cluster [shards](../../managed-redis/concepts/sharding.md), as well as create and delete them.
* View information on Redis DB [backups](../../managed-redis/concepts/backup.md) and create those.
* View information on Redis alerts, as well as create, modify, and delete them.
* View Redis cluster logs.
* View information on [quotas](../../managed-redis/concepts/limits.md#mrd-quotas) of Managed Service for Redis.
* View information on resource operations for Managed Service for Redis.

This role also includes the `managed-redis.viewer` permissions.

To create Redis clusters, you also need the `vpc.user` role.