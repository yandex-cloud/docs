The `managed-spqr.editor` role enables managing {{ SPQR }} clusters.

Users with this role can:
* View info on {{ SPQR }} [clusters](../../iam/concepts/access-control/index.md) and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* Create, modify, delete, run, and stop {{ SPQR }} clusters.
* View info on maintenance tasks for {{ SPQR }} clusters and modify such tasks.
* View info on {{ SPQR }} cluster [hosts](../../managed-spqr/concepts/instance-types.md), as well as create, modify, and delete them.
* View info on databases in {{ SPQR }} clusters as well as create, modify, and delete such databases.
* View info on users in {{ SPQR }} clusters as well as create, modify, and delete such users.
* View info on {{ SPQR }} cluster backups, create and delete such backups, as well as restore clusters from backups.
* View {{ SPQR }} cluster logs.
* View info on [quotas](../../managed-spqr/concepts/limits.md#mspqr-quotas) for {{ mspqr-name }}.
* View info on resource operations for {{ mspqr-name }}.

This role includes the `managed-spqr.viewer`, `managed-spqr.restorer` , and `managed-spqr.maintenanceTask.editor` permissions.
