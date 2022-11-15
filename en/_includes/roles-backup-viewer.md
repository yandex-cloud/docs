### backup.viewer {#backup-editor}

The `backup.viewer` role is intended for viewing {{ backup-name }} resources. Users with this role can view:

* [Backup policies](../backup/concepts/policy.md), including permissions to access them, and a list of policies.
* Basic information about {{ yandex-cloud }} resources linked to policies (such as VM IDs) and their backup statuses.
* Information about backups.
* A list of connected backup providers.
* Service quotas.

In a cloud, this role can be granted by the cloud [administrator](#admin) (the `admin` role), and in a folder, by the cloud administrator or a user with the `backup.admin` folder role.