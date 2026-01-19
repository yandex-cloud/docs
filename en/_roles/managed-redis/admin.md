The `managed-redis.admin` role allows you to manage Valkey™ clusters and view their logs, as well as get information on quotas and resource operations.

Users with this role can:
* Manage access to Valkey™ [clusters](../../managed-valkey/concepts/index.md).
* View information on Valkey™ clusters, as well as create, modify, delete, run, and stop them.
* View information on Valkey™ cluster [hosts](../../managed-valkey/concepts/instance-types.md), as well as create, modify, and delete them.
* View information on Valkey™ cluster [shards](../../managed-valkey/concepts/sharding.md), as well as create and delete them.
* View information on Valkey™ cluster [backups](../../managed-valkey/concepts/backup.md), create cluster backups, and restore clusters from backups.
* View information on Valkey™ alerts, as well as create, modify, and delete them.
* View Valkey™ cluster logs.
* View information on [quotas](../../managed-valkey/concepts/limits.md#mrd-quotas) of {{ mrd-full-name }}.
* View information on resource operations for {{ mrd-full-name }}.

This role includes the `managed-redis.editor` permissions.

To create Valkey™ clusters, you also need the `vpc.user` role.