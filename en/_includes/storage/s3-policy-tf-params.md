Where:

* `bucket`: Bucket name. This is a required parameter.
* `policy`: Policy name. This is a required parameter.

Policy settings:

* `Version`: Version of the bucket policy description. This is a required parameter. The only supported value is `2012-10-17`.
* `Statement`: Bucket policy rules:
  * `Effect`: Deny or allow the requested action. The possible values are `Allow` and `Deny`.
  * `Principal`: ID of the subject requesting the permission. You can request permissions for a [user](../../iam/operations/users/get.md), [service account](../../iam/operations/sa/get-id.md), or [user group](../../organization/operations/manage-groups.md). Possible values: `*` and `<subject_ID>`. This is an optional setting.

    You can get the IDs in the following ways:

    {% include [acl-grantee](acl-grantee.md) %}

  * `Action`: [Action](../../storage/s3/api-ref/policy/actions.md) to allow when the policy is triggered. Examples of possible values: `s3:GetObject`, `s3:PutObject`. Use `*` if you need to apply the policy to all actions.
  * `Resource`: Resource to apply the rule to.
  * `Condition`: [Condition](../../storage/s3/api-ref/policy/conditions.md) to check. This is an optional setting.

    {% include [conditions-combining-and](conditions-combining-and.md) %}

    {% include [conditions-combining-or](conditions-combining-or.md) %}
