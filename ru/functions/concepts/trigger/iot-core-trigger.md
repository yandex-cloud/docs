# Триггер для {{ iot-short-name }}

Триггер для {{ iot-short-name }} предназначен для управления сообщениями, которыми обмениваются устройства и реестры. Он создается для топиков: принимает из них копии сообщений и передает в функцию {{ sf-name }} для обработки.

{% include [trigger](../../../_includes/iot-core/trigger.md) %}
 
Триггеру для {{ iot-short-name }} необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова функции. 

## Роли, необходимые для корректной работы триггера для {{ iot-short-name }} {#roles}

- Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor) и выше.
- Для работы триггера сервисному аккаунту необходима роль `{{ roles-functions-ivoker }}` на каталог с функцией, которую вызывает триггер.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера {{ iot-short-name }} {#iot-format}

Перед тем как передать копию сообщения в функцию, триггер приводит ее к следующему формату:

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

## См. также {#see-also_}

* [Триггер для {{ iot-name }}, который передает сообщения в контейнер {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/iot-core-trigger.md).