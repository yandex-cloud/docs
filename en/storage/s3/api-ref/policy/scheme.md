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

A schema may include up to 10,240 characters.

Description of schema parameters:

Parameter | Description
----- | -----
`Version` | **string** (optional)<br/>Access policy description version.<br/>Examples: `2012-10-17`.
`Id` | **string** (optional)<br/>General info on the policy. Some {{ yandex-cloud }} services require a unique value.<br/>This is a user-defined parameter.<br/>Examples: `test-policy`, `Anonymous access policy`, `hrtk43sau2s8gqkaje06`.
`Statement[].` | **array**<br/>Access policy rules.<br/>If a no-rule bucket policy is applied to the bucket, access will be denied to all users. To disable request verification for a bucket policy, [delete](delete.md) it.
`Statement[].Sid` | **string**<br/>Rule ID (optional).<br/>This is a user-defined parameter.<br/>Examples: `test-rule`, `Statement Allow`, `Statement Deny`.
`Statement[].Principal` | **string**<br/>ID of the subject of the requested permission (optional). The recipient can be a [user](../../../../organization/operations/users-get.md) or [service account](../../../../iam/operations/sa/get-id.md).<br/>The possible values are: `*`, `<subject_ID>`.
`Statement[].NotPrincipal` | **string**<br/>ID of the subject that will not get the requested permission (optional). The subject can be a [user](../../../../organization/operations/users-get.md) or [service account](../../../../iam/operations/sa/get-id.md).<br/>The possible values are: `<subject_ID>`.
`Statement[].Effect` | **string**<br/>Denies or allows the requested action.<br/>The possible values are `Allow` and `Deny`.
`Statement[].Action` | **string**<br/>[Action](actions.md) if the policy triggers.<br/>The possible values are `s3:GetObject` and `s3:PutObject`.
`Statement[].Resource` | **string**<br/>Resource the action will be performed on.<br/>The possible values are: <ul><li>`arn:aws:s3:::<bucket_name>`: Bucket.</li><li>`arn:aws:s3:::<bucket_name>/<object_key>`: Bucket object.</li><li>`arn:aws:s3:::<bucket_name>/<object_key_prefix>*`: All objects in the bucket whose keys start with a prefix, e.g., `arn:aws:s3:::samplebucket/some/path/*`. A prefix can be empty, e.g., `arn:aws:s3:::samplebucket/*`, in which case the rule will apply to all bucket objects.</li></ul> A bucket resource does not include resources of all its objects. To make sure a bucket policy rule refers to the bucket and all the objects, specify them as separate resources, e.g., `arn:aws:s3:::samplebucket` and `arn:aws:s3:::samplebucket/*`.
`Statement[].Condition{}.` | **string**<br/>[Condition](conditions.md) to check (optional).<br/>If several conditions are set for the rule at the same time, they will apply using the `AND` logic, i.e., to be executed, the rule must satisfy all the specified conditions at the same time.<br/><br/>For the `aws:sourceip` condition, a special procedure for [checking IP addresses of reverse proxy servers](../../../concepts/policy.md#access-via-reverse-proxy) is supported.
`Statement[].Condition{}.`<br/>`condition_type_string{}.` | **string**<br/>Condition type.<br/>The possible values are `StringEquals` and `Bool`. For a full list of values, see [Comparison operators](conditions.md#condition-operators).
`Statement[].Condition{}.`<br/>`condition_type_string{}.`<br/>`condition_key_string` | **string**<br/>Condition key.<br/><br/>Defines the condition to check.<br/>The possible values are: `aws:PrincipalType`, `true`.<br/><br/>If several keys are specified for one condition at the same time, these will be checked with using the `AND` logic, i.e., to be executed, the rule must satisfy all the specified properties at the same time.<br/><br/>If several values are specified for one condition key at the same time, these will be checked with the logical `OR`, i.e., for the rule to be executed, the condition key may satisfy any of the specified values.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}