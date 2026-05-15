The `managed-spqr.viewer` role enables viewing info on {{ SPQR }} clusters, hosts, databases, and users, cluster logs, and info on quotas and resource operations.

Users with this role can:
* View info on {{ SPQR }} [clusters](../../managed-spqr/concepts/index.md) and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on maintenance tasks for {{ SPQR }} clusters.
* View info on {{ SPQR }} cluster [hosts](../../managed-spqr/concepts/instance-types.md).
* View info on databases in {{ SPQR }} clusters.
* View info on users in {{ SPQR }} clusters.
* View info on {{ SPQR }} cluster backups.
* View {{ SPQR }} cluster logs.
* View info on [quotas](../../managed-spqr/concepts/limits.md#mspqr-quotas) for {{ mspqr-name }}.
* View info on resource operations for {{ mspqr-name }}.

This role includes the `managed-spqr.auditor` and `managed-spqr.maintenanceTask.viewer` permissions.
