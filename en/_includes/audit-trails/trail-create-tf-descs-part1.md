* `name`: Name of the new trail. The naming requirements are as follows:

    {% include [name-format](../name-format.md) %}

* `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create the trail in.
* `description`: Description of the trail to distinguish it from other trails, e.g., `My very first trail`. This is an optional parameter.
* `labels`: List of [labels](../../resource-manager/concepts/labels.md) in `key=value` format. This is an optional parameter.
* `service_account_id`: [ID](../../iam/operations/sa/get-id.md) of the service account the trail will use to upload audit log files to the bucket.

    Based on the audit log [collection scope](../../audit-trails/concepts/trail.md#collecting-area), the [service account](../../iam/concepts/users/service-accounts.md) must have the `audit-trails.viewer` [role](../../iam/concepts/access-control/roles.md) for the organization, cloud, or folder whose audit logs the trail will collect.