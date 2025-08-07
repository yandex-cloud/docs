---
subcategory: Object Storage (S3)
page_title: 'Yandex: yandex_storage_bucket'
description: Allows management of a Yandex Cloud Storage Bucket.
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/storage_bucket.md
---

# yandex_storage_bucket (Resource)

Allows management of [Yandex Cloud Storage Bucket](https://yandex.cloud/docs/storage/concepts/bucket).

~> By default, for authentication, you need to use [IAM token](https://yandex.cloud/docs/iam/concepts/authorization/iam-token) with the necessary permissions.

~> Alternatively, you can provide [static access keys](https://yandex.cloud/docs/iam/concepts/authorization/access-key) (Access and Secret). To generate these keys, you will need a Service Account with the appropriate permissions.

~> For extended API usage, such as setting the `max_size`, `folder_id`, `anonymous_access_flags`, `default_storage_class`, and `https` parameters for a bucket, only the default authorization method will be used. This means the `IAM` token from the `provider` block will be applied.
This can be confusing in cases where a separate service account is used for managing buckets because, in such scenarios,buckets may be accessed by two different accounts, each with potentially different permissions for the buckets.

~> In case you are using IAM token from UserAccount, you are needed to explicitly specify `folder_id` in the resource, as it cannot be identified from such type of account. In case you are using IAM token from ServiceAccount or static access keys, `folder_id` does not need to be specified unless you want to create the resource in a different folder than the account folder.

~> Terraform will import this resource with `force_destroy` set to `false` in state. If you've set it to `true` in config, run `terraform apply` to update the value set in state. If you delete this resource before updating the value, objects in the bucket will not be destroyed.

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

<!-- schema generated by tfplugindocs -->
## Schema

### Optional

- `access_key` (String) The access key to use when applying changes. This value can also be provided as `storage_access_key` specified in provider config (explicitly or within `shared_credentials_file`) is used.
- `acl` (String, Deprecated) The [predefined ACL](https://yandex.cloud/docs/storage/concepts/acl#predefined_acls) to apply. Defaults to `private`. Conflicts with `grant`.

~> To change ACL after creation, service account with `storage.admin` role should be used, though this role is not necessary to create a bucket with any ACL.
- `anonymous_access_flags` (Block Set, Max: 1) Provides various access to objects. See [Bucket Availability](https://yandex.cloud/docs/storage/operations/buckets/bucket-availability) for more information. (see [below for nested schema](#nestedblock--anonymous_access_flags))
- `bucket` (String) The name of the bucket. If omitted, Terraform will assign a random, unique name.
- `bucket_prefix` (String) Creates a unique bucket name beginning with the specified prefix. Conflicts with `bucket`.
- `cors_rule` (Block List) A rule of [Cross-Origin Resource Sharing](https://yandex.cloud/docs/storage/concepts/cors) (CORS object). (see [below for nested schema](#nestedblock--cors_rule))
- `default_storage_class` (String) Storage class which is used for storing objects by default. Available values are: "STANDARD", "COLD", "ICE". Default is `"STANDARD"`. See [Storage Class](https://yandex.cloud/docs/storage/concepts/storage-class) for more information.
- `folder_id` (String) Allow to create bucket in different folder. In case you are using IAM token from UserAccount, you are needed to explicitly specify folder_id in the resource, as it cannot be identified from such type of account. In case you are using IAM token from ServiceAccount or static access keys, folder_id does not need to be specified unless you want to create the resource in a different folder than the account folder.

~> It will try to create bucket using `IAM-token`, not using `access keys`.
- `force_destroy` (Boolean) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are *not* recoverable. Default is `false`.
- `grant` (Block Set, Deprecated) An [ACL policy grant](https://yandex.cloud/docs/storage/concepts/acl#permissions-types). Conflicts with `acl`.

~> To manage `grant` argument, service account with `storage.admin` role should be used. (see [below for nested schema](#nestedblock--grant))
- `https` (Block Set, Max: 1) Manages https certificates for bucket. See [https](https://yandex.cloud/docs/storage/operations/hosting/certificate) for more information. (see [below for nested schema](#nestedblock--https))
- `lifecycle_rule` (Block List) A configuration of [object lifecycle management](https://yandex.cloud/docs/storage/concepts/lifecycles). (see [below for nested schema](#nestedblock--lifecycle_rule))
- `logging` (Block Set) A settings of [bucket logging](https://yandex.cloud/docs/storage/concepts/server-logs). (see [below for nested schema](#nestedblock--logging))
- `max_size` (Number) The size of bucket, in bytes. See [Size Limiting](https://yandex.cloud/docs/storage/operations/buckets/limit-max-volume) for more information.
- `object_lock_configuration` (Block List, Max: 1) A configuration of [object lock management](https://yandex.cloud/docs/storage/concepts/object-lock). (see [below for nested schema](#nestedblock--object_lock_configuration))
- `policy` (String, Deprecated) The `policy` object should contain the only field with the text of the policy. See [policy documentation](https://yandex.cloud/docs/storage/concepts/policy) for more information on policy format.
- `secret_key` (String, Sensitive) The secret key to use when applying changes. This value can also be provided as `storage_secret_key` specified in provider config (explicitly or within `shared_credentials_file`) is used.
- `server_side_encryption_configuration` (Block List, Max: 1) A configuration of server-side encryption for the bucket. (see [below for nested schema](#nestedblock--server_side_encryption_configuration))
- `tags` (Map of String) The `tags` object for setting tags (or labels) for bucket. See [Tags](https://yandex.cloud/docs/storage/concepts/tags) for more information.
- `versioning` (Block List, Max: 1) A state of [versioning](https://yandex.cloud/docs/storage/concepts/versioning).

~> To manage `versioning` argument, service account with `storage.admin` role should be used. (see [below for nested schema](#nestedblock--versioning))
- `website` (Block List, Max: 1) A [Website Object](https://yandex.cloud/docs/storage/concepts/hosting) (see [below for nested schema](#nestedblock--website))
- `website_domain` (String) The domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string.
- `website_endpoint` (String) The website endpoint, if the bucket is configured with a website. If not, this will be an empty string.

### Read-Only

- `bucket_domain_name` (String) The bucket domain name.
- `id` (String) The ID of this resource.

<a id="nestedblock--anonymous_access_flags"></a>
### Nested Schema for `anonymous_access_flags`

Optional:

- `config_read` (Boolean) Allows to read bucket configuration anonymously.
- `list` (Boolean) Allows to list object in bucket anonymously.
- `read` (Boolean) Allows to read objects in bucket anonymously.


<a id="nestedblock--cors_rule"></a>
### Nested Schema for `cors_rule`

Required:

- `allowed_methods` (List of String) Specifies which methods are allowed. Can be `GET`, `PUT`, `POST`, `DELETE` or `HEAD`.
- `allowed_origins` (List of String) Specifies which origins are allowed.

Optional:

- `allowed_headers` (List of String) Specifies which headers are allowed.
- `expose_headers` (List of String) Specifies expose header in the response.
- `max_age_seconds` (Number) Specifies time in seconds that browser can cache the response for a preflight request.


<a id="nestedblock--grant"></a>
### Nested Schema for `grant`

Required:

- `permissions` (Set of String) List of permissions to apply for grantee. Valid values are `READ`, `WRITE`, `FULL_CONTROL`.
- `type` (String) Type of grantee to apply for. Valid values are `CanonicalUser` and `Group`.

Optional:

- `id` (String) Canonical user id to grant for. Used only when type is `CanonicalUser`.
- `uri` (String) URI address to grant for. Used only when type is Group.


<a id="nestedblock--https"></a>
### Nested Schema for `https`

Required:

- `certificate_id` (String) Id of the certificate in Certificate Manager, that will be used for bucket.


<a id="nestedblock--lifecycle_rule"></a>
### Nested Schema for `lifecycle_rule`

Required:

- `enabled` (Boolean) Specifies lifecycle rule status.

Optional:

- `abort_incomplete_multipart_upload_days` (Number) Specifies the number of days after initiating a multipart upload when the multipart upload must be completed.
- `expiration` (Block List, Max: 1) Specifies a period in the object's expire. (see [below for nested schema](#nestedblock--lifecycle_rule--expiration))
- `filter` (Block List, Max: 1) Filter block identifies one or more objects to which the rule applies. A Filter must have exactly one of Prefix, Tag, or And specified. The filter supports options listed below.

At least one of `abort_incomplete_multipart_upload_days`, `expiration`, `transition`, `noncurrent_version_expiration`, `noncurrent_version_transition` must be specified. (see [below for nested schema](#nestedblock--lifecycle_rule--filter))
- `id` (String) Unique identifier for the rule. Must be less than or equal to 255 characters in length.
- `noncurrent_version_expiration` (Block List, Max: 1) Specifies when noncurrent object versions expire. (see [below for nested schema](#nestedblock--lifecycle_rule--noncurrent_version_expiration))
- `noncurrent_version_transition` (Block Set) Specifies when noncurrent object versions transitions. (see [below for nested schema](#nestedblock--lifecycle_rule--noncurrent_version_transition))
- `prefix` (String, Deprecated) Object key prefix identifying one or more objects to which the rule applies.
- `transition` (Block Set) Specifies a period in the object's transitions. (see [below for nested schema](#nestedblock--lifecycle_rule--transition))

<a id="nestedblock--lifecycle_rule--expiration"></a>
### Nested Schema for `lifecycle_rule.expiration`

Optional:

- `date` (String) Specifies the date after which you want the corresponding action to take effect.
- `days` (Number) Specifies the number of days after object creation when the specific rule action takes effect.
- `expired_object_delete_marker` (Boolean) n a versioned bucket (versioning-enabled or versioning-suspended bucket), you can add this element in the lifecycle configuration to direct Object Storage to delete expired object delete markers.


<a id="nestedblock--lifecycle_rule--filter"></a>
### Nested Schema for `lifecycle_rule.filter`

Optional:

- `and` (Block List, Max: 1) A logical `and` operator applied to one or more filter parameters. It should be used when two or more of the above parameters are used. (see [below for nested schema](#nestedblock--lifecycle_rule--filter--and))
- `object_size_greater_than` (Number) Minimum object size to which the rule applies.
- `object_size_less_than` (Number) Maximum object size to which the rule applies.
- `prefix` (String) Object key prefix identifying one or more objects to which the rule applies.
- `tag` (Block List, Max: 1) A key and value pair for filtering objects. E.g.: `key=key1, value=value1`. (see [below for nested schema](#nestedblock--lifecycle_rule--filter--tag))

<a id="nestedblock--lifecycle_rule--filter--and"></a>
### Nested Schema for `lifecycle_rule.filter.and`

Optional:

- `object_size_greater_than` (Number) Minimum object size to which the rule applies.
- `object_size_less_than` (Number) Maximum object size to which the rule applies.
- `prefix` (String) Object key prefix identifying one or more objects to which the rule applies.
- `tags` (Map of String) The `tags` object for setting tags (or labels) for bucket. See [Tags](https://yandex.cloud/docs/storage/concepts/tags) for more information.


<a id="nestedblock--lifecycle_rule--filter--tag"></a>
### Nested Schema for `lifecycle_rule.filter.tag`

Required:

- `key` (String) A key.
- `value` (String) A value.



<a id="nestedblock--lifecycle_rule--noncurrent_version_expiration"></a>
### Nested Schema for `lifecycle_rule.noncurrent_version_expiration`

Optional:

- `days` (Number) Specifies the number of days noncurrent object versions expire.


<a id="nestedblock--lifecycle_rule--noncurrent_version_transition"></a>
### Nested Schema for `lifecycle_rule.noncurrent_version_transition`

Required:

- `storage_class` (String) Specifies the storage class to which you want the noncurrent object versions to transition. Supported values: [`STANDARD_IA`, `COLD`, `ICE`].

Optional:

- `days` (Number) Specifies the number of days noncurrent object versions transition.


<a id="nestedblock--lifecycle_rule--transition"></a>
### Nested Schema for `lifecycle_rule.transition`

Required:

- `storage_class` (String) Specifies the storage class to which you want the object to transition. Supported values: [`STANDARD_IA`, `COLD`, `ICE`].

Optional:

- `date` (String) Specifies the date after which you want the corresponding action to take effect.
- `days` (Number) Specifies the number of days after object creation when the specific rule action takes effect.



<a id="nestedblock--logging"></a>
### Nested Schema for `logging`

Required:

- `target_bucket` (String) The name of the bucket that will receive the log objects.

Optional:

- `target_prefix` (String) To specify a key prefix for log objects.


<a id="nestedblock--object_lock_configuration"></a>
### Nested Schema for `object_lock_configuration`

Optional:

- `object_lock_enabled` (String) Enable object locking in a bucket. Require versioning to be enabled.
- `rule` (Block List, Max: 1) Specifies a default locking configuration for added objects. Require object_lock_enabled to be enabled. (see [below for nested schema](#nestedblock--object_lock_configuration--rule))

<a id="nestedblock--object_lock_configuration--rule"></a>
### Nested Schema for `object_lock_configuration.rule`

Required:

- `default_retention` (Block List, Min: 1, Max: 1) Default retention object. (see [below for nested schema](#nestedblock--object_lock_configuration--rule--default_retention))

<a id="nestedblock--object_lock_configuration--rule--default_retention"></a>
### Nested Schema for `object_lock_configuration.rule.default_retention`

Required:

- `mode` (String) Specifies a type of object lock. One of `["GOVERNANCE", "COMPLIANCE"]`.

Optional:

- `days` (Number) Specifies a retention period in days after uploading an object version. It must be a positive integer. You can't set it simultaneously with `years`.
- `years` (Number) Specifies a retention period in years after uploading an object version. It must be a positive integer. You can't set it simultaneously with `days`.




<a id="nestedblock--server_side_encryption_configuration"></a>
### Nested Schema for `server_side_encryption_configuration`

Required:

- `rule` (Block List, Min: 1, Max: 1) A single object for server-side encryption by default configuration. (see [below for nested schema](#nestedblock--server_side_encryption_configuration--rule))

<a id="nestedblock--server_side_encryption_configuration--rule"></a>
### Nested Schema for `server_side_encryption_configuration.rule`

Required:

- `apply_server_side_encryption_by_default` (Block List, Min: 1, Max: 1) A single object for setting server-side encryption by default. (see [below for nested schema](#nestedblock--server_side_encryption_configuration--rule--apply_server_side_encryption_by_default))

<a id="nestedblock--server_side_encryption_configuration--rule--apply_server_side_encryption_by_default"></a>
### Nested Schema for `server_side_encryption_configuration.rule.apply_server_side_encryption_by_default`

Required:

- `kms_master_key_id` (String) The KMS master key ID used for the SSE-KMS encryption.
- `sse_algorithm` (String) The server-side encryption algorithm to use. Single valid value is `aws:kms`.




<a id="nestedblock--versioning"></a>
### Nested Schema for `versioning`

Optional:

- `enabled` (Boolean) Enable versioning. Once you version-enable a bucket, it can never return to an unversioned state. You can, however, suspend versioning on that bucket.


<a id="nestedblock--website"></a>
### Nested Schema for `website`

Optional:

- `error_document` (String) An absolute path to the document to return in case of a 4XX error.
- `index_document` (String) Storage returns this index document when requests are made to the root domain or any of the subfolders (unless using `redirect_all_requests_to`).
- `redirect_all_requests_to` (String) A hostname to redirect all website requests for this bucket to. Hostname can optionally be prefixed with a protocol (`http://` or `https://`) to use when redirecting requests. The default is the protocol that is used in the original request.
- `routing_rules` (String) A JSON array containing [routing rules](https://yandex.cloud/docs/storage/s3/api-ref/hosting/upload#request-scheme) describing redirect behavior and when redirects are applied.

## Import

The resource can be imported by using their `resource ID`. For getting the resource ID you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or [YC CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_storage_bucket.<resource Name> <resource Id>
terraform import yandex_storage_bucket.test_bucket ...
```
