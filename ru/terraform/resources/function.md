---
subcategory: Cloud Logging
---

# yandex_function (Resource)

Allows management of [Yandex Cloud Function](https://yandex.cloud/docs/functions)

## Example usage

```terraform
//
// Create a new Yandex Cloud Function
//
resource "yandex_function" "test-function" {
  name               = "some_name"
  description        = "any description"
  user_hash          = "any_user_defined_string"
  runtime            = "python37"
  entrypoint         = "main"
  memory             = "128"
  execution_timeout  = "10"
  service_account_id = "ajeih**********838kk"
  tags               = ["my_tag"]
  secrets {
    id                   = yandex_lockbox_secret.secret.id
    version_id           = yandex_lockbox_secret_version.secret_version.id
    key                  = "secret-key"
    environment_variable = "ENV_VARIABLE"
  }
  content {
    zip_filename = "function.zip"
  }
  mounts {
    name = "mnt"
    ephemeral_disk {
      size_gb = 32
    }
  }
  async_invocation {
    retries_count      = "3"
    service_account_id = "ajeih**********838kk"
    ymq_failure_target {
      service_account_id = "ajeqr**********qb76m"
      arn                = "yrn:yc:ymq:ru-central1:b1glr**********9hsfp:fail"
    }
    ymq_success_target {
      service_account_id = "ajeqr**********qb76m"
      arn                = "yrn:yc:ymq:ru-central1:b1glr**********9hsfp:success"
    }
  }
  log_options {
    log_group_id = "e2392**********eq9fr"
    min_level    = "ERROR"
  }
}
```
```terraform
//
// Create a new Yandex Cloud Function with mounted Object Storage Bucket.
//
resource "yandex_function" "test-function" {
  name               = "some_name"
  user_hash          = "v1"
  runtime            = "python37"
  entrypoint         = "index.handler"
  memory             = "128"
  execution_timeout  = "10"
  service_account_id = yandex_iam_service_account.sa.id
  content {
    zip_filename = "function.zip"
  }
  mounts {
    name = "mnt"
    mode = "ro"
    object_storage {
      bucket = yandex_storage_bucket.my-bucket.bucket
    }
  }
}

locals {
  folder_id = "folder_id"
}

resource "yandex_iam_service_account" "sa" {
  folder_id = local.folder_id
  name      = "test-sa"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = local.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "my-bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "bucket"
}
```

## Arguments & Attributes Reference

- `concurrency` (Number). The maximum number of requests processed by a function instance at the same time.
- `created_at` (*Read-Only*) (String). 
- `description` (String). The resource description.
- `entrypoint` (**Required**)(String). Entrypoint for Yandex Cloud Function.
- `environment` (Map Of String). A set of key/value environment variables for Yandex Cloud Function. Each key must begin with a letter (A-Z, a-z).
- `execution_timeout` (String). Execution timeout in seconds for Yandex Cloud Function.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `image_size` (*Read-Only*) (Number). Image size for Yandex Cloud Function.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `memory` (**Required**)(Number). Memory in megabytes (**aligned to 128MB**) for Yandex Cloud Function.
- `name` (**Required**)(String). The resource name.
- `runtime` (**Required**)(String). Runtime for Yandex Cloud Function.
- `service_account_id` (String). [Service account](https://yandex.cloud/docs/iam/concepts/users/service-accounts) which linked to the resource.
- `tags` (Set Of String). Tags for Yandex Cloud Function. Tag `$latest` isn't returned.
- `tmpfs_size` (Number). Tmpfs size for Yandex Cloud Function.
- `user_hash` (**Required**)(String). User-defined string for current function version. User must change this string any times when function changed. Function will be updated when hash is changed.
- `version` (*Read-Only*) (String). Version of Yandex Cloud Function.
- `async_invocation` [Block]. Config for asynchronous invocations of Yandex Cloud Function.
  - `retries_count` (Number). Maximum number of retries for async invocation.
  - `service_account_id` (String). Service account used for async invocation.
  - `ymq_failure_target` [Block]. Target for unsuccessful async invocation.
    - `arn` (**Required**)(String). YMQ ARN.
    - `service_account_id` (**Required**)(String). Service account used for writing result to queue.
  - `ymq_success_target` [Block]. Target for successful async invocation.
    - `arn` (**Required**)(String). YMQ ARN.
    - `service_account_id` (**Required**)(String). Service account used for writing result to queue.
- `connectivity` [Block]. Function version connectivity. If specified the version will be attached to specified network.
  - `network_id` (**Required**)(String). Network the version will have access to. It's essential to specify network with subnets in all availability zones.
- `content` [Block]. Version deployment content for Yandex Cloud Function code. Can be only one `package` or `content` section. Either `package` or `content` section must be specified.
  - `zip_filename` (**Required**)(String). Filename to zip archive for the version.
- `log_options` [Block]. Options for logging from Yandex Cloud Function.
  - `disabled` (Bool). Is logging from function disabled.
  - `folder_id` (String). Log entries are written to default log group for specified folder.
  - `log_group_id` (String). Log entries are written to specified log group.
  - `min_level` (String). Minimum log entry level.
- `metadata_options` [Block]. Options set the access mode to function's metadata endpoints.
  - `aws_v1_http_endpoint` (Number). Enables access to AWS flavored metadata (IMDSv1). Values: `0` - default, `1` - enabled, `2` - disabled.
  - `gce_http_endpoint` (Number). Enables access to GCE flavored metadata. Values: `0`- default, `1` - enabled, `2` - disabled.
- `mounts` [Block]. Mounts for Yandex Cloud Function.
  - `mode` (String). Mount’s accessibility mode. Valid values are `ro` and `rw`.
  - `name` (**Required**)(String). Name of the mount point. The directory where the target is mounted will be accessible at the `/function/storage/<mounts.0.name>` path.
  - `ephemeral_disk` [Block]. One of the available mount types. Disk available during the function execution time.
    - `block_size_kb` (Number). Optional block size of the ephemeral disk in KB.
    - `size_gb` (**Required**)(Number). Size of the ephemeral disk in GB.
  - `object_storage` [Block]. One of the available mount types. Object storage as a mount.
    - `bucket` (**Required**)(String). Name of the mounting bucket.
    - `prefix` (String). Prefix within the bucket. If you leave this field empty, the entire bucket will be mounted.
- `package` [Block]. Version deployment package for Yandex Cloud Function code. Can be only one `package` or `content` section. Either `package` or `content` section must be specified.
  - `bucket_name` (**Required**)(String). Name of the bucket that stores the code for the version.
  - `object_name` (**Required**)(String). Name of the object in the bucket that stores the code for the version.
  - `sha_256` (String). SHA256 hash of the version deployment package.
- `secrets` [Block]. Secrets for Yandex Cloud Function.
  - `environment_variable` (**Required**)(String). Function's environment variable in which secret's value will be stored. Must begin with a letter (A-Z, a-z).
  - `id` (**Required**)(String). Secret's ID.
  - `key` (**Required**)(String). Secret's entries key which value will be stored in environment variable.
  - `version_id` (**Required**)(String). Secret's version ID.
- `storage_mounts` [Block]. (**DEPRECATED**, use `mounts -> object_storage` instead). Storage mounts for Yandex Cloud Function.
  - `bucket` (**Required**)(String). Name of the mounting bucket.
  - `mount_point_name` (**Required**)(String). Name of the mount point. The directory where the bucket is mounted will be accessible at the `/function/storage/<mount_point>` path.
  - `prefix` (String). Prefix within the bucket. If you leave this field empty, the entire bucket will be mounted.
  - `read_only` (Bool). Mount the bucket in read-only mode.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_function.<resource Name> <resource Id>
terraform import yandex_function.test-function d4e45**********pqvd3
```
