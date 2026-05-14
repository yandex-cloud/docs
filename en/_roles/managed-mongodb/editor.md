
The `managed-mongodb.editor` role enables managing {{ SD }} clusters.

Users with this role can:
* Create, use, modify, delete, run and stop [{{ SD }} clusters](../../storedoc/concepts/index.md) and view info on them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for {{ SD }} clusters.
* View info on [maintenance](../../storedoc/concepts/maintenance.md) tasks for {{ SD }} clusters and modify such tasks.
* Create, modify, and delete {{ SD }} cluster [hosts](../../storedoc/concepts/instance-types.md) and view info on them.
* Re-assign the master host in {{ SD }} clusters.
* Create and delete {{ SD }} cluster [shards](../../storedoc/concepts/sharding.md) and view info on them.
* Create and delete {{ SD }} databases and view info on them.
* Create, modify, and delete {{ SD }} [users](../../storedoc/concepts/users-and-roles.md) and view info on them.
* Create {{ SD }} cluster [backups](../../storedoc/concepts/backup.md), view info on them, as well as restore clusters from backups.
* Create, modify, and delete {{ SD }} alerts and view info on them.
* View {{ SD }} cluster logs.
* View info on the results of {{ SD }} cluster performance diagnostics.
* View info on {{ mmg-name }} [quotas](../../storedoc/concepts/limits.md#mmg-quotas).
* View info on resource operations for {{ mmg-name }}.

This role includes the `managed-mongodb.viewer`, `managed-mongodb.restorer`, `managed-mongodb.user`, `managed-mongodb.switcher`, and `managed-mongodb.maintenanceTask.editor` permissions.

To create {{ SD }} clusters, you also need the `vpc.user` role.