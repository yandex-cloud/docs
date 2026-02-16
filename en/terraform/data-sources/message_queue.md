---
subcategory: Message Queue
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/message_queue.md
---

# yandex_message_queue (DataSource)

Get information about a Yandex Message Queue. For more information about Yandex Message Queue, see [Yandex Cloud Message Queue](https://yandex.cloud/docs/message-queue).

## Example usage

```terraform
//
// Get information about existing Message Queue.
//
data "yandex_message_queue" "my_queue" {
  name = "ymq_terraform_example"
}
```

## Arguments & Attributes Reference

- `access_key` (String). The [access key](https://yandex.cloud/docs/iam/operations/sa/create-access-key) to use when applying changes. If omitted, `ymq_access_key` specified in provider config is used. For more information see [documentation](https://yandex.cloud/docs/message-queue/quickstart).
- `arn` (*Read-Only*) (String). ARN of the Yandex Message Queue. It is used for setting up a [redrive policy](https://yandex.cloud/docs/message-queue/concepts/dlq). See [documentation](https://yandex.cloud/docs/message-queue/api-ref/queue/SetQueueAttributes).
- `id` (String). 
- `name` (String). Queue name. The maximum length is 80 characters. You can use numbers, letters, underscores, and hyphens in the name. The name of a FIFO queue must end with the `.fifo` suffix. If not specified, random name will be generated. Conflicts with `name_prefix`. For more information see [documentation](https://yandex.cloud/docs/message-queue/api-ref/queue/CreateQueue).
- `region_id` (String). ID of the region where the message queue is located at. The default is 'ru-central1'.
- `secret_key` (String). The [secret key](https://yandex.cloud/docs/iam/operations/sa/create-access-key) to use when applying changes. If omitted, `ymq_secret_key` specified in provider config is used. For more information see [documentation](https://yandex.cloud/docs/message-queue/quickstart).
- `url` (*Read-Only*) (String). URL of the queue.


