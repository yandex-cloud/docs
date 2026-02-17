---
subcategory: Cloud Logging
---

# yandex_function_trigger (Resource)

Allows management of [Yandex Cloud Functions Trigger](https://yandex.cloud/docs/functions/).

## Example usage

```terraform
//
// Create a new Cloud Function Trigger.
//
resource "yandex_function_trigger" "my_trigger" {
  name        = "some_name"
  description = "any description"
  timer {
    cron_expression = "* * * * ? *"
  }
  function {
    id = "tf-test"
  }
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). The resource name.
- `container` [Block]. [Yandex Cloud Serverless Container](https://yandex.cloud/docs/serverless-containers/concepts/container) settings definition for Yandex Cloud Functions Trigger.
  - `id` (**Required**)(String). Yandex Cloud Serverless Container ID for Yandex Cloud Functions Trigger.
  - `path` (String). Path for Yandex Cloud Serverless Container for Yandex Cloud Functions Trigger.
  - `retry_attempts` (String). Retry attempts for Yandex Cloud Serverless Container for Yandex Cloud Functions Trigger.
  - `retry_interval` (String). Retry interval in seconds for Yandex Cloud Serverless Container for Yandex Cloud Functions Trigger.
  - `service_account_id` (String). Service account ID for Yandex Cloud Serverless Container for Yandex Cloud Functions Trigger.
- `container_registry` [Block]. [Container Registry](https://yandex.cloud/docs/functions/concepts/trigger/cr-trigger) settings definition for Yandex Cloud Functions Trigger, if present.
  - `batch_cutoff` (**Required**)(String). Batch Duration in seconds for Yandex Cloud Functions Trigger.
  - `batch_size` (String). Batch Size for Yandex Cloud Functions Trigger.
  - `create_image` (Bool). Boolean flag for setting `create image` event for Yandex Cloud Functions Trigger.
  - `create_image_tag` (Bool). Boolean flag for setting `create image tag` event for Yandex Cloud Functions Trigger.
  - `delete_image` (Bool). Boolean flag for setting `delete image` event for Yandex Cloud Functions Trigger.
  - `delete_image_tag` (Bool). Boolean flag for setting `delete image tag` event for Yandex Cloud Functions Trigger.
  - `image_name` (String). Image name filter setting for Yandex Cloud Functions Trigger.
  - `registry_id` (**Required**)(String). Container Registry ID for Yandex Cloud Functions Trigger.
  - `tag` (String). Image tag filter setting for Yandex Cloud Functions Trigger.
- `data_streams` [Block]. [Data Streams](https://yandex.cloud/docs/functions/concepts/trigger/data-streams-trigger) settings definition for Yandex Cloud Functions Trigger, if present.
  - `batch_cutoff` (**Required**)(String). Batch Duration in seconds for Yandex Cloud Functions Trigger.
  - `batch_size` (String). Batch Size for Yandex Cloud Functions Trigger.
  - `database` (**Required**)(String). Stream database for Yandex Cloud Functions Trigger.
  - `service_account_id` (**Required**)(String). Service account ID to access data stream for Yandex Cloud Functions Trigger.
  - `stream_name` (**Required**)(String). Stream name for Yandex Cloud Functions Trigger.
- `dlq` [Block]. Dead Letter Queue (DLQ) settings definition for Yandex Cloud Functions Trigger.
  - `queue_id` (**Required**)(String). ID of Dead Letter Queue for Trigger (Queue ARN).
  - `service_account_id` (**Required**)(String). Service Account ID for Dead Letter Queue for Yandex Cloud Functions Trigger.
- `function` [Block]. [Yandex Cloud Function](https://yandex.cloud/docs/functions/concepts/function) settings definition for Yandex Cloud Functions Trigger.
  - `id` (**Required**)(String). Yandex Cloud Function ID.
  - `retry_attempts` (String). Retry attempts for Yandex Cloud Function for Yandex Cloud Functions Trigger.
  - `retry_interval` (String). Retry interval in seconds for Yandex Cloud Function for Yandex Cloud Functions Trigger.
  - `service_account_id` (String). Service account ID for Yandex Cloud Function.
  - `tag` (String). Tag for Yandex Cloud Function for Yandex Cloud Functions Trigger.
- `iot` [Block]. [IoT](https://yandex.cloud/docs/functions/concepts/trigger/iot-core-trigger) settings definition for Yandex Cloud Functions Trigger, if present. Only one section `iot` or `message_queue`.
  - `batch_cutoff` (**Required**)(String). Batch Duration in seconds for Yandex Cloud Functions Trigger.
  - `batch_size` (String). Batch Size for Yandex Cloud Functions Trigger.
  - `device_id` (String). IoT Device ID for Yandex Cloud Functions Trigger.
  - `registry_id` (**Required**)(String). IoT Registry ID for Yandex Cloud Functions Trigger.
  - `topic` (String). IoT Topic for Yandex Cloud Functions Trigger.
- `log_group` [Block]. Deprecated Logging settings definition for Yandex Cloud Functions Trigger. Please, use logging instead.
  - `batch_cutoff` (**Required**)(String). Batch Duration in seconds for Yandex Cloud Functions Trigger.
  - `batch_size` (String). Batch Size for Yandex Cloud Functions Trigger.
  - `log_group_ids` (**Required**)(Set Of String). Log group IDs for Yandex Cloud Functions Trigger.
- `logging` [Block]. [Logging](https://yandex.cloud/docs/functions/concepts/trigger/cloud-logging-trigger) settings definition for Yandex Cloud Functions Trigger, if present.
  - `batch_cutoff` (**Required**)(String). Batch Duration in seconds for Yandex Cloud Functions Trigger.
  - `batch_size` (String). Batch Size for Yandex Cloud Functions Trigger.
  - `group_id` (**Required**)(String). Logging group ID for Yandex Cloud Functions Trigger.
  - `levels` (Set Of String). Logging level filter setting for Yandex Cloud Functions Trigger.
  - `resource_ids` (Set Of String). Resource ID filter setting for Yandex Cloud Functions Trigger.
  - `resource_types` (Set Of String). Resource type filter setting for Yandex Cloud Functions Trigger.
  - `stream_names` (Set Of String). Logging stream name filter setting for Yandex Cloud Functions Trigger.
- `mail` [Block]. [Mail](https://yandex.cloud/docs/functions/concepts/trigger/mail-trigger) settings definition for Yandex Cloud Functions Trigger, if present.
  - `attachments_bucket_id` (String). Object Storage Bucket ID for Yandex Cloud Functions Trigger.
  - `batch_cutoff` (**Required**)(String). Batch Duration in seconds for Yandex Cloud Functions Trigger.
  - `batch_size` (String). Batch Size for Yandex Cloud Functions Trigger.
  - `service_account_id` (String). Service account ID to access object storage for Yandex Cloud Functions Trigger.
- `message_queue` [Block]. [Message Queue](https://yandex.cloud/docs/functions/concepts/trigger/ymq-trigger) settings definition for Yandex Cloud Functions Trigger, if present.
  - `batch_cutoff` (**Required**)(String). Batch Duration in seconds for Yandex Cloud Functions Trigger.
  - `batch_size` (String). Batch Size for Yandex Cloud Functions Trigger.
  - `queue_id` (**Required**)(String). Message Queue ID for Yandex Cloud Functions Trigger.
  - `service_account_id` (**Required**)(String). Message Queue Service Account ID for Yandex Cloud Functions Trigger.
  - `visibility_timeout` (String). Visibility timeout for Yandex Cloud Functions Trigger.
- `object_storage` [Block]. [Object Storage](https://yandex.cloud/docs/functions/concepts/trigger/os-trigger) settings definition for Yandex Cloud Functions Trigger, if present.
  - `batch_cutoff` (**Required**)(String). Batch Duration in seconds for Yandex Cloud Functions Trigger.
  - `batch_size` (String). Batch Size for Yandex Cloud Functions Trigger.
  - `bucket_id` (**Required**)(String). Object Storage Bucket ID for Yandex Cloud Functions Trigger.
  - `create` (Bool). Boolean flag for setting `create` event for Yandex Cloud Functions Trigger.
  - `delete` (Bool). Boolean flag for setting `delete` event for Yandex Cloud Functions Trigger.
  - `prefix` (String). Prefix for Object Storage for Yandex Cloud Functions Trigger.
  - `suffix` (String). Suffix for Object Storage for Yandex Cloud Functions Trigger.
  - `update` (Bool). Boolean flag for setting `update` event for Yandex Cloud Functions Trigger.
- `timer` [Block]. [Timer](https://yandex.cloud/docs/functions/concepts/trigger/timer) settings definition for Yandex Cloud Functions Trigger, if present.
  - `cron_expression` (**Required**)(String). Cron expression for timer for Yandex Cloud Functions Trigger.
  - `payload` (String). Payload to be passed to function.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_function_trigger.<resource Name> <resource Id>
terraform import yandex_function_trigger.my_trigger a1scn**********3ur32
```
