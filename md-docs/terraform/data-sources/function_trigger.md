[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Cloud Logging > Data Sources > function_trigger

# yandex_function_trigger (DataSource)

Get information about a Yandex Cloud Function Trigger. For more information about Yandex Cloud Functions, see [Yandex Cloud Functions](../../functions/index.md).

This data source is used to define [Yandex Cloud Functions Trigger](../../functions/concepts/trigger/index.md) that can be used by other resources.

{% note warning %}

Either `trigger_id` or `name` must be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Cloud Function Trigger.
//
data "yandex_function_trigger" "my_trigger" {
  trigger_id = "a1scn**********3ur32"
}
```

## Arguments & Attributes Reference

- `container` (*Read-Only*) (List Of Object). [Yandex Cloud Serverless Container](../../serverless-containers/concepts/container.md) settings definition for Yandex Cloud Functions Trigger.
  - `id` . 
  - `path` . 
  - `retry_attempts` . 
  - `retry_interval` . 
  - `service_account_id` . 
- `container_registry` (*Read-Only*) (List Of Object). [Container Registry](../../functions/concepts/trigger/cr-trigger.md) settings definition for Yandex Cloud Functions Trigger, if present.
  - `batch_cutoff` . 
  - `batch_size` . 
  - `create_image` . 
  - `create_image_tag` . 
  - `delete_image` . 
  - `delete_image_tag` . 
  - `image_name` . 
  - `registry_id` . 
  - `tag` . 
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `data_streams` (*Read-Only*) (List Of Object). [Data Streams](../../functions/concepts/trigger/data-streams-trigger.md) settings definition for Yandex Cloud Functions Trigger, if present.
  - `batch_cutoff` . 
  - `batch_size` . 
  - `database` . 
  - `service_account_id` . 
  - `stream_name` . 
  - `suffix` . 
- `description` (*Read-Only*) (String). The resource description.
- `dlq` (*Read-Only*) (List Of Object). Dead Letter Queue (DLQ) settings definition for Yandex Cloud Functions Trigger.
  - `queue_id` . 
  - `service_account_id` . 
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `function` (*Read-Only*) (List Of Object). [Yandex Cloud Function](../../functions/concepts/function.md) settings definition for Yandex Cloud Functions Trigger.
  - `id` . 
  - `retry_attempts` . 
  - `retry_interval` . 
  - `service_account_id` . 
  - `tag` . 
- `id` (String). 
- `iot` (*Read-Only*) (List Of Object). [IoT](../../functions/concepts/trigger/iot-core-trigger.md) settings definition for Yandex Cloud Functions Trigger, if present. Only one section `iot` or `message_queue`.
  - `batch_cutoff` . 
  - `batch_size` . 
  - `device_id` . 
  - `registry_id` . 
  - `topic` . 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_group` (*Read-Only*) (List Of Object). Deprecated Logging settings definition for Yandex Cloud Functions Trigger. Please, use logging instead.
  - `batch_cutoff` . 
  - `batch_size` . 
  - `log_group_ids` . 
- `logging` (*Read-Only*) (List Of Object). [Logging](../../functions/concepts/trigger/cloud-logging-trigger.md) settings definition for Yandex Cloud Functions Trigger, if present.
  - `batch_cutoff` . 
  - `batch_size` . 
  - `group_id` . 
  - `levels` . 
  - `resource_ids` . 
  - `resource_types` . 
  - `stream_names` . 
- `mail` (*Read-Only*) (List Of Object). [Mail](../../functions/concepts/trigger/mail-trigger.md) settings definition for Yandex Cloud Functions Trigger, if present.
  - `attachments_bucket_id` . 
  - `batch_cutoff` . 
  - `batch_size` . 
  - `service_account_id` . 
- `message_queue` (*Read-Only*) (List Of Object). [Message Queue](../../functions/concepts/trigger/ymq-trigger.md) settings definition for Yandex Cloud Functions Trigger, if present.
  - `batch_cutoff` . 
  - `batch_size` . 
  - `queue_id` . 
  - `service_account_id` . 
  - `visibility_timeout` . 
- `name` (String). The resource name.
- `object_storage` (*Read-Only*) (List Of Object). [Object Storage](../../functions/concepts/trigger/os-trigger.md) settings definition for Yandex Cloud Functions Trigger, if present.
  - `batch_cutoff` . 
  - `batch_size` . 
  - `bucket_id` . 
  - `create` . 
  - `delete` . 
  - `prefix` . 
  - `suffix` . 
  - `update` . 
- `timer` (*Read-Only*) (List Of Object). [Timer](../../functions/concepts/trigger/timer.md) settings definition for Yandex Cloud Functions Trigger, if present.
  - `cron_expression` . 
  - `payload` . 
- `trigger_id` (String). Yandex Cloud Functions Trigger id used to define trigger.
- `workflow` (*Read-Only*) (List Of Object). Workflows settings definition for Yandex Cloud Functions Trigger.
  - `id` . 
  - `retry_attempts` . 
  - `retry_interval` . 
  - `service_account_id` .