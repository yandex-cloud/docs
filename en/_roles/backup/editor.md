
The `backup.editor` role enables managing the connection of virtual machines and {{ baremetal-name }} servers to {{ backup-name }}, managing backup policies, making backups, and restoring VMs and {{ baremetal-name }} servers from the existing backups.

Users with this role can:
* View info on connected backup [providers](../../backup/concepts/index.md#providers), as well as connect providers available in {{ backup-name }}.
* View info on [backup policies](../../backup/concepts/policy.md) as well as on virtual machines and {{ baremetal-name }} servers linked to such policies.
* Create, modify, and delete backup policies, as well as link, unlink, and run them on virtual machines and {{ baremetal-name }} servers.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for backup policies.
* View info on virtual machines and {{ baremetal-name }} servers [connected](../../backup/concepts/vm-connection.md) to {{ backup-name }}, as well as connect and disconnect VMs and {{ baremetal-name }} servers to and from it.
* View info on [backups](../../backup/concepts/backup.md), as well as delete them and use them to restore VMs and {{ baremetal-name }} servers.
* View info on {{ backup-name }} [quotas](../../backup/concepts/limits.md#backup-quotas).
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) and its statistics.

This role includes the `backup.viewer` and `backup.user` permissions.

To assign the `backup.editor` role, you need the `admin` role for the cloud or `backup.admin` for the folder.