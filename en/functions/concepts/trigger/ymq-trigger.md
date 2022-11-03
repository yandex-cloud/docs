# Trigger for {{ message-queue-short-name }}

The [ trigger](../trigger/) for {{ message-queue-short-name }} is used to process the message queue. It picks up messages from the queue and passes them to a {{ sf-name }} [function](../function.md) for processing. Once successfully processed, a trigger deletes messages from the queue, and if an error occurs, it places messages back in the queue and sets a [visibility timeout](../../../message-queue/concepts/visibility-timeout.md). If the queue does not have a [Dead Letter Queue](../../../message-queue/concepts/dlq.md) configured, a message will continue to be returned to a function until it is successfully processed or until its storage timeout expires.

You can only create a trigger for a standard message queue. The trigger must be in the same cloud with the queue it reads messages from. Only one trigger can be created for each message queue.

Triggers for {{ message-queue-short-name }} require [service accounts](../../../iam/concepts/users/service-accounts.md) to read messages from a message queue and call a function. You can use the same service account for both operations.

## Roles required for the proper operation of a trigger for {{ message-queue-short-name }} {#roles}

* To create a trigger, you need the following roles:
   * `{{ roles-viewer }}` for the folder with the message queue that the trigger reads messages from.
   * `{{ roles-viewer }}` for the folder with the function that the trigger invokes.
   * Permission to the service account on whose behalf the trigger executes the operations. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles and higher.
* To run a trigger, service accounts need the following roles:
   * `{{ roles-editor }}` for the folder with the message queue that the trigger reads messages from.
   * `{{ roles-functions-ivoker }}` for the folder with the function that the trigger invokes.

Read more about [access management](../../security/index.md).

## {{ message-queue-short-name }} trigger message format {#ymq-format}

After the trigger picks up a message from the queue, it passes it to the function in the following format:

```json
{
   "messages":[
      {
         "event_metadata":{
            "event_id":"cce76685-5828-4304-a83d-95643c0507a0",
            "event_type":"yandex.cloud.events.messagequeue.QueueMessage",
            "created_at":"2019-09-24T00:54:28.980441Z"
         },
         "details":{
            "queue_id": "yrn:yc:ymq:{{ region-id }}:21i6v06sqmsaoeon7nus:event-queue",
            "message":{
               "message_id":"cce76685-5828-4304-a83d-95643c0507a0",
               "md5_of_body":"d29343907090dff4cec4a9a0efb80d20",
               "body":"message body",
               "attributes":{
                  "SentTimestamp":"1569285804456"
               },
               "message_attributes":{
                  "messageAttributeKey":{
                     "dataType":"StringValue",
                     "stringValue":"value"
                  }
               },
               "md5_of_message_attributes":"83eb2d0afefb150c1ffe69f66c3de068"
            }
         }
      },
      {
         "event_metadata":{
            "event_id":"1f32fd25-11fc-4c08-88e7-d871d6ffb91d",
            "event_type":"yandex.cloud.events.messagequeue.QueueMessage",
            "created_at":"2019-09-24T00:54:28.980492Z"
         },
         "details":{
            "queue_id": "yrn:yc:ymq:{{ region-id }}:21i6v06sqmsaoeon7nus:event-queue",
            "message":{
               "message_id":"1f32fd25-11fc-4c08-88e7-d871d6ffb91d",
               "md5_of_body":"d29343907090dff4cec4a9a0efb80d20",
               "body":"message body",
               "attributes":{
                  "SentTimestamp":"1569285806456"
               },
               "message_attributes":{
                  "messageAttributeKey":{
                     "dataType":"StringValue",
                     "stringValue":"value"
                  }
               },
               "md5_of_message_attributes":"83eb2d0afefb150c1ffe69f66c3de068"
            }
         }
      }
   ]
}
```

## See also {#see-also_}

* [Trigger for {{ message-queue-name }} that passes messages to the {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/ymq-trigger.md).