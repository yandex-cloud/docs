The `backup.editor` role allows you to manage the connection of virtual machines to Cloud Backup, manage backup policies, make backups, and restore VMs from existing backups.

Users with this role can:
* View info on connected backup [providers](../../backup/concepts/index.md#providers), as well as connect providers available in Cloud Backup.
* Create, modify, and delete backup policies, as well as link, unlink, and run them on virtual machines.
* View info on [access permissions](../../iam/concepts/access-control/index.md) assigned for backup policies.
* View info on [backup policies](../../backup/concepts/policy.md) and virtual machines linked to them.
* View info on virtual machines [connected](../../backup/concepts/vm-connection.md) to Cloud Backup, as well as connect and disconnect VMs to and from the service.
* View info on [backups](../../backup/concepts/backup.md), as well as delete them and use them to restore VMs.
* View info on Cloud Backup [quotas](../../backup/concepts/limits.md#backup-quotas).
* View information on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) and its statistics.

This role also includes the `backup.viewer` permissions.

To assign the `backup.editor` role, you need either the `admin` role for the cloud or the `backup.admin` one for the folder.