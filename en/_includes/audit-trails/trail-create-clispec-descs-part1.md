* `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create a trail in.

* `name`: Name of the trail being created. The name format requirements are as follows:

   {% include [name-format](../name-format.md) %}

* `description`: Description of the trail to distinguish it from other trails, e.g., `My very first trail`. This is an optional parameter.
* `labels`: List of labels in `key=value` format. This is an optional parameter.
* `service_account_id`: [ID](../../iam/operations/sa/get-id.md) of the service account that the trail will use to upload audit log files to the bucket.

   Based on the audit log [collection scope](../../audit-trails/concepts/trail.md#collecting-area), the [service account](../../iam/concepts/users/service-accounts.md) must have the [audit-trails.viewer](../../iam/concepts/access-control/roles.md) `role` for the organization, cloud, or folder whose audit logs the trail will collect.
