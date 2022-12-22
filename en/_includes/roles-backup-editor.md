### backup.editor {#backup-editor}

The `backup.editor` role is intended for managing {{ backup-name }} resources. Users with this role can:

* View all resources and their lists, as with the `backup.viewer` role.
* Create, update, and delete [backup policies](../backup/concepts/policy.md).
* Update a list of {{ yandex-cloud }} resources linked to a policy.
* Restore resources from backups.
* Delete backups.
* Connect [backup providers](../backup/concepts/index.md#providers) available in {{ backup-name }}.

In a cloud, this role can be granted by the cloud [administrator](#admin) (the `admin` role), and in a folder, by the cloud administrator or a user with the `backup.admin` folder role.
