---
title: Триггеры в {{ sf-name }}. Обзор
description: Триггер — условие, при выполнении которого автоматически запускается функция. Триггеры позволяют автоматизировать работу с другими сервисами {{ yandex-cloud }}, например, Yandex Object Storage, Yandex Message Queue и Yandex IoT Core.
---

# Триггеры в {{ sf-name }}. Обзор

_Триггер_ — условие, при выполнении которого автоматически запускается [функция](../function.md) {{ sf-name }}. Триггеры позволяют автоматизировать работу с другими сервисами {{ yandex-cloud }}, например: {{ objstorage-full-name }}, {{ message-queue-full-name }} и {{ container-registry-full-name }}. 

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

В {{ sf-name }} доступны следующие типы триггеров: 
* [таймер](timer.md);
* [триггер для {{ message-queue-name }}](ymq-trigger.md);
* [триггер для {{ objstorage-name }}](os-trigger.md);
* [триггер для {{ container-registry-name }}](cr-trigger.md);
* [триггер для {{ cloud-logging-name }}](cloud-logging-trigger.md);
* [триггер для {{ iot-name }}](iot-core-trigger.md);
* [триггер для бюджетов](budget-trigger.md);
* [триггер для {{ yds-name }}](data-streams-trigger.md);
* [триггер для почты](mail-trigger.md).

{% include [trigger-intro-note](../../../_includes/functions/trigger-intro-note.md) %}

## Особенности вызова функции триггером {#invoke}

Триггеры вызывают функции с учетом установленных [квот и лимитов](../../../functions/concepts/limits.md).

При вызове функции триггером существуют следующие особенности:
- Функция всегда вызывается триггером с параметром строки запроса `?integration=raw`. Подробнее о вызове функции см. в разделе [{#T}](../function-invoke.md).
- Перед передачей сообщений в функцию, триггер изменяет их формат. У каждого типа триггера свой формат сообщений. Подробнее см. описание соответствующего триггера.
- Сервисному аккаунту, от имени которого будет вызываться функция, необходима роль `{{ roles-functions-invoker }}`. Другие роли, необходимые для корректной работы триггера, зависят от его типа. Подробнее см. описание соответствующего триггера.
- Если работа триггера была приостановлена пользователем, а затем снова запущена, то все события, произошедшие за время простоя, не будут обработаны.

## Группирование сообщений {#batch-messages}

Вы можете настроить группирование сообщений перед вызовом функции у следующих триггеров:

* триггер для {{ message-queue-name }};
* триггер для {{ cloud-logging-name }};
* триггер для {{ objstorage-name }};
* триггер для {{ container-registry-name }};
* триггер для {{ iot-name }};
* триггер для {{ yds-name }};
* триггер для почты.

Это позволит вызывать функцию не для каждого отдельного сообщения, а для целой группы сообщений. Для этого в параметрах триггера задайте:

* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cutoff }}** — время, в течение которого происходит группирование сообщений. Число сообщений при этом не превышает указанный размер группы.
* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}** — количество сообщений для группирования.

Подробнее о группировании сообщений читайте в инструкциях по созданию соответствующего триггера.

## Повторные запросы вызова функции {#invoke-retry}

Вы можете настроить повторный вызов функции, если текущий завершился неуспешно. Для этого в параметрах триггера задайте:

* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-interval }}** — время, через которое будет сделан повторный вызов функции.
* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-attempts }}** — количество повторных вызовов функции, которые будут сделаны, прежде чем триггер отправит сообщение в [Dead Letter Queue](../dlq.md).

Настройка доступна для всех типов триггеров, кроме триггера для {{ message-queue-name }}.

Подробнее о повторных запросах читайте в инструкции по созданию соответствующего триггера.

## Примеры использования {#examples}

* [{#T}](../../tutorials/data-recording.md)
* [{#T}](../../tutorials/events-from-postbox-to-yds.md)
* [{#T}](../../tutorials/logging-functions.md)
* [{#T}](../../tutorials/logging.md)
* [{#T}](../../tutorials/regular-launch-datasphere.md)
* [{#T}](../../tutorials/serverless-trigger-budget-vm.md)
* [{#T}](../../tutorials/video-converting-queue.md)

## См. также {#see-also}

* [Триггеры для запуска контейнера {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/index.md)
* [Триггеры для отправки сообщений в WebSocket-соединения](../../../api-gateway/concepts/trigger/index.md)
