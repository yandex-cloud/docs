---
subcategory: Cloud Logging
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/serverless_container.md
---

# yandex_serverless_container (DataSource)

Get information about a Yandex Cloud Serverless Container. This data source is used to define Yandex Cloud Container that can be used by other resources.

{% note warning %}

Either `container_id` or `name` must be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Serverless Container.
//
data "yandex_serverless_container" "my-container" {
  container_id = "are1samplecontainer11"
}
```

## Arguments & Attributes Reference

- `async_invocation` [Block]. Config for asynchronous invocations of Yandex Cloud Serverless Container.
  - `service_account_id` (String). Service account used for async invocation.
- `concurrency` (Number). Concurrency of Yandex Cloud Serverless Container.
- `container_id` (String). Yandex Cloud Serverless Container ID used to define container.
- `core_fraction` (Number). Core fraction (**0...100**) of the Yandex Cloud Serverless Container.
- `cores` (Number). Cores (**1+**) of the Yandex Cloud Serverless Container.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `execution_timeout` (String). Execution timeout in seconds (**duration format**) for Yandex Cloud Serverless Container.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `image` [Block]. Revision deployment image for Yandex Cloud Serverless Container.
  - `args` (List Of String). List of arguments for Yandex Cloud Serverless Container.
  - `command` (List Of String). List of commands for Yandex Cloud Serverless Container.
  - `digest` (String). Digest of image that will be deployed as Yandex Cloud Serverless Container. If presented, should be equal to digest that will be resolved at server side by URL. Container will be updated on digest change even if `image.0.url` stays the same. If field not specified then its value will be computed.
  - `environment` (Map Of String). A set of key/value environment variable pairs for Yandex Cloud Serverless Container. Each key must begin with a letter (A-Z, a-z).
  - `url` (**Required**)(String). URL of image that will be deployed as Yandex Cloud Serverless Container.
  - `work_dir` (String). Working directory for Yandex Cloud Serverless Container.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_options` [Block]. Options for logging from Yandex Cloud Serverless Container.
  - `disabled` (Bool). Is logging from container disabled.
  - `folder_id` (String). Log entries are written to default log group for specified folder.
  - `log_group_id` (String). Log entries are written to specified log group.
  - `min_level` (String). Minimum log entry level.
- `memory` (**Required**)(Number). Memory in megabytes (**aligned to 128 MB**).
- `name` (**Required**)(String). The resource name.
- `revision_id` (*Read-Only*) (String). Last revision ID of the Yandex Cloud Serverless Container.
- `service_account_id` (String). [Service account](https://yandex.cloud/docs/iam/concepts/users/service-accounts) which linked to the resource.
- `url` (*Read-Only*) (String). Invoke URL for the Yandex Cloud Serverless Container.
- `connectivity` [Block]. Network access. If specified the revision will be attached to specified network.
  - `network_id` (**Required**)(String). Network the revision will have access to.
- `metadata_options` [Block]. Options set the access mode to revision's metadata endpoints.
  - `aws_v1_http_endpoint` (Number). Enables access to AWS flavored metadata (IMDSv1). Values: `0` - default, `1` - enabled, `2` - disabled.
  - `gce_http_endpoint` (Number). Enables access to GCE flavored metadata. Values: `0`- default, `1` - enabled, `2` - disabled.
- `mounts` [Block]. Mounts for Yandex Cloud Serverless Container.
  - `mode` (String). Mount’s accessibility mode. Valid values are `ro` and `rw`.
  - `mount_point_path` (**Required**)(String). Path inside the container to access the directory in which the target is mounted.
  - `ephemeral_disk` [Block]. One of the available mount types. Disk available during the function execution time.
    - `block_size_kb` (Number). Block size of the ephemeral disk in KB.
    - `size_gb` (**Required**)(Number). Size of the ephemeral disk in GB.
  - `object_storage` [Block]. Available mount types. Object storage as a mount.
    - `bucket` (**Required**)(String). Name of the mounting bucket.
    - `prefix` (String). Prefix within the bucket. If you leave this field empty, the entire bucket will be mounted.
- `runtime` [Block]. Runtime for Yandex Cloud Serverless Container.
  - `type` (**Required**)(String). Type of the runtime for Yandex Cloud Serverless Container. Valid values are `http` and `task`.
- `secrets` [Block]. Secrets for Yandex Cloud Serverless Container.
  - `environment_variable` (**Required**)(String). Container's environment variable in which secret's value will be stored. Must begin with a letter (A-Z, a-z).
  - `id` (**Required**)(String). Secret's ID.
  - `key` (**Required**)(String). Secret's entries key which value will be stored in environment variable.
  - `version_id` (**Required**)(String). Secret's version ID.
- `storage_mounts` [Block]. (**DEPRECATED**, use `mounts.object_storage` instead) Storage mounts for Yandex Cloud Serverless Container.
  - `bucket` (**Required**)(String). Name of the mounting bucket.
  - `mount_point_path` (**Required**)(String). Path inside the container to access the directory in which the bucket is mounted.
  - `prefix` (String). Prefix within the bucket. If you leave this field empty, the entire bucket will be mounted.
  - `read_only` (Bool). Mount the bucket in read-only mode.


