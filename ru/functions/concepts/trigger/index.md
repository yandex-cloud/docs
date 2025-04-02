---
title: Триггеры в {{ sf-name }}. Обзор
description: Триггер — условие, при выполнении которого автоматически запускается функция. Триггеры позволяют автоматизировать работу с другими сервисами {{ yandex-cloud }}, например, Yandex Object Storage, Yandex Message Queue и Yandex IoT Core.
---

# Триггеры в {{ sf-name }}. Обзор

_Триггер_ — условие, при выполнении которого автоматически запускается [функция](../function.md) {{ sf-name }}. Триггеры позволяют автоматизировать работу с другими сервисами {{ yandex-cloud }}, например {{ objstorage-full-name }}, {{ message-queue-full-name }} и {{ container-registry-full-name }}. 

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

## Особенности вызова функции триггером {#invoke}

Триггеры вызывают функции с учетом установленных [квот и лимитов](../../../functions/concepts/limits.md).

При вызове функции триггером существуют следующие особенности:
- Функция всегда вызывается триггером с параметром строки запроса `?integration=raw`. Подробнее о [вызове функции](../function-invoke.md).
- Перед передачей сообщений в функцию, триггер изменяет их формат. У каждого типа триггера свой формат сообщений, подробнее об этом читайте в разделе с описанием соответствующего триггера.

## Примеры использования {#examples}

* [{#T}](../../tutorials/data-recording.md)
* [{#T}](../../tutorials/events-from-postbox-to-yds.md)
* [{#T}](../../tutorials/logging-functions.md)
* [{#T}](../../tutorials/logging.md)
* [{#T}](../../tutorials/regular-launch-datasphere.md)
* [{#T}](../../tutorials/serverless-trigger-budget-vm.md)
* [{#T}](../../tutorials/video-converting-queue.md)

## См. также {#see-also}

* [Триггеры для запуска контейнера {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/index.md).
