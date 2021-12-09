# Trigger for {{ iot-short-name }}

{% include [iot-core](../../../_includes/functions/iot-core-trigger-description.md) %}

## Roles required for the proper operation of a trigger for {{ iot-short-name }} {#roles}

- To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the roles [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor), and higher.
- For a trigger to work, the service account needs:
    * `{{ roles-functions-ivoker }}` for the folder with the function that the trigger invokes.
    * `serverless.containers.invoker` for the folder with the container that invokes the trigger.

Read more about [access management](../../security/index.md).

## {{ iot-short-name }} trigger message format {#iot-format}

Before the message is copied to a function or a container, the trigger converts it to the following format:

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

