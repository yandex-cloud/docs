
* `--name`: Name of the trail being created.
   The name format requirements are as follows:

   {% include [name-format](../../_includes/name-format.md) %}

* `--description`: Description of the trail to distinguish it from other trails, e.g., `--description "My very first trail"`. This is an optional parameter.

* `--service-account-id`: [ID](../../iam/operations/sa/get-id.md) of the service account that the trail will use to upload audit log files to the bucket.

   Based on the audit log [collection scope](../../audit-trails/concepts/trail.md#collecting-area), the [service account](../../iam/concepts/users/service-accounts.md) must have the `audit-trails.viewer` [role](../../iam/concepts/access-control/roles.md) for the organization, cloud, or folder whose audit logs the trail will collect.

