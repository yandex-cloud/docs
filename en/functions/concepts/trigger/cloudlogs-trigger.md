---
title: "Trigger for {{ cloud-logs-name }}"
description: "This article describes the features of triggers for {{ cloud-logs-name }}."
---

# Trigger for {{ cloud-logs-name }}

{% note alert %}

Trigger for {{ cloud-logs-name }} is outdated. Use [triggers for {{ cloud-logging-name }}](./cloud-logging-trigger.md).

{% endnote %}

A trigger for {{ cloud-logs-name }} runs a function when messages are received in a log group. The trigger must be in the same folder as the log groups it is subscribed to.

{% note alert %}

Triggers for {{ cloud-logs-name }} may skip messages under increased load. To make sure you do not lose them, in the trigger settings for {{ cloud-logs-name }}, specify [DLQ](../dlq.md) and process messages from there with a [trigger for {{ message-queue-short-name }}](ymq-trigger.md).

{% endnote %}

A trigger for {{ cloud-logs-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to call the function.

For more information about creating a trigger for {{ cloud-logs-name }}, see [{#T}](../../operations/trigger/cloudlogs-trigger-create.md).

## Batching {#batching}

Batching settings allow you to send multiple messages to a function at the same time. They set a top limit on the size of a message group and its accumulation time. For example, if the size of a message group is 3, the function can receive groups that contain from 1 to 3 messages.

## Roles required for the proper operation of a trigger for {{ cloud-logs-name }} {#roles}

- To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles and higher.
- To run a trigger, the service account needs the `{{ roles-functions-ivoker }}` role for the folder containing the function called by the trigger.

Read more about [access management](../../security/index.md).

## Trigger for {{ cloud-logs-name }} message format {#ymq-format}

After the trigger is fired, it sends the following message to the function:

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
