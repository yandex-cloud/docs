---
title: "Создание и запуск триггера в {{ sf-full-name }}"
description: "Из статьи вы узнаете, как создать и запустить триггер в {{ sf-name }}."
---

# Создание и запуск триггера в {{ sf-name }}

Триггеры позволяют вызывать функции {{ sf-name }} при наступлении определенных событий. Например, [таймер](../../concepts/trigger/timer.md) вызывает [функцию](../../concepts/function.md) по заданному пользователем расписанию. [Пример создания таймера, который вызывает функцию {{ sf-name }} каждую минуту](./timer-quickstart.md).

Кроме таймера, в {{ sf-name }} доступны следующие триггеры:

* Триггер для {{ message-queue-short-name }}

    Создайте [триггер](../../concepts/trigger/ymq-trigger.md) для [очереди сообщений](../../../message-queue/concepts/queue.md) сервиса {{ message-queue-short-name }} и обрабатывайте их с помощью функции.

* Триггер для {{ objstorage-short-name }}

    Создайте [триггер для {{ objstorage-name }}](../../concepts/trigger/os-trigger.md), который будет вызывать функцию при создании, перемещении или удалении [объекта](../../../storage/concepts/object.md) в бакете.

* Триггер для {{ container-registry-short-name }}

     Создайте [триггер для {{ container-registry-name }}](../../concepts/trigger/cr-trigger.md), который будет вызывать функцию при создании и удалении [Docker-образов](../../../container-registry/concepts/docker-image.md) {{ container-registry-name }} или их [тегов](../../../container-registry/concepts/docker-image.md#version).

* Триггер для {{ cloud-logging-short-name }}

    Создайте [триггер для {{ cloud-logging-name }}](../../concepts/trigger/cloud-logging-trigger.md), который будет вызывать функцию при добавлении записей в [лог-группу](../../../logging/concepts/log-group.md).

* Триггер для {{ iot-full-name }}

    Создайте [триггер](../../concepts/trigger/iot-core-trigger.md) для топика [устройства](../../../iot-core/concepts/index.md#device), [реестра](../../../iot-core/concepts/index.md#registry) или [брокера](../../../iot-core/concepts/index.md#broker) {{ iot-name }} и обрабатывайте копии сообщений с помощью функции.

* Триггер для бюджетов

    Создайте [триггер для бюджетов](../../concepts/trigger/budget-trigger.md), который будет вызывать функцию при превышении пороговых значений.

* Триггер для {{ yds-short-name }}

     Создайте [триггер для {{ yds-name }}](../../concepts/trigger/data-streams-trigger.md), который будет вызывать функцию при отправке данных в [поток](../../../data-streams/concepts/glossary.md#stream-concepts).

* Триггер для почты

    Создайте [триггер для почты](../../concepts/trigger/mail-trigger.md), который будет вызывать функцию, когда на электронную почту приходит письмо.

## См. также

* [Пошаговые инструкции по созданию триггеров](../../operations/index.md#trigger-create)
* [Обзор триггеров в {{ sf-name }}](../../concepts/trigger/index.md)
