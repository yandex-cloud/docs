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

| Parameter | Description |
----- | -----
| `Version` | (Optional) **string**<br/>Access policy description version.<br/>Sample value: `2012-10-17`. |
| `Id` | (Optional) **string**<br/>General information about the policy. Some {{ yandex-cloud }} services require this value to be unique.<br/>The parameter is user-defined.<br/>Examples: `test-policy`, `Anonymous access policy`, or `hrtk43sau2s8gqkaje06`. |
| `Statement[].` | **array**<br/>Bucket policy rules.<br/>If a bucket policy with no rules is applied to the bucket, access is denied to all users. To disable request verification for a bucket policy, [delete](delete.md) it. |
| `Statement[].Sid` | **string**<br/>(Optional) Rule ID.<br/>The parameter is user-defined.<br/>Examples: `test-rule`, `Statement Allow`, or `Statement Deny`. |
| `Statement[].Principal` | **string**<br/>(Optional) Requested permission subject ID. Possible recipients: [user](../../../../iam/operations/users/get.md) or [service account](../../../../iam/operations/sa/get-id.md).<br/>Possible values: `*` or `<subject_ID>`. |
| `Statement[].NotPrincipal` | **string**<br/>(Optional) ID of the subject that will not receive the requested permission. Possible subjects: [user](../../../../iam/operations/users/get.md) or [service account](../../../../iam/operations/sa/get-id.md).<br/>Possible values: `<subject_ID>`. |
| `Statement[].Effect` | **string**<br/>Specifies whether the requested action is denied or allowed.<br/>Possible values: `Allow`, `Deny`. |
| `Statement[].Action` | **string**<br/>Determines the [action](actions.md) to be executed when the policy is triggered.<br/>Possible values: `s3:GetObject`, `s3:PutObject`. |
| `Statement[].Resource` | **string**<br/>Specifies the resource that the action will be performed on.<br/>Possible values: <ul><li>`arn:aws:s3:::<bucket_name>`: Bucket.</li><li>`arn:aws:s3:::<bucket_name>/<object_key>`: Bucket object.</li><li>`arn:aws:s3:::<bucket_name>/<object_key_prefix>*`: All bucket objects with keys having a prefix, such as `arn:aws:s3:::samplebucket/some/path/*`. A prefix can be empty, e.g., `arn:aws:s3:::samplebucket/*`; in this case, the rule will apply to all bucket objects.</li></ul> A bucket resource does not include resources of all its objects. To make sure a bucket policy rule refers to the bucket and all objects, specify them as separate resources, such as `arn:aws:s3:::samplebucket` and `arn:aws:s3:::samplebucket/*`. |
| `Statement[].Condition{}.` | **string**<br/>(Optional) [Condition](conditions.md) that will be checked. |
| `Statement[].Condition{}.`<br/>`condition_type_string{}.` | **string**<br/>Condition type.<br/>Possible values: `StringEquals`, `Bool`. For a full list of values, see [Comparison operators](conditions.md#condition-operators). |
| `Statement[].Condition{}.`<br/>`condition_type_string{}.`<br/>`condition_key_string` | **string**<br/>Specifies the condition whose value will be checked.<br/>Possible values: `aws:PrincipalType`, `true`. |
