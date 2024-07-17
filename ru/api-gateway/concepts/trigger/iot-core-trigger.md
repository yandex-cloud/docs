# Триггер для {{ iot-short-name }}, который отправляет сообщения в WebSocket-соединения

[Триггер](../trigger/) для {{ iot-short-name }} предназначен для управления сообщениями, которыми обмениваются устройства, реестры и брокеры. Он создается для топиков: принимает из них копии сообщений и отправляет сообщения в [WebSocket-соединения](../extensions/websocket.md) для обработки.

{% include [trigger](../../../_includes/iot-core/trigger.md) %}
 
Триггеру для {{ iot-short-name }} необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для отправки сообщений в WebSocket-соединения. 

О том, как создать триггер для {{ iot-short-name }}, читайте в инструкциях [{#T}](../../operations/trigger/iot-core-trigger-create.md) и [{#T}](../../operations/trigger/iot-core-trigger-broker-create.md).

{% include [batching-messages](../../../_includes/api-gateway/batching-messages.md) %}

## Роли, необходимые для корректной работы триггера для {{ iot-short-name }} {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user), [{{ roles-editor }}](../../../iam/roles-reference.md#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `api-gateway.websocketBroadcaster` на каталог, в котором находится API-шлюз.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера {{ iot-short-name }} {#format}

Перед тем как отправить в WebSocket-соединения копию сообщения, триггер приводит ее к указанному ниже формату.

### Устройство {#device}

{% include [iot-format](../../../_includes/functions/iot-format.md) %}

### Брокер {#broker}

{% include [iot-format](../../../_includes/functions/iot-format-broker.md) %}

## См. также {#see-also}

* [Триггер для {{ iot-name }}, который передает сообщения в контейнер {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/iot-core-trigger.md)
* [Триггер для {{ iot-name }}, который передает сообщения в функцию {{ sf-name }}](../../../functions/concepts/trigger/iot-core-trigger.md)
