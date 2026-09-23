---
subcategory: Serverless Containers
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

- `async_invocation` (*Read-Only*) (List Of Object). 
  - `service_account_id` . 
- `concurrency` (*Read-Only*) (Number). Concurrency of Yandex Cloud Serverless Container.
- `container_id` (String). Yandex Cloud Serverless Container ID used to define container.
- `core_fraction` (*Read-Only*) (Number). Core fraction (**0...100**) of the Yandex Cloud Serverless Container.
- `cores` (*Read-Only*) (Number). Cores (**1+**) of the Yandex Cloud Serverless Container.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `execution_timeout` (*Read-Only*) (String). Execution timeout in seconds (**duration format**) for Yandex Cloud Serverless Container.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `image` (*Read-Only*) (List Of Object). 
  - `args` . 
  - `command` . 
  - `digest` . 
  - `environment` . 
  - `url` . 
  - `work_dir` . 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_options` (*Read-Only*) (List Of Object). 
  - `disabled` . 
  - `folder_id` . 
  - `log_group_id` . 
  - `min_level` . 
- `memory` (*Read-Only*) (Number). Memory in megabytes (**aligned to 128 MB**).
- `name` (String). The resource name.
- `revision_id` (*Read-Only*) (String). Last revision ID of the Yandex Cloud Serverless Container.
- `service_account_id` (*Read-Only*) (String). [Service account](https://yandex.cloud/docs/iam/concepts/users/service-accounts) which linked to the resource.
- `url` (*Read-Only*) (String). Invoke URL for the Yandex Cloud Serverless Container.
- `connectivity` [Block]. 
  - `network_id` (**Required**)(String). 
- `metadata_options` [Block]. 
  - `aws_v1_http_endpoint` (Number). 
  - `gce_http_endpoint` (Number). 
- `mounts` [Block]. 
  - `mode` (String). 
  - `mount_point_path` (**Required**)(String). 
  - `ephemeral_disk` [Block]. 
    - `block_size_kb` (Number). 
    - `size_gb` (**Required**)(Number). 
  - `object_storage` [Block]. 
    - `bucket` (**Required**)(String). 
    - `prefix` (String). 
- `runtime` [Block]. 
  - `type` (**Required**)(String). 
- `secrets` [Block]. 
  - `environment_variable` (**Required**)(String). 
  - `id` (**Required**)(String). 
  - `key` (**Required**)(String). 
  - `version_id` (**Required**)(String). 
- `storage_mounts` [Block]. 
  - `bucket` (**Required**)(String). 
  - `mount_point_path` (**Required**)(String). 
  - `prefix` (String). 
  - `read_only` (Bool).


