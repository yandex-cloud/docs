
The `backup.user` role enables connecting backup providers, connecting target resources to {{ backup-name }}, linking backup policies to target resources and unlinking them, as well as viewing info on {{ backup-name }} resources and quotas and on the relevant cloud and folder.

Users with this role can:
* View info on connected backup [providers](../../backup/concepts/index.md#providers), as well as connect providers available in {{ backup-name }}.
* View info on resources [connected](../../backup/concepts/vm-connection/index.md) to {{ backup-name }}, as well as connect and disconnect resources to and from it.
* View info on [backup policies](../../backup/concepts/policy.md) as well as on resources linked to such policies.
* Link backup policies to target resources and unlink them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for backup policies.
* View info on {{ backup-name }} [quotas](../../backup/concepts/limits.md#backup-quotas).
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) and its statistics.

This role includes the `backup.auditor` permissions.

To assign the `backup.user` role, you need the `admin` role for the cloud or `backup.admin` for the folder.