The `backup.viewer` role allows you to view information on virtual machines connected to Cloud Backup, on backup policies and backups, as well as on the relevant cloud, folder, and quotas.

Users with this role can:
* View info on the connected backup [providers](../../backup/concepts/index.md#providers).
* View info on [access bindings](../../iam/concepts/access-control/index.md#access-bindings) for backup policies.
* View info on [backup policies](../../backup/concepts/policy.md) and virtual machines linked to them.
* View info on the virtual machines [connected](../../backup/concepts/vm-connection.md) to the service.
* View info on [backups](../../backup/concepts/backup.md).
* View info on Cloud Backup [quotas](../../backup/concepts/limits.md#backup-quotas).
* View information on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) and its statistics.

To assign the `backup.viewer` role, you need either the `admin` role for the cloud or the `backup.admin` one for the folder.