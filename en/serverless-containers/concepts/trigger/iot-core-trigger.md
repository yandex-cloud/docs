# Trigger for {{ iot-short-name }}

The trigger for {{ iot-short-name }} is designed for managing messages exchanged between devices and registries. The trigger is created for topics: it receives copies of messages from them and passes those copies to the {{ serverless-containers-name }} container for processing.

{% include [trigger](../../../_includes/iot-core/trigger.md) %}

A trigger for {{ iot-short-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to call the container.

## Roles required for the proper operation of a trigger for {{ iot-short-name }} {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles and higher.
* To run a trigger, the service account needs the `serverless.containers.invoker` role for the folder with the container to be called by the trigger.

Read more about [access management](../../security/index.md).

## {{ iot-short-name }} trigger message format {#iot-format}

Before the message is copied to a container, the trigger converts it to the following format:

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

## See also {#see-also_}

* [Trigger for {{ iot-name }} that passes messages to the {{ sf-name }} function](../../../functions/concepts/trigger/iot-core-trigger.md).