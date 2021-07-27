---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Triggers for {{ cloud-logs-name }}

A trigger for {{ cloud-logs-name }} runs a function when messages are received in a [log group](../../../functions/concepts/log-group.md). The trigger must be in the same folder as the log groups it is subscribed to.

A trigger for {{ cloud-logs-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to invoke the function.

## Batching {#batching}

Batching can be used to send several messages to the function simultaneously. Batch options set an upper limit for message group size and accumulation time.
For example, if you set the batch size as 3, function could receive message groups of size from 1 to 3.

## Roles required for the proper operation of a trigger for {{ cloud-logs-name }} {#roles}

- To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the roles [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor), and higher.
- To run a trigger, the service account needs the `{{ roles-functions-ivoker }}` role for the folder containing the function called by the trigger.

Learn more about [access management](../../security/index.md).

## Trigger message format {{ cloud-logs-name }} {#ymq-format}

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


