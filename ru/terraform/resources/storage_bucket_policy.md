---
subcategory: Object Storage
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/storage_bucket_policy.md
---

# yandex_storage_bucket_policy (Resource)

Allows management of policy of an existing [Yandex Cloud Storage Bucket](https://yandex.cloud/docs/storage/concepts/bucket).

{% note warning %}

By default, for authentication, you need to use [IAM token](https://yandex.cloud/docs/iam/concepts/authorization/iam-token) with the necessary permissions.

{% endnote %}


{% note warning %}

Alternatively, you can provide [static access keys](https://yandex.cloud/docs/iam/concepts/authorization/access-key) (Access and Secret). To generate these keys, you will need a Service Account with the appropriate permissions.

{% endnote %}


{% note warning %}

"Version" element is required and must be set to `2012-10-17`.

{% endnote %}


## Example usage

```terraform
provider "yandex" {
  cloud_id           = "<my_cloud_id>"
  folder_id          = "<my_folder_id>"
  storage_access_key = "<my_storage_access_key>"
  storage_secret_key = "<my_storage_secret_key>"
  token              = "<my_iam_token>"
}

resource "yandex_storage_bucket_policy" "my_policy_0" {
  bucket = "my_bucket_name_0"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::my-policy-bucket/*",
        "arn:aws:s3:::my-policy-bucket"
      ]
    },
    {
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:PutObject",
      "Resource": [
        "arn:aws:s3:::my-policy-bucket/*",
        "arn:aws:s3:::my-policy-bucket"
      ]
    }
  ]
}
POLICY
}
```

## Arguments & Attributes Reference

- `access_key` (String). The access key to use when applying changes. This value can also be provided as `storage_access_key` specified in provider config (explicitly or within `shared_credentials_file`) is used.
- `bucket` (**Required**)(String). The name of the bucket.
- `policy` (**Required**)(String). The text of the policy.
- `secret_key` (String). The secret key to use when applying changes. This value can also be provided as `storage_secret_key` specified in provider config (explicitly or within `shared_credentials_file`) is used.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# The resource can be imported by using their resource ID.
# For getting a resource ID you can use Yandex Cloud Web UI or YC CLI.

# terraform import yandex_storage_bucket_policy.<resource_name> resource_id
terraform import yandex_storage_bucket_policy.<resource_name> ...
```
