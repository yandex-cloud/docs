The `backup.admin` role enables managing backup policies and access to them, managing the connection of virtual machines and BareMetal servers to Cloud Backup, making backups, and restoring VMs and BareMetal servers from the existing backups.

Users with this role can:
* View info on the [access permissions](../../iam/concepts/access-control/index.md) granted for the relevant backup policies and modify such permissions.
* View info on connected backup [providers](../../backup/concepts/index.md#providers), as well as connect providers available in Cloud Backup.
* Create, modify, and delete backup policies, as well as link, unlink, and run them on virtual machines and BareMetal servers.
* View info on [backup policies](../../backup/concepts/policy.md) and virtual machines and BareMetal servers linked to them.
* View info on virtual machines and BareMetal servers [connected](../../backup/concepts/vm-connection.md) to Cloud Backup, as well as connect and disconnect VMs and BareMetal servers to and from it.
* View info on [backups](../../backup/concepts/backup.md), as well as delete them and use them to restore VMs and BareMetal servers.
* View info on Cloud Backup [quotas](../../backup/concepts/limits.md#backup-quotas).
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) and its statistics.

This role includes the `backup.editor` permissions.

To assign the `backup.admin` role, you need the `admin` role for the cloud.