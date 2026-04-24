
The `backup.viewer` role enables viewing information on virtual machines and {{ baremetal-name }} servers connected to {{ backup-name }}, on backup policies and backups, as well as on the relevant cloud, folder, and quotas.

Users with this role can:
* View info on the connected backup [providers](../../backup/concepts/index.md#providers).
* View info on the [access permissions](../../iam/concepts/access-control/index.md) granted for the relevant backup policies.
* View info on [backup policies](../../backup/concepts/policy.md) and virtual machines and {{ baremetal-name }} servers linked to them.
* View info on the virtual machines and {{ baremetal-name }} servers [connected](../../backup/concepts/vm-connection.md) to {{ backup-name }}.
* View info on [backups](../../backup/concepts/backup.md).
* View info on {{ backup-name }} [quotas](../../backup/concepts/limits.md#backup-quotas).
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) and its statistics.

This role includes the `backup.auditor` permissions.

To assign the `backup.viewer` role, you need the `admin` role for the cloud or `backup.admin` for the folder.