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
`Version` | (Optional) **string**<br/>Bucket policy description version.<br/>Examples of values: `2012-10-17`.
`Id` | (Optional) **string**<br/>General policy information. Some {{ yandex-cloud }} services require this value to be unique.<br/>The parameter is specified by the user.<br/>Examples of values: `test-policy`, `Anonymous access policy`, `hrtk43sau2s8gqkaje06`.
`Statement[].` | **array**<br/>Bucket policy rules.<br/>If a bucket policy with no rules is applied to the bucket, access is denied to all users. To disable request verification for a bucket policy, [delete](delete.md) it.
`Statement[].Sid` | **string**<br/>(Optional) Rule ID.<br/>This parameter is specified by the user.<br/>Examples of values: `test-rule`, `Statement Allow`, `Statement Deny`.
`Statement[].Principal` | **string**<br/>(Optional) Requested permission subject ID. You can request permissions for a [user](../../../../iam/operations/users/get.md), or [service account](../../../../iam/operations/sa/get-id.md).<br/>The possible values are `*` and `<subject_ID>`.
`Statement[].NotPrincipal` | **string**<br/>(Optional) ID of the subject that will not get the requested permission. The possible subjects are: [user](../../../../iam/operations/users/get.md), or [service account](../../../../iam/operations/sa/get-id.md).<br/>The possible value is `<subject_ID>`.
`Statement[].Effect` | **string**<br/>Denies or allows the requested action.<br/>It can be either `Allow` or `Deny`.
`Statement[].Action` | **string**<br/>[Action](actions.md) to perform when the policy is triggered.<br/>It can be either `s3:GetObject` or `s3:PutObject`.
`Statement[].Resource` | **string**<br/>Resource to perform the action on.<br/>The possible values are: <ul><li>`arn:aws:s3:::<bucket_name>`: Bucket.</li><li>`arn:aws:s3:::<bucket_name>/<object_key>`: Bucket object.</li><li>`arn:aws:s3:::<bucket_name>/<object_key_prefix>*`: All objects in the bucket whose keys start with a prefix, e.g., `arn:aws:s3:::samplebucket/some/path/*`. A prefix can be empty, e.g., `arn:aws:s3:::samplebucket/*`, in which case the rule will apply to all bucket objects.</li></ul> A bucket resource does not include resources of all its objects. To make sure a bucket policy rule refers to the bucket and all the objects, specify them as separate resources, e.g., `arn:aws:s3:::samplebucket` and `arn:aws:s3:::samplebucket/*`.
`Statement[].Condition{}.` | **string**<br/>(Optional) [Condition](conditions.md) to check.<br/>If multiple conditions are set for one rule at the same time, they will apply with the logical `AND`, i.e., the rule must satisfy all specified conditions at the same time to be executed.<br/><br/>The `aws:sourceip` condition supports a special procedure for [verifying reverse proxy server IP addresses](../../../concepts/policy.md#access-via-reverse-proxy).
`Statement[].Condition{}.`<br/>`condition_type_string{}.` | **string**<br/>Condition type.<br/>It can be either `StringEquals` or `Bool`. For a full list of values, see [Comparison operators](conditions.md#condition-operators).
`Statement[].Condition{}.`<br/>`condition_type_string{}.`<br/>`condition_key_string` | **string**<br/>Condition key.<br/><br/>The condition whose value will be checked.<br/>It can be either `aws:PrincipalType` or `true`.<br/><br/>If multiple keys are set for one condition at the same time, these keys will be checked using the logical `AND`, i.e., the rule must satisfy all specified attributes at the same time to be executed.<br/><br/>If multiple values are set for one condition key at the same time, these values will be checked using the logical `OR`, i.e., the condition key may satisfy any of the specified values for the rule to be executed.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}