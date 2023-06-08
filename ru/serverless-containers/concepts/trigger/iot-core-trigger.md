# Триггер для {{ iot-short-name }}, который передает сообщения в контейнер {{ serverless-containers-name }}

[Триггер](../trigger/) для {{ iot-short-name }} предназначен для управления сообщениями, которыми обмениваются устройства и реестры. Он создается для [топиков](../../../iot-core/concepts/topic/index.md): принимает из них копии сообщений и передает в контейнер {{serverless-containers-name }} для обработки.
 
{% include [trigger](../../../_includes/iot-core/trigger.md) %}
 
Триггеру для {{ iot-short-name }} необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова контейнера. 

О том, как создать триггер для {{ iot-short-name }}, читайте в инструкции [{#T}](../../operations/iot-core-trigger-create.md).

## Роли, необходимые для корректной работы триггера для {{ iot-short-name }} {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `serverless.containers.invoker` на каталог с контейнером, который вызывает триггер.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера {{ iot-short-name }} {#format}

Перед тем как передать копию сообщения в контейнер, триггер приводит ее к следующему формату: 

{% include [iot-format](../../../_includes/functions/iot-format.md) %}

## См. также {#see-also}

* [Триггер для {{ iot-name }}, который передает сообщения в функцию {{ sf-name }}](../../../functions/concepts/trigger/iot-core-trigger.md).
