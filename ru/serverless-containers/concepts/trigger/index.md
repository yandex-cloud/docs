---
title: "Триггер. Обзор"
description: "Триггер — условие, при выполнении которого автоматически запускается контейнер. Триггеры позволяют автоматизировать работу с другими сервисами Yandex Cloud, например Yandex Object Storage, Yandex Message Queue и Yandex IoT Core."
---

# Триггеры в {{ serverless-containers-name }}. Обзор

_Триггер_ — условие, при выполнении которого автоматически запускается [контейнер](../container.md) {{ serverless-containers-name }}. Триггеры позволяют автоматизировать работу с другими сервисами {{ yandex-cloud }}, например {{ objstorage-full-name }}, {{ message-queue-full-name }} и {{ iot-full-name }}. 

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

В {{ serverless-containers-name }} доступны следующие типы триггеров: 
* [таймер](timer.md);
* [триггер для {{ message-queue-name }}](ymq-trigger.md);
* [триггер для {{ objstorage-name }}](os-trigger.md);
* [триггер для {{ container-registry-name }}](cr-trigger.md);
* [триггер для {{ cloud-logging-name }}](cloud-logging-trigger.md);
* [триггер для {{ iot-name }}](iot-core-trigger.md);
* [триггер для бюджетов](budget-trigger.md);
* [триггер для {{ yds-name }}](data-streams-trigger.md);
* [триггер для почты](mail-trigger.md).

## Особенности вызова контейнера триггером {#invoke}

Триггеры вызывают контейнер с учетом установленных [квот и лимитов](../limits.md).

Перед передачей сообщений в контейнер, триггер изменяет их формат. У каждого типа триггера свой формат сообщений, подробнее об этом читайте в разделе с описанием соответствующего триггера.

## См. также {#see-also_}

* [Триггеры для запуска функции {{ sf-name }}](../../../functions/concepts/trigger/index.md).