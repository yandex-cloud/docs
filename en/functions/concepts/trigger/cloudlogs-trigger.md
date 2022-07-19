# Trigger for {{ cloud-logs-name }}

{% note alert %}

Triggers for {{ cloud-logs-name }} are deprecated. Use [triggers for {{ cloud-logging-name }}](./cloud-logging-trigger.md).

{% endnote %}

A trigger for {{ cloud-logs-name }} runs a function when messages are received in a [log group](../../../functions/concepts/log-group.md). The trigger must be in the same folder as the log groups it is subscribed to.

{% note alert %}

Triggers for {{ cloud-logs-name }} may skip messages under increased load. To make sure you don't lose them, in the trigger settings for {{ cloud-logs-name }}, specify [DLQ](../dlq.md) and process messages from there with a [trigger for {{ message-queue-short-name }}](ymq-trigger.md).

{% endnote %}

A trigger for {{ cloud-logs-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to invoke the function.

## Batching {#batching}

Batching settings let you simultaneously send multiple messages to a function. They set a top limit on the size of a message group and its accumulation time. For example, if the size of a message group is 3, the function can receive groups that contain from 1 to 3 messages.

## Roles required for the proper operation of a trigger for {{ cloud-logs-name }} {#roles}

- To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the roles [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor), and higher.
- To run a trigger, the service account needs the `{{ roles-functions-ivoker }}` role for the folder containing the function called by the trigger.

Read more about [access management](../../security/index.md).

## {{ cloud-logs-name }} trigger message format {#ymq-format}

After the trigger is activated, it sends the following message to the function:

```json

{
  "messages": [
    {
      "event_metadata": {
        "event_id": "564ab7ff-5890-4eca-b8ab-************",
        "event_type": "yandex.cloud.events.serverless.triggers.CloudLogsMessageBatch",
        "created_at": {
          "seconds": 1599563113,
          "nanos": 647071528
        }
      },
      "details": {
        "messages": [
          {
            "log_group_id": "eol1fphr************",
            "log_stream_name": "log-stream-name",
            "message": "message-1",
            "timestamp": "2020-09-08T11:05:10Z"
          },
          {
            "log_group_id": "eol1fphr************",
            "log_stream_name": "log-stream-name",
            "message": "message-2",
            "timestamp": "2020-09-08T11:05:10Z"
          }
        ]
      }
    }
  ]
}
```

