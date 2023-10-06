# Триггер для {{ iot-short-name }}, который передает сообщения в функцию {{ sf-name }}

[Триггер](../trigger/) для {{ iot-short-name }} предназначен для управления сообщениями, которыми обмениваются устройства, реестры и брокеры. Он создается для топиков: принимает из них копии сообщений и передает в функцию {{ sf-name }} для обработки.

{% include [trigger](../../../_includes/iot-core/trigger.md) %}
 
Триггеру для {{ iot-short-name }} необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова функции. 

О том, как создать триггер для {{ iot-short-name }}, читайте в инструкциях [{#T}](../../operations/trigger/iot-core-trigger-create.md) и [{#T}](../../operations/trigger/iot-core-trigger-broker-create.md).

{% include [batching-messages](../../../_includes/functions/batching-messages.md) %}

## Роли, необходимые для корректной работы триггера для {{ iot-short-name }} {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `{{ roles-functions-invoker }}` на каталог с функцией, которую вызывает триггер.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера {{ iot-short-name }} {#format}

Перед тем как передать копию сообщения в функцию, триггер приводит ее к указанному ниже формату.

### Устройство {#device}

{% include [iot-format](../../../_includes/functions/iot-format.md) %}

### Брокер {#broker}

{% include [iot-format](../../../_includes/functions/iot-format-broker.md) %}

## См. также {#see-also}

* [Триггер для {{ iot-name }}, который передает сообщения в контейнер {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/iot-core-trigger.md).