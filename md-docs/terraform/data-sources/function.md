[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Cloud Logging > Data Sources > function

# yandex_function (DataSource)

Get information about a Yandex Cloud Function. For more information about Yandex Cloud Functions, see [Yandex Cloud Functions](../../functions/index.md).
This data source is used to define [Yandex Cloud Function](../../functions/concepts/function.md) that can be used by other resources.

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

- `async_invocation` (*Read-Only*) (List Of Object). 
  - `retries_count` . 
  - `service_account_id` . 
  - `ymq_failure_target` . 
    - `arn` . 
    - `service_account_id` . 
  - `ymq_success_target` . 
    - `arn` . 
    - `service_account_id` . 
- `concurrency` (Number). The maximum number of requests processed by a function instance at the same time.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `entrypoint` (*Read-Only*) (String). Entrypoint for Yandex Cloud Function.
- `environment` (*Read-Only*) (Map Of String). A set of key/value environment variables for Yandex Cloud Function. Each key must begin with a letter (A-Z, a-z).
- `execution_timeout` (*Read-Only*) (String). Execution timeout in seconds for Yandex Cloud Function.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `function_id` (String). Yandex Cloud Function id used to define function.
- `id` (String). 
- `image_size` (*Read-Only*) (Number). Image size for Yandex Cloud Function.
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_options` (*Read-Only*) (List Of Object). 
  - `disabled` . 
  - `folder_id` . 
  - `log_group_id` . 
  - `min_level` . 
- `memory` (*Read-Only*) (Number). Memory in megabytes (**aligned to 128MB**) for Yandex Cloud Function.
- `name` (String). The resource name.
- `runtime` (*Read-Only*) (String). Runtime for Yandex Cloud Function.
- `service_account_id` (*Read-Only*) (String). [Service account](../../iam/concepts/users/service-accounts.md) which linked to the resource.
- `tags` (*Read-Only*) (Set Of String). Tags for Yandex Cloud Function. Tag `$latest` isn't returned.
- `tmpfs_size` (*Read-Only*) (Number). Tmpfs size for Yandex Cloud Function.
- `version` (*Read-Only*) (String). Version of Yandex Cloud Function.
- `connectivity` [Block]. 
  - `network_id` (**Required**)(String). 
- `metadata_options` [Block]. 
  - `aws_v1_http_endpoint` (Number). 
  - `gce_http_endpoint` (Number). 
- `mounts` [Block]. 
  - `mode` (String). 
  - `name` (**Required**)(String). 
  - `ephemeral_disk` [Block]. 
    - `block_size_kb` (Number). 
    - `size_gb` (**Required**)(Number). 
  - `object_storage` [Block]. 
    - `bucket` (**Required**)(String). 
    - `prefix` (String). 
- `secrets` [Block]. 
  - `environment_variable` (**Required**)(String). 
  - `id` (**Required**)(String). 
  - `key` (**Required**)(String). 
  - `version_id` (**Required**)(String). 
- `storage_mounts` [Block]. 
  - `bucket` (**Required**)(String). 
  - `mount_point_name` (**Required**)(String). 
  - `prefix` (String). 
  - `read_only` (Bool).