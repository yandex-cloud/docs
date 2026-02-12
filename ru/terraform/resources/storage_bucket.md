---
subcategory: Object Storage
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/storage_bucket.md
---

# yandex_storage_bucket (Resource)

Allows management of [Yandex Cloud Storage Bucket](https://yandex.cloud/docs/storage/concepts/bucket).

{% note warning %}

By default, for authentication, you need to use [IAM token](https://yandex.cloud/docs/iam/concepts/authorization/iam-token) with the necessary permissions.

{% endnote %}


{% note warning %}

Alternatively, you can provide [static access keys](https://yandex.cloud/docs/iam/concepts/authorization/access-key) (Access and Secret). To generate these keys, you will need a Service Account with the appropriate permissions.

{% endnote %}


{% note warning %}

For extended API usage, such as setting the `max_size`, `folder_id`, `anonymous_access_flags`, `default_storage_class`, and `https` parameters for a bucket, only the default authorization method will be used. This means the `IAM` token from the `provider` block will be applied.

{% endnote %}

This can be confusing in cases where a separate service account is used for managing buckets because, in such scenarios,buckets may be accessed by two different accounts, each with potentially different permissions for the buckets.

{% note warning %}

In case you are using IAM token from UserAccount, you are needed to explicitly specify `folder_id` in the resource, as it cannot be identified from such type of account. In case you are using IAM token from ServiceAccount or static access keys, `folder_id` does not need to be specified unless you want to create the resource in a different folder than the account folder.

{% endnote %}


{% note warning %}

Terraform will import this resource with `force_destroy` set to `false` in state. If you've set it to `true` in config, run `terraform apply` to update the value set in state. If you delete this resource before updating the value, objects in the bucket will not be destroyed.

{% endnote %}


## Example usage

```terraform
//
// Create a new Storage Bucket. 
//
provider "yandex" {
  zone = "ru-central1-a"
}

resource "yandex_storage_bucket" "test_bucket" {
  bucket = "tf-test-bucket"
}
```
```terraform
//
// Using Policy Configuration
//
resource "yandex_storage_bucket" "b" {
  bucket = "my-policy-bucket"

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
```terraform
//
// Using Bucket Tagging
//
resource "yandex_storage_bucket" "b" {
  bucket = "my-policy-bucket"

  tags = {
    test_key  = "test_value"
    other_key = "other_value"
  }
}
```
```terraform
//
// Set Bucket Max Size.
//
resource "yandex_storage_bucket" "b" {
  bucket = "my-policy-bucket"

  max_size = 1048576
}
```
```terraform
//
// Set Bucket Folder Id.
//
resource "yandex_storage_bucket" "b" {
  bucket = "my-policy-bucket"

  folder_id = "<folder_id>"
}
```
```terraform
//
// Using Bucket Anonymous Access Flags.
//
resource "yandex_storage_bucket" "b" {
  bucket = "my-policy-bucket"

  anonymous_access_flags {
    read        = true
    list        = false
    config_read = true
  }
}
```
```terraform
//
// Bucket HTTPS Certificate.
//
resource "yandex_storage_bucket" "b" {
  bucket = "my-policy-bucket"

  https {
    certificate_id = "<certificate_id_from_certificate_manager>"
  }
}
```
```terraform
//
// Set Bucket Default Storage Class.
//
resource "yandex_storage_bucket" "b" {
  bucket = "my-policy-bucket"

  default_storage_class = "COLD"
}
```
```terraform
//
// All Bucket settings example.
//
provider "yandex" {
  token              = "<iam-token>"
  folder_id          = "<folder-id>"
  storage_access_key = "<storage-access-key>"
  storage_secret_key = "<storage-secret-key>"
}

resource "yandex_storage_bucket" "log_bucket" {
  bucket = "my-tf-log-bucket"

  lifecycle_rule {
    id      = "cleanupoldlogs"
    enabled = true
    expiration {
      days = 365
    }
  }
}

resource "yandex_kms_symmetric_key" "key-a" {
  name              = "example-symetric-key"
  description       = "description for key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // equal to 1 year
}

resource "yandex_storage_bucket" "all_settings" {
  bucket = "example-tf-settings-bucket"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  lifecycle_rule {
    id      = "test"
    enabled = true
    prefix  = "prefix/"
    expiration {
      days = 30
    }
  }
  lifecycle_rule {
    id      = "log"
    enabled = true

    prefix = "log/"

    transition {
      days          = 30
      storage_class = "COLD"
    }

    expiration {
      days = 90
    }
  }

  lifecycle_rule {
    id      = "everything180"
    prefix  = ""
    enabled = true

    expiration {
      days = 180
    }
  }
  lifecycle_rule {
    id      = "cleanupoldversions"
    prefix  = "config/"
    enabled = true

    noncurrent_version_transition {
      days          = 30
      storage_class = "COLD"
    }

    noncurrent_version_expiration {
      days = 90
    }
  }
  lifecycle_rule {
    id                                     = "abortmultiparts"
    prefix                                 = ""
    enabled                                = true
    abort_incomplete_multipart_upload_days = 7
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT"]
    allowed_origins = ["https://storage-cloud.example.com"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  logging {
    target_bucket = yandex_storage_bucket.log_bucket.id
    target_prefix = "tf-logs/"
  }

  max_size = 1024

  folder_id = "<folder_id>"

  default_storage_class = "COLD"

  anonymous_access_flags {
    read = true
    list = true
  }

  https = {
    certificate_id = "<certificate_id>"
  }

  tags = {
    some_key = "some_value"
  }
}
```
```terraform
//
// Simple Private Bucket With Static Access Keys.
//
locals {
  folder_id = "<folder-id>"
}

provider "yandex" {
  zone = "ru-central1-a"
}

// Create SA
resource "yandex_iam_service_account" "sa" {
  folder_id = local.folder_id
  name      = "tf-test-sa"
}

// Grant permissions
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = local.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

// Use keys to create bucket
resource "yandex_storage_bucket" "test" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "tf-test-bucket"
}
```
```terraform
//
// Static Website Hosting.
//
resource "yandex_storage_bucket" "test" {
  bucket = "storage-website-test.hashicorp.com"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
    routing_rules  = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }

}
```
```terraform
//
// Using ACL policy grants.
//
resource "yandex_storage_bucket" "test" {
  bucket = "mybucket"

  grant {
    id          = "myuser"
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }

  grant {
    type        = "Group"
    permissions = ["READ", "WRITE"]
    uri         = "http://acs.amazonaws.com/groups/global/AllUsers"
  }
}
```
```terraform
//
// Using CORS.
//
resource "yandex_storage_bucket" "b" {
  bucket = "s3-website-test.hashicorp.com"
  acl    = "public-read"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["https://s3-website-test.hashicorp.com"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}
```
```terraform
//
// Using versioning.
//
resource "yandex_storage_bucket" "b" {
  bucket = "my-tf-test-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }
}
```

## Arguments & Attributes Reference

- `access_key` (String). The access key to use when applying changes. This value can also be provided as `storage_access_key` specified in provider config (explicitly or within `shared_credentials_file`) is used.
- `acl` (String). The [predefined ACL](https://yandex.cloud/docs/storage/concepts/acl#predefined_acls) to apply. Defaults to `private`. Conflicts with `grant`.

{% note warning %}

To change ACL after creation, service account with `storage.admin` role should be used, though this role is not necessary to create a bucket with any ACL.

{% endnote %}


- `bucket` (String). The name of the bucket. If omitted, Terraform will assign a random, unique name.
- `bucket_domain_name` (*Read-Only*) (String). The bucket domain name.
- `bucket_prefix` (String). Creates a unique bucket name beginning with the specified prefix. Conflicts with `bucket`.
- `default_storage_class` (String). Storage class which is used for storing objects by default. Available values are: "STANDARD", "COLD", "ICE". Default is `"STANDARD"`. See [Storage Class](https://yandex.cloud/docs/storage/concepts/storage-class) for more information.
- `disabled_statickey_auth` (Bool). If true, static key authentication in bucket is forbidden. Default is `false`.
- `folder_id` (String). Allow to create bucket in different folder. In case you are using IAM token from UserAccount, you are needed to explicitly specify folder_id in the resource, as it cannot be identified from such type of account. In case you are using IAM token from ServiceAccount or static access keys, folder_id does not need to be specified unless you want to create the resource in a different folder than the account folder.

{% note warning %}

It will try to create bucket using `IAM-token`, not using `access keys`.

{% endnote %}


- `force_destroy` (Bool).  A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are *not* recoverable. Default is `false`.
- `id` (String). 
- `max_size` (Number). The size of bucket, in bytes. See [Size Limiting](https://yandex.cloud/docs/storage/operations/buckets/limit-max-volume) for more information.
- `policy` (String). The `policy` object should contain the only field with the text of the policy. See [policy documentation](https://yandex.cloud/docs/storage/concepts/policy) for more information on policy format.
- `secret_key` (String). The secret key to use when applying changes. This value can also be provided as `storage_secret_key` specified in provider config (explicitly or within `shared_credentials_file`) is used.
- `tags` (Map Of String). The `tags` object for setting tags (or labels) for bucket. See [Tags](https://yandex.cloud/docs/storage/concepts/tags) for more information.
- `website_domain` (String). The domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string.
- `website_endpoint` (String). The website endpoint, if the bucket is configured with a website. If not, this will be an empty string.
- `anonymous_access_flags` [Block]. Provides various access to objects. See [Bucket Availability](https://yandex.cloud/docs/storage/operations/buckets/bucket-availability) for more information.
  - `config_read` (Bool). Allows to read bucket configuration anonymously.
  - `list` (Bool). Allows to list object in bucket anonymously.
  - `read` (Bool). Allows to read objects in bucket anonymously.
- `cors_rule` [Block]. A rule of [Cross-Origin Resource Sharing](https://yandex.cloud/docs/storage/concepts/cors) (CORS object).
  - `allowed_headers` (List Of String). Specifies which headers are allowed.
  - `allowed_methods` (**Required**)(List Of String). Specifies which methods are allowed. Can be `GET`, `PUT`, `POST`, `DELETE` or `HEAD`.
  - `allowed_origins` (**Required**)(List Of String). Specifies which origins are allowed.
  - `expose_headers` (List Of String). Specifies expose header in the response.
  - `max_age_seconds` (Number). Specifies time in seconds that browser can cache the response for a preflight request.
- `grant` [Block]. An [ACL policy grant](https://yandex.cloud/docs/storage/concepts/acl#permissions-types). Conflicts with `acl`.

{% note warning %}

To manage `grant` argument, service account with `storage.admin` role should be used.

{% endnote %}


  - `id` (String). Canonical user id to grant for. Used only when type is `CanonicalUser`.
  - `permissions` (**Required**)(Set Of String). List of permissions to apply for grantee. Valid values are `READ`, `WRITE`, `FULL_CONTROL`.
  - `type` (**Required**)(String). Type of grantee to apply for. Valid values are `CanonicalUser` and `Group`.
  - `uri` (String). URI address to grant for. Used only when type is Group.
- `https` [Block]. Manages https certificates for bucket. See [https](https://yandex.cloud/docs/storage/operations/hosting/certificate) for more information.
  - `certificate_id` (**Required**)(String). Id of the certificate in Certificate Manager, that will be used for bucket.
- `lifecycle_rule` [Block]. A configuration of [object lifecycle management](https://yandex.cloud/docs/storage/concepts/lifecycles).
  - `abort_incomplete_multipart_upload_days` (Number). Specifies the number of days after initiating a multipart upload when the multipart upload must be completed.
  - `enabled` (**Required**)(Bool). Specifies lifecycle rule status.
  - `id` (String). Unique identifier for the rule. Must be less than or equal to 255 characters in length.
  - `prefix` (String). Object key prefix identifying one or more objects to which the rule applies.
  - `expiration` [Block]. Specifies a period in the object's expire.
    - `date` (String). Specifies the date after which you want the corresponding action to take effect.
    - `days` (Number). Specifies the number of days after object creation when the specific rule action takes effect.
    - `expired_object_delete_marker` (Bool). n a versioned bucket (versioning-enabled or versioning-suspended bucket), you can add this element in the lifecycle configuration to direct Object Storage to delete expired object delete markers.
  - `filter` [Block]. Filter block identifies one or more objects to which the rule applies. A Filter must have exactly one of Prefix, Tag, or And specified. The filter supports options listed below.

At least one of `abort_incomplete_multipart_upload_days`, `expiration`, `transition`, `noncurrent_version_expiration`, `noncurrent_version_transition` must be specified.
    - `object_size_greater_than` (Number). Minimum object size to which the rule applies.
    - `object_size_less_than` (Number). Maximum object size to which the rule applies.
    - `prefix` (String). Object key prefix identifying one or more objects to which the rule applies.
    - `and` [Block]. A logical `and` operator applied to one or more filter parameters. It should be used when two or more of the above parameters are used.
      - `object_size_greater_than` (Number). Minimum object size to which the rule applies.
      - `object_size_less_than` (Number). Maximum object size to which the rule applies.
      - `prefix` (String). Object key prefix identifying one or more objects to which the rule applies.
      - `tags` (Map Of String). The `tags` object for setting tags (or labels) for bucket. See [Tags](https://yandex.cloud/docs/storage/concepts/tags) for more information.
    - `tag` [Block]. A key and value pair for filtering objects. E.g.: `key=key1, value=value1`.
      - `key` (**Required**)(String). A key.
      - `value` (**Required**)(String). A value.
  - `noncurrent_version_expiration` [Block]. Specifies when noncurrent object versions expire.
    - `days` (Number). Specifies the number of days noncurrent object versions expire.
  - `noncurrent_version_transition` [Block]. Specifies when noncurrent object versions transitions.
    - `days` (Number). Specifies the number of days noncurrent object versions transition.
    - `storage_class` (**Required**)(String). Specifies the storage class to which you want the noncurrent object versions to transition. Supported values: [`STANDARD_IA`, `COLD`, `ICE`].
  - `transition` [Block]. Specifies a period in the object's transitions.
    - `date` (String). Specifies the date after which you want the corresponding action to take effect.
    - `days` (Number). Specifies the number of days after object creation when the specific rule action takes effect.
    - `storage_class` (**Required**)(String). Specifies the storage class to which you want the object to transition. Supported values: [`STANDARD_IA`, `COLD`, `ICE`].
- `logging` [Block]. A settings of [bucket logging](https://yandex.cloud/docs/storage/concepts/server-logs).
  - `target_bucket` (**Required**)(String). The name of the bucket that will receive the log objects.
  - `target_prefix` (String). To specify a key prefix for log objects.
- `object_lock_configuration` [Block]. A configuration of [object lock management](https://yandex.cloud/docs/storage/concepts/object-lock).
  - `object_lock_enabled` (String). Enable object locking in a bucket. Require versioning to be enabled.
  - `rule` [Block]. Specifies a default locking configuration for added objects. Require object_lock_enabled to be enabled.
    - `default_retention` [Block]. Default retention object.
      - `days` (Number). Specifies a retention period in days after uploading an object version. It must be a positive integer. You can't set it simultaneously with `years`.
      - `mode` (**Required**)(String). Specifies a type of object lock. One of `["GOVERNANCE", "COMPLIANCE"]`.
      - `years` (Number). Specifies a retention period in years after uploading an object version. It must be a positive integer. You can't set it simultaneously with `days`.
- `server_side_encryption_configuration` [Block]. A configuration of server-side encryption for the bucket.
  - `rule` [Block]. A single object for server-side encryption by default configuration.
    - `apply_server_side_encryption_by_default` [Block]. A single object for setting server-side encryption by default.
      - `kms_master_key_id` (**Required**)(String). The KMS master key ID used for the SSE-KMS encryption.
      - `sse_algorithm` (**Required**)(String). The server-side encryption algorithm to use. Single valid value is `aws:kms`.
- `versioning` [Block]. A state of [versioning](https://yandex.cloud/docs/storage/concepts/versioning).

{% note warning %}

To manage `versioning` argument, service account with `storage.admin` role should be used.

{% endnote %}


  - `enabled` (Bool). Enable versioning. Once you version-enable a bucket, it can never return to an unversioned state. You can, however, suspend versioning on that bucket.
- `website` [Block]. A [Website Object](https://yandex.cloud/docs/storage/concepts/hosting)
  - `error_document` (String). An absolute path to the document to return in case of a 4XX error.
  - `index_document` (String). Storage returns this index document when requests are made to the root domain or any of the subfolders (unless using `redirect_all_requests_to`).
  - `redirect_all_requests_to` (String). A hostname to redirect all website requests for this bucket to. Hostname can optionally be prefixed with a protocol (`http://` or `https://`) to use when redirecting requests. The default is the protocol that is used in the original request.
  - `routing_rules` (String). A JSON array containing [routing rules](https://yandex.cloud/docs/storage/s3/api-ref/hosting/upload#request-scheme) describing redirect behavior and when redirects are applied.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_storage_bucket.<resource Name> <resource Id>
terraform import yandex_storage_bucket.test_bucket ...
```
