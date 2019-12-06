# Triggers

{% include [triggers-preview](../../_includes/functions/triggers-preview-stage.md) %}

_Triggers_ are conditions that automatically launch a specific function when met. These let you automate work with other Yandex.Cloud services.

You can set up the following types of triggers at the Preview stage:

- [Trigger for {{ message-queue-full-name }}](#ymq-trigger) message queues.
- [Trigger for {{ iot-short-name }}](#iot-trigger) messages.

## Triggers for {{ message-queue-short-name }} {#ymq-trigger}

The {{ message-queue-short-name }} trigger is used to unload a message queue. It takes messages from the queue and passes them to a function for processing. The trigger must be in the same cloud as the queue that messages are read from. Only one trigger can be created for each message queue.

{{ message-queue-short-name }} triggers require service accounts to read messages from a message queue and to call a function. You can use the same service account for both operations.

### Roles required for the proper operation of a trigger for {{ message-queue-short-name }} {#ymq-role}

- To create a trigger, you need the following roles:
    - `{{ roles-viewer }}` for the folder with the message queue that the trigger reads messages from.
    - `{{ roles-viewer }}` for the folder with the function that the trigger calls.
    - `iam.serviceAccounts.user` for the service accounts on whose behalf the trigger performs operations.
- To run a trigger, service accounts need the following roles:
    - `{{ roles-editor }}` for the folder with the message queue that the trigger reads messages from.
    - `{{ roles-functions-ivoker }}` for the folder with the function that the trigger calls.

## Triggers for {{ iot-short-name }} {#iot-trigger}

{% include [iot-core](../../_includes/functions/iot-core-trigger-description.md) %}

### Roles required for the proper operation of a trigger for {{ iot-short-name }} {#iotrole}

To run a trigger, the service account needs the `{{ roles-functions-ivoker }}` role for the folder containing the function called by the trigger.

Read more about [access management](../security/index.md).

Triggers call message processing functions based on preset [quotas and limits](limits.md).

## Specifics of functions invoked by triggers {#invoke}

When a function is called by a trigger, the following specifics apply:

- Functions called by triggers are always called with the `integration=raw` query string parameter. More about [invoking functions](../../functions/concepts/function-invoke.md).
- Before passing messages to the function, the trigger converts messages [to a specific format](#message-format).

### Incoming function message formats {#message-format}

Triggers message functions in the modified format defined for each trigger:

- [{{ message-queue-short-name }} trigger message format](#ymq-format)
- [{{ iot-short-name }} trigger message format](#iot-format)

#### Trigger message format {{ message-queue-short-name }} {#ymq-format}

After the trigger receive a message from the queue, it passes it to the function in the following format:

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

#### Trigger message format {{ iot-short-name }} {#iot-format}

After the trigger copies the message from the topic, it passes it to the function in the following format:

```json
{
    "messages": [
        {
            "event_metadata": {
                 "event_id": "2153b5d2-c6af-4c69-a28d-74ce965b7613",
                 "event_type": "yandex.cloud.events.iot.IoTMessage",
                 "created_at": "2019-09-25T15:51:17.872320525Z"
            },
            "details": {
                 "registry_id": "arenou2oj4ct42eq8g3n",
                 "device_id": "areqjd6un3afc3cefcvm",
                 "mqtt_topic": "$devices/areqjd6un3afc3cefcvm/events",
                 "payload": "VGVzdCA0"
            }
        },
        {
            "event_metadata": {
                 "event_id": "2153b5d2-c6af-4c69-a28d-74ce965b7613",
                 "event_type": "yandex.cloud.events.iot.IoTMessage",
                 "created_at": "2019-09-25T15:51:17.872320525Z"
            },
            "details": {
                 "registry_id": "arenou2oj4ct42eq8g3n",
                 "device_id": "areqjd6un3afc3cefcvm",
                 "mqtt_topic": "$devices/areqjd6un3afc3cefcvm/events",
                 "payload": "VGVzdCA0"
            }
        }
    ]
}
```

