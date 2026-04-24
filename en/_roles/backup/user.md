
The `backup.user` role enables connecting backup providers, connecting VMs and {{ baremetal-name }} servers to {{ backup-name }}, linking backup policies to VMs and {{ baremetal-name }} servers and unlinking them, as well as viewing info on {{ backup-name }} resources and quotas and on the relevant cloud and folder.

Users with this role can:
* View info on connected backup [providers](../../backup/concepts/index.md#providers), as well as connect providers available in {{ backup-name }}.
* View info on virtual machines and {{ baremetal-name }} servers [connected](../../backup/concepts/vm-connection.md) to {{ backup-name }}, as well as connect VMs and {{ baremetal-name }} servers to it.
* View info on [backup policies](../../backup/concepts/policy.md) as well as on virtual machines and {{ baremetal-name }} servers linked to such policies.
* Link backup policies to VMs and {{ baremetal-name }} servers and unlink them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for backup policies.
* View info on {{ backup-name }} [quotas](../../backup/concepts/limits.md#backup-quotas).
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) and its statistics.

This role includes the `backup.auditor` permissions.

To assign the `backup.user` role, you need the `admin` role for the cloud or `backup.admin` for the folder.