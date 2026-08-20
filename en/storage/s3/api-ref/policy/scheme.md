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

#|
|| **Parameter** | **Description** ||
|| `Version` | (Optional) **string**

Bucket policy description version.

Examples of values: `2012-10-17`. ||
|| `Id` | (Optional) **string**

General policy information. Some {{ yandex-cloud }} services require this value to be unique.

The parameter is specified by the user.

Examples of values: `test-policy`, `Anonymous access policy`, `hrtk43sau2s8gqkaje06`. ||
|| `Statement[].` | **array**

Bucket policy rules.

If a bucket policy with no rules is applied to the bucket, access is denied to all users. To disable request verification for a bucket policy, [delete](delete.md) it. ||
|| `Statement[].Sid` | **string**

(Optional) Rule ID.

This parameter is specified by the user.

Examples of values: `test-rule`, `Statement Allow`, `Statement Deny`. ||
|| `Statement[].Principal` | **string**

(Optional) Requested permission subject ID. You can request permissions for a [user](../../../../organization/operations/users-get.md), or [service account](../../../../iam/operations/sa/get-id.md).

The possible values are:
* `"*"`
* `"CanonicalUser": "<subject_ID>"`

You can 

{% include [canonical-user-identification](../../../../_includes/storage/canonical-user-identification.md) %} ||
|| `Statement[].NotPrincipal` | **string**

(Optional) ID of the subject that will not get the requested permission. The possible subjects are: [user](../../../../organization/operations/users-get.md), or [service account](../../../../iam/operations/sa/get-id.md).

The possible value is: `"CanonicalUser": "<subject_ID>"`.

You can  ||
|| `Statement[].Effect` | **string**

Denies or allows the requested action.

It can be either `Allow` or `Deny`. ||
|| `Statement[].Action` | **string**

[Action](actions.md) to perform when the policy is triggered.

It can be either `s3:GetObject` or `s3:PutObject`. ||
|| `Statement[].Resource` | **string**

Resource to perform the action on.

The possible values are:
* `arn:aws:s3:::<bucket_name>`: Bucket.
* `arn:aws:s3:::<bucket_name>/<object_key>`: Bucket object.
* `arn:aws:s3:::<bucket_name>/<object_key_prefix>*`: All objects in the bucket whose keys start with a prefix, e.g., `arn:aws:s3:::samplebucket/some/path/*`. A prefix can be empty, e.g., `arn:aws:s3:::samplebucket/*`, in which case the rule will apply to all bucket objects.

A bucket resource does not include resources of all its objects. To make sure a bucket policy rule refers to the bucket and all the objects, specify them as separate resources, e.g., `arn:aws:s3:::samplebucket` and `arn:aws:s3:::samplebucket/*`. ||
|| `Statement[].Condition{}.` | **string**

(Optional) [Condition](conditions.md) to check.

If multiple conditions are set for one rule at the same time, they will apply with the logical `AND`, i.e., the rule must satisfy all specified conditions at the same time to be executed.

The `aws:sourceip` condition supports a special procedure for [verifying reverse proxy server IP addresses](../../../concepts/policy.md#access-via-reverse-proxy). If you only need to check the original IP address while ignoring proxies, use the `yc:originip` [condition](conditions.md#keys). ||
|| `Statement[].Condition{}.`
`condition_type_string{}.` | **string**

Condition type.

It can be either `StringEquals` or `Bool`. For a full list of values, see [Comparison operators](conditions.md#condition-operators). ||
|| `Statement[].Condition{}.`
`condition_type_string{}.`
`condition_key_string` | **string**

Condition key.

The condition whose value will be checked.

It can be either `aws:PrincipalType` or `true`.

If multiple keys are set for one condition at the same time, these keys will be checked using the logical `AND`, i.e., the rule must satisfy all specified attributes at the same time to be executed.

If multiple values are set for one condition key at the same time, these values will be checked using the logical `OR`, i.e., the condition key may satisfy any of the specified values for the rule to be executed. ||
|#

#### Related articles {#related-articles}

* [{#T}](../../../concepts/policy.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
