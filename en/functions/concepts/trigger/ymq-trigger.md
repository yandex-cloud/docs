# Triggers for {{ message-queue-short-name }}

[The trigger](index.md) for {{ message-queue-short-name }} is used to process the message queue. It picks up messages from the queue and passes them to a function for processing. The trigger must be in the same cloud with the queue it reads messages from. Only one trigger can be created for each message queue.

The {{ message-queue-short-name }} trigger needs [service accounts](../../../iam/concepts/users/service-accounts.md) to read messages from a queue and call functions. You can use the same service account for both operations.

## Roles required for the proper operation of a trigger for {{ message-queue-short-name }} {#roles}

- To create a trigger, you need the following roles:
    - `{{ roles-viewer }}` for the folder with the message queue that the trigger reads messages from.
    - `{{ roles-viewer }}` for the folder with the function that the trigger calls.
    - Permission to the service accounts on whose behalf the trigger executes the operations. This permission is included in the roles [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor), and higher.
- To run a trigger, service accounts need the following roles:
    - `{{ roles-viewer }}` for the folder with the message queue that the trigger reads messages from.
    - `{{ roles-functions-ivoker }}` for the folder with the function that the trigger calls.

Learn more about [access management](../../security/index.md).

## Trigger message format {{ message-queue-short-name }} {#ymq-format}

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
            "queue_id": "yrn:yc:ymq:ru-central1:21i6v06sqmsaoeon7nus:event-queue",
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
            "queue_id": "yrn:yc:ymq:ru-central1:21i6v06sqmsaoeon7nus:event-queue",
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

