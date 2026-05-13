# yandex_message_queue (DataSource)

Get information about a Yandex Message Queue. For more information about Yandex Message Queue, see [Yandex Cloud Message Queue](../../message-queue/index.md).

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

- `access_key` (String). The [access key](../../iam/operations/authentication/manage-access-keys.md) to use when applying changes. If omitted, `ymq_access_key` specified in provider config is used. For more information see [documentation](../../message-queue/quickstart.md).
- `arn` (*Read-Only*) (String). ARN of the Yandex Message Queue. It is used for setting up a [redrive policy](../../message-queue/concepts/dlq.md). See [documentation](../../message-queue/api-ref/queue/SetQueueAttributes.md).
- `id` (String). 
- `name` (String). Queue name. The maximum length is 80 characters. You can use numbers, letters, underscores, and hyphens in the name. The name of a FIFO queue must end with the `.fifo` suffix. If not specified, random name will be generated. Conflicts with `name_prefix`. For more information see [documentation](../../message-queue/api-ref/queue/CreateQueue.md).
- `region_id` (String). ID of the region where the message queue is located at. The default is 'ru-central1'.
- `secret_key` (String). The [secret key](../../iam/operations/authentication/manage-access-keys.md) to use when applying changes. If omitted, `ymq_secret_key` specified in provider config is used. For more information see [documentation](../../message-queue/quickstart.md).
- `url` (*Read-Only*) (String). URL of the queue.