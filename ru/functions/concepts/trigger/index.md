---
title: Триггер. Обзор
description: 'Триггер — условие, при выполнении которого автоматически запускается функция. Триггеры позволяют автоматизировать работу с другими сервисами Yandex Cloud, например, Yandex Object Storage, Yandex Message Queue и Yandex IoT Core.'
---

# Триггер. Обзор

_Триггер_ — условие, при выполнении которого автоматически запускается [функция](../function.md) {{ sf-name }}. Триггеры позволяют автоматизировать работу с другими сервисами {{ yandex-cloud }}, например {{ objstorage-full-name }}, {{ message-queue-full-name }} и {{ iot-full-name }}. 

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

В {{ sf-name }} доступны следующие типы триггеров: 
* [таймер](timer.md);
* [триггер для {{ message-queue-name }}](ymq-trigger.md);
* [триггер для {{ objstorage-name }}](os-trigger.md);
* [триггер для {{ iot-name }}](iot-core-trigger.md);
* [триггер для {{ container-registry-name }}](cr-trigger.md);
* [триггер для {{ cloud-logging-name }}](cloud-logging-trigger.md);
* [триггер для бюджетов](budget-trigger.md);
* [триггер для {{ yds-name }}](data-streams-trigger.md);
* [триггер для почты](mail-trigger.md).

## Особенности вызова функции триггером {#invoke}

Триггеры вызывают функции c учетом установленных [квот и лимитов](../../../functions/concepts/limits.md).

При вызове функции триггером существуют следующие особенности:
- Функция всегда вызывается триггером с параметром строки запроса `integration=raw`. Подробнее о [вызове функции](../function-invoke.md).
- Перед передачей сообщений в функцию, триггер изменяет их формат. У каждого типа триггера свой формат сообщений, подробнее об этом читайте в разделе с описанием соответствующего триггера.

## См. также {#see-also}

* [Триггеры для запуска контейнера {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/index.md).
