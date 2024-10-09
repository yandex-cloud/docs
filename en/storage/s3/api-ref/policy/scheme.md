# Data schema

Data schema in JSON format:

```json
{
  "Version" : "string",
  "Id" : "string",
  "Statement" : [
    {
      "Sid" : "string",
      ("Principal" | "NotPrincipal") : ("*" | "CanonicalUser" : [
        "string",
        ...
      ]),
      "Effect" : ("Allow" | "Deny"),
      "Action" : ("*" | [
        "string",
        ...
      ]),
      "Resource" : ("*" | [
        "string",
        ...
      ]),
      "Condition" : {
        "condition_type_string" : {
          "condition_key_string" : [[("string" | "number" | "Boolean"),...]...]
        },
        ...
      }  
    },
    ...
  ]
}
```

A schema can include up to 10,240 characters.

Description of schema parameters:

Parameter | Description
----- | -----
`Version` | (Optional) **String**<br/>Access policy description version.<br/>Sample values: `2012-10-17`.
`Id` | (Optional) **String**<br/>General policy information. Some {{ yandex-cloud }} services require this value to be unique.<br/>The parameter is specified by the user.<br/>Sample values: `test-policy`, `Anonymous access policy`, `hrtk43sau2s8gqkaje06`.
`Statement[].` | **array**<br/>Access policy rules.<br/>If a bucket policy with no rules is applied to the bucket, access is denied to all users. To disable request verification for a bucket policy, [delete](delete.md) it.
`Statement[].Sid` | **string**<br/>(Optional) Rule ID.<br/>The parameter is specified by the user.<br/>Sample values: `test-rule`, `Statement Allow`, `Statement Deny`.
`Statement[].Principal` | **string**<br/>(Optional) Requested permission subject ID. The possible recipients are: [user](../../../../iam/operations/users/get.md), [service account](../../../../iam/operations/sa/get-id.md), or [user group](../../../../organization/operations/manage-groups.md).<br/>Possible values: `*` and `<subject_ID>`.<br/>You can [specify](../../../operations/buckets/policy.md) a user group in the policy using the {{ yandex-cloud }} CLI, AWS CLI, {{ TF }}, and the API.
`Statement[].NotPrincipal` | **string**<br/>(Optional) ID of the subject that will not get the requested permission. The possible subjects are: [user](../../../../iam/operations/users/get.md), [service account](../../../../iam/operations/sa/get-id.md), or [user group](../../../../organization/operations/manage-groups.md).<br/>Possible values: `<subject_ID>`.<br/>You can [specify](../../../operations/buckets/policy.md) a user group in the policy using the {{ yandex-cloud }} CLI, AWS CLI, {{ TF }}, and the API.
`Statement[].Effect` | **string**<br/>Denies or allows the requested action.<br/>Possible values: `Allow`, `Deny`.
`Statement[].Action` | **string**<br/>Determines the [action](actions.md) to perform when the policy is triggered.<br/>Possible values: `s3:GetObject`, `s3:PutObject`.
`Statement[].Resource` | **string**<br/>Determines the resource the action will be performed on.<br/>Possible values:<ul><li>`arn:aws:s3:::<bucket_name>`: Bucket.</li><li>`arn:aws:s3:::<bucket_name>/<object_key>`: Bucket object.</li><li>`arn:aws:s3:::<bucket_name>/<object_key_prefix>*`: All objects in the bucket whose keys start with a prefix, e.g., `arn:aws:s3:::samplebucket/some/path/*`. A prefix can be empty, e.g., `arn:aws:s3:::samplebucket/*`, in which case the rule will apply to all bucket objects.</li></ul> A bucket resource does not include resources of all its objects. To make sure a bucket policy rule refers to the bucket and all objects, specify them as separate resources, e.g., `arn:aws:s3:::samplebucket` and `arn:aws:s3:::samplebucket/*`.
`Statement[].Condition{}.` | **string**<br/>(Optional) [Condition](conditions.md) that will be checked.<br/>If multiple conditions are set for one rule at the same time, they will apply with the `AND` logic, i.e., the rule must satisfy all specified conditions at the same time to be executed.
`Statement[].Condition{}.`<br/>`condition_type_string{}.` | **string**<br/>Condition type.<br/>Possible values: `StringEquals`, `Bool`. For a full list of values, see [Comparison operators](conditions.md#condition-operators).
`Statement[].Condition{}.`<br/>`condition_type_string{}.`<br/>`condition_key_string` | **string**<br/>Condition key.<br/><br/>Determines the condition whose value will be checked.<br/>Possible values: `aws:PrincipalType`, `true`.<br/><br/>If multiple keys are set for one condition at the same time, these keys will be checked using the `AND` logic, i.e., the rule must satisfy all specified attributes at the same time to be executed.<br/><br/>If multiple values are set for one condition key at the same time, these values will be checked using the `OR` logic, i.e., the condition key may satisfy any of the specified values for the rule to be executed.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}