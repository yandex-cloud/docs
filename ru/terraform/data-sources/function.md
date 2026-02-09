---
subcategory: Cloud Logging
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/function.md
---

# yandex_function (DataSource)

Get information about a Yandex Cloud Function. For more information about Yandex Cloud Functions, see [Yandex Cloud Functions](https://yandex.cloud/docs/functions).
This data source is used to define [Yandex Cloud Function](https://yandex.cloud/docs/functions/concepts/function) that can be used by other resources.

{% note warning %}

Either `function_id` or `name` must be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Yandex Cloud Function
//
data "yandex_function" "my_function" {
  function_id = "d4e45**********pqvd3"
}
```

## Arguments & Attributes Reference

- `async_invocation` [Block]. Config for asynchronous invocations of Yandex Cloud Function.
  - `retries_count` (Number). Maximum number of retries for async invocation.
  - `service_account_id` (String). Service account used for async invocation.
  - `ymq_failure_target` [Block]. Target for unsuccessful async invocation.
    - `arn` (**Required**)(String). YMQ ARN.
    - `service_account_id` (**Required**)(String). Service account used for writing result to queue.
  - `ymq_success_target` [Block]. Target for successful async invocation.
    - `arn` (**Required**)(String). YMQ ARN.
    - `service_account_id` (**Required**)(String). Service account used for writing result to queue.
- `concurrency` (Number). The maximum number of requests processed by a function instance at the same time.
- `created_at` (*Read-Only*) (String). 
- `description` (String). The resource description.
- `entrypoint` (**Required**)(String). Entrypoint for Yandex Cloud Function.
- `environment` (Map Of String). A set of key/value environment variables for Yandex Cloud Function. Each key must begin with a letter (A-Z, a-z).
- `execution_timeout` (String). Execution timeout in seconds for Yandex Cloud Function.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `function_id` (String). Yandex Cloud Function id used to define function.
- `id` (String). 
- `image_size` (*Read-Only*) (Number). Image size for Yandex Cloud Function.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_options` [Block]. Options for logging from Yandex Cloud Function.
  - `disabled` (Bool). Is logging from function disabled.
  - `folder_id` (String). Log entries are written to default log group for specified folder.
  - `log_group_id` (String). Log entries are written to specified log group.
  - `min_level` (String). Minimum log entry level.
- `memory` (**Required**)(Number). Memory in megabytes (**aligned to 128MB**) for Yandex Cloud Function.
- `name` (**Required**)(String). The resource name.
- `runtime` (**Required**)(String). Runtime for Yandex Cloud Function.
- `service_account_id` (String). [Service account](https://yandex.cloud/docs/iam/concepts/users/service-accounts) which linked to the resource.
- `tags` (Set Of String). Tags for Yandex Cloud Function. Tag `$latest` isn't returned.
- `tmpfs_size` (Number). Tmpfs size for Yandex Cloud Function.
- `version` (*Read-Only*) (String). Version of Yandex Cloud Function.
- `connectivity` [Block]. Function version connectivity. If specified the version will be attached to specified network.
  - `network_id` (**Required**)(String). Network the version will have access to. It's essential to specify network with subnets in all availability zones.
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


