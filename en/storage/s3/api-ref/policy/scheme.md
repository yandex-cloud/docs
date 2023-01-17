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
| `Version` | (Optional) **string**<br/>Access policy description version.<br/>Possible values: `2012-10-17`. |
| `Id` | (Optional) **string**<br/>General information about the policy. Some {{ yandex-cloud }} services require the uniqueness of this value.<br/>Possible values: `Anonymous access policy`, `hrtk43sau2s8gqkaje06`. |
| `Statement[].` | **array**<br/>Access policy rules. |
| `Statement[].Sid` | **string**<br/>(Optional) Rule ID.<br/>Possible values: `Statement Allow`, `Statement Deny`. |
| `Statement[].Principal` | **string**<br/>(Optional) ID of the recipient of the requested permission.<br/>Possible values: `*`, `ajeexampleusername`. |
| `Statement[].NotPrincipal` | **string**<br/>(Optional) ID of the entity that won't receive the requested permission.<br/>Possible values: `ajeexampleusername`. |
| `Statement[].Effect` | **string**<br/>Specifies whether the requested action is denied or allowed.<br/>Possible values: `Allow`, `Deny`. |
| `Statement[].Action` | **string**<br/>Determines the [action](actions.md) to be executed when the policy is triggered.<br/>Possible values: `s3:GetObject`, `s3:PutObject`. |
| `Statement[].Resource` | **string**<br/>Specifies the resource that the action will be performed on.<br/>Possible values: `arn:aws:s3:::sample_bucket/*`, `arn:aws:s3:::sample_bucket/object`. |
| `Statement[].Condition{}.` | **string**<br/>(Optional) [Condition](conditions.md) that will be checked. |
| `Statement[].Condition{}.`<br/>`condition_type_string{}.` | **string**<br/>Condition type.<br/>Possible values: `StringEquals`, `Bool`. For a full list of values, see [Comparison operators](conditions.md#condition-operators). |
| `Statement[].Condition{}.`<br/>`condition_type_string{}.`<br/>`condition_key_string` | **string**<br/>Specifies the condition whose value will be checked.<br/>Possible values: `aws:PrincipalType`, `true`. |
