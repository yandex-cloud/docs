[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Serverless Triggers > Data Sources > serverless_triggers

# yandex_serverless_triggers (DataSource)




## Arguments & Attributes Reference

- `action` [Block]. List of actions to perform when the trigger fires.
  - `dead_letter` [Block]. Dead-letter destination for events that could not be processed after all retries. Optional.
    - `dead_letter_queue` [Block]. Deliver the failed event as a message to a YMQ queue.
      - `message_attributes` (Map Of String). Constant message attributes attached to every message written to the queue.
      - `queue_arn` (**Required**)(String). ARN of the queue.
      - `service_account_id` (String). ID of the service account with write access to the queue.
  - `filter` [Block]. Optional filter applied to each event before invoking the target.
 If the filter condition evaluates to false, this action is skipped for that event.
    - `jq` (String). jq expression evaluated against the event payload.
 The action is invoked only if the expression returns true.
  - `gateway_websocket_broadcast` [Block]. Broadcast a message to API Gateway WebSocket connections.
    - `gateway_id` (**Required**)(String). ID of the API Gateway.
    - `path` (**Required**)(String). WebSocket connection path on the gateway to broadcast to.
    - `service_account_id` (String). ID of the service account with permission to write to WebSocket connections.
  - `invoke_container` [Block]. Invoke a Serverless Containers container.
    - `container_id` (**Required**)(String). ID of the container to invoke.
    - `path` (String). HTTP path to invoke on the container.
    - `service_account_id` (String). ID of the service account to use for invoking the container.
  - `invoke_function` [Block]. Invoke a Cloud Functions function.
    - `function_id` (**Required**)(String). ID of the function to invoke.
    - `function_tag` (String). Tag of the function version to invoke. If empty, the latest version is used.
    - `service_account_id` (String). ID of the service account to use for invoking the function.
  - `retry_policy` [Block]. Retry policy for failed invocations. Optional.
 Not applicable for YMQ triggers - use the queue's Redrive Policy instead.
    - `interval` (**Required**)(String). Time interval between retry attempts.
    - `retry_attempts` (Number). Maximum number of retry attempts.
  - `start_workflow` [Block]. Start a Workflows workflow.
    - `service_account_id` (String). ID of the service account to use for starting the workflow.
    - `workflow_id` (**Required**)(String). ID of the workflow to start.
  - `transformer` [Block]. Optional transformer applied to the event payload before passing it to the target.
    - `jq` (String). jq expression applied to the event payload.
 The expression result is used as the new payload.
- `created_at` (*Read-Only*) (String). Timestamp when the trigger was created.
- `description` (String). Description of the trigger.
- `folder_id` (String). ID of the folder that the trigger belongs to.
- `id` (String). ID of the trigger to return.
 To get a trigger ID make a [TriggerService.List] request.
- `labels` (Map Of String). Resource labels as `key:value` pairs.
- `name` (**Required**)(String). Name of the trigger.
- `source` [Block]. Event source for this trigger.
  - `billing_budget` [Block]. Billing budget source: fires when a budget threshold is reached.
    - `billing_account_id` (**Required**)(String). ID of the billing account to monitor.
    - `budget_id` (String). ID of the budget to monitor. If empty, the trigger fires for any budget in the account.
  - `container_registry` [Block]. Container Registry source: fires on image and tag events.
    - `batch_settings` [Block]. Batch settings for accumulating registry events.
      - `cutoff` (**Required**)(String). Maximum time to wait before flushing an incomplete batch.
 Ensures events are never held indefinitely regardless of batch size.
      - `max_bytes` (Number). Maximum size of events in a batch.
      - `max_count` (Number). Maximum number of events in a batch.
 At least one of max_count, max_bytes must be greater than 0.
    - `event_type` (List Of String). Event types to listen for. At least one value is required.
    - `image_name` (String). Filter events by image name. Optional.
    - `registry_id` (**Required**)(String). ID of the registry to monitor.
    - `tag` (String). Filter events by image tag. Optional.
  - `iot_broker_message` [Block]. IoT Core Broker source: fires on matching IoT Core Broker messages.
    - `batch_settings` [Block]. Batch settings for processing events.
      - `cutoff` (**Required**)(String). Maximum time to wait before flushing an incomplete batch.
 Ensures events are never held indefinitely regardless of batch size.
      - `max_bytes` (Number). Maximum size of events in a batch.
      - `max_count` (Number). Maximum number of events in a batch.
 At least one of max_count, max_bytes must be greater than 0.
    - `broker_id` (**Required**)(String). ID of the IoT Core broker.
    - `mqtt_topic` (String). MQTT topic whose messages activate the trigger.
  - `iot_message` [Block]. IoT Core source: fires on matching IoT Core messages.
    - `batch_settings` [Block]. Batch settings for processing events.
      - `cutoff` (**Required**)(String). Maximum time to wait before flushing an incomplete batch.
 Ensures events are never held indefinitely regardless of batch size.
      - `max_bytes` (Number). Maximum size of events in a batch.
      - `max_count` (Number). Maximum number of events in a batch.
 At least one of max_count, max_bytes must be greater than 0.
    - `device_id` (String). ID of the IoT Core device in the registry.
    - `mqtt_topic` (String). MQTT topic whose messages activate the trigger.
    - `registry_id` (**Required**)(String). ID of the IoT Core registry.
  - `logging` [Block]. Logging source: fires on matching log events.
    - `batch_settings` [Block]. Batch settings for accumulating log events.
      - `cutoff` (**Required**)(String). Maximum time to wait before flushing an incomplete batch.
 Ensures events are never held indefinitely regardless of batch size.
      - `max_bytes` (Number). Maximum size of events in a batch.
      - `max_count` (Number). Maximum number of events in a batch.
 At least one of max_count, max_bytes must be greater than 0.
    - `levels` (List Of String). Logging levels to filter log events.
    - `log_group_id` (**Required**)(String). ID of the log group to read from.
    - `resource_id` (List Of String). Resource IDs to filter log events.
    - `resource_type` (List Of String). Resource types to filter log events.
    - `stream_name` (List Of String). Stream names to filter log events.
  - `mail` [Block]. Mail source: fires on incoming emails.
    - `attachments_bucket` [Block]. Object Storage bucket settings for storing email attachments.
      - `bucket_id` (String). ID of the Object Storage bucket.
      - `service_account_id` (String). ID of the service account with write access to the bucket.
    - `batch_settings` [Block]. Batch settings for accumulating incoming emails.
      - `cutoff` (**Required**)(String). Maximum time to wait before flushing an incomplete batch.
 Ensures events are never held indefinitely regardless of batch size.
      - `max_bytes` (Number). Maximum size of events in a batch.
      - `max_count` (Number). Maximum number of events in a batch.
 At least one of max_count, max_bytes must be greater than 0.
    - `email` (String). Email address that receives messages for this trigger.
  - `object_storage` [Block]. Object Storage source: fires on object events in a bucket.
    - `batch_settings` [Block]. Batch settings for accumulating object events.
      - `cutoff` (**Required**)(String). Maximum time to wait before flushing an incomplete batch.
 Ensures events are never held indefinitely regardless of batch size.
      - `max_bytes` (Number). Maximum size of events in a batch.
      - `max_count` (Number). Maximum number of events in a batch.
 At least one of max_count, max_bytes must be greater than 0.
    - `bucket_id` (**Required**)(String). ID of the bucket to monitor.
    - `event_type` (List Of String). Event types to listen for. At least one value is required.
    - `prefix` (String). Filter events by object key prefix. Optional.
    - `suffix` (String). Filter events by object key suffix. Optional.
  - `telegram_message` [Block]. Telegram source: fires on Telegram bot updates.
    - `allowed_updates` (List Of String). Types of Telegram updates to receive. Optional, default is ["message"].
    - `bot_token` (String). input only, always empty in output.
 Required on Create; on Update, changing it re-registers the webhook.
    - `force` (Bool). input only. Overwrite a webhook the bot already has set to a different URL,
 instead of failing with "webhook already in use". If the webhook already
 points to this trigger, force does nothing - the existing webhook is kept.
  - `timer` [Block]. Timer source: fires on a cron schedule.
    - `cron_expression` (**Required**)(String). Cron expression defining the trigger schedule.
 See http://man7.org/linux/man-pages/man5/crontab.5.html for the format; some limitations apply.
    - `payload` (String). Payload passed to the invoked target on each firing.
  - `yandex_messenger` [Block]. Yandex Messenger source: fires on Yandex Messenger bot updates.
    - `bot_display_name` (String). Display name of the bot the token belongs to. output only.
    - `bot_id` (String). ID of the bot the token belongs to. output only.
    - `bot_login` (String). Login of the bot the token belongs to. output only.
    - `force` (Bool). input only. Overwrite a webhook the bot already has set to a different URL,
 instead of failing with "webhook already in use". If the webhook already
 points to this trigger, force does nothing - the existing webhook is kept.
    - `oauth_token` (String). OAuth token of the Yandex Messenger bot.
 input only, always empty in output.
 Required on Create; on Update, changing it re-registers the webhook.
  - `yds` [Block]. YDS source: fires on records in a Yandex Data Streams stream.
    - `batch_settings` [Block]. Batch settings for reading records from the stream.
      - `cutoff` (**Required**)(String). Maximum time to wait before flushing an incomplete batch.
 Ensures events are never held indefinitely regardless of batch size.
      - `max_bytes` (Number). Maximum size of events in a batch.
      - `max_count` (Number). Maximum number of events in a batch.
 At least one of max_count, max_bytes must be greater than 0.
    - `consumer` (**Required**)(String). Name of the data stream consumer.
    - `database` (**Required**)(String). YDS database path.
    - `service_account_id` (String). ID of the service account with read access to the data stream.
    - `stream` (**Required**)(String). Name of the data stream to read from.
  - `ymq` [Block]. YMQ source: fires on messages in a Yandex Message Queue.
    - `batch_settings` [Block]. Batch settings for reading messages from the queue.
      - `cutoff` (**Required**)(String). Maximum time to wait before flushing an incomplete batch.
 Ensures events are never held indefinitely regardless of batch size.
      - `max_bytes` (Number). Maximum size of events in a batch.
      - `max_count` (Number). Maximum number of events in a batch.
 At least one of max_count, max_bytes must be greater than 0.
    - `queue_arn` (**Required**)(String). ARN of the queue.
    - `service_account_id` (String). ID of the service account with read access to the queue.
    - `visibility_timeout` (String). Queue visibility timeout override.
- `status` (*Read-Only*) (String). Current status of the trigger.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `trigger_id` (String). ID of the trigger to return.
 To get a trigger ID make a [TriggerService.List] request.