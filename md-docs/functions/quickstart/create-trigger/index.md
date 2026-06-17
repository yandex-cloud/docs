# Создание и запуск триггера в Cloud Functions

Триггеры позволяют вызывать функции Cloud Functions при наступлении определенных событий. Например, [таймер](../../concepts/trigger/timer.md) вызывает [функцию](../../concepts/function.md) по заданному пользователем расписанию. [Пример создания таймера, который вызывает функцию Cloud Functions каждую минуту](timer-quickstart.md).

Кроме таймера, в Cloud Functions доступны следующие триггеры:

* Триггер для Message Queue

    Создайте [триггер](../../concepts/trigger/ymq-trigger.md) для [очереди сообщений](../../../message-queue/concepts/queue.md) сервиса Message Queue и обрабатывайте их с помощью функции.

* Триггер для Object Storage

    Создайте [триггер для Object Storage](../../concepts/trigger/os-trigger.md), который будет вызывать функцию при создании, перемещении или удалении [объекта](../../../storage/concepts/object.md) в бакете.

* Триггер для Container Registry

     Создайте [триггер для Container Registry](../../concepts/trigger/cr-trigger.md), который будет вызывать функцию при создании и удалении [Docker-образов](../../../container-registry/concepts/docker-image.md) Container Registry или их [тегов](../../../container-registry/concepts/docker-image.md#version).

* Триггер для Cloud Logging

    Создайте [триггер для Cloud Logging](../../concepts/trigger/cloud-logging-trigger.md), который будет вызывать функцию при добавлении записей в [лог-группу](../../../logging/concepts/log-group.md).

* Триггер для Yandex IoT Core

    Создайте [триггер](../../concepts/trigger/iot-core-trigger.md) для топика [устройства](../../../iot-core/concepts/index.md#device), [реестра](../../../iot-core/concepts/index.md#registry) или [брокера](../../../iot-core/concepts/index.md#broker) Yandex IoT Core и обрабатывайте копии сообщений с помощью функции.

* Триггер для бюджетов

    Создайте [триггер для бюджетов](../../concepts/trigger/budget-trigger.md), который будет вызывать функцию при превышении пороговых значений.

* Триггер для Data Streams

     Создайте [триггер для Data Streams](../../concepts/trigger/data-streams-trigger.md), который будет вызывать функцию при отправке данных в [поток](../../../data-streams/concepts/glossary.md#stream-concepts).

* Триггер для почты

    Создайте [триггер для почты](../../concepts/trigger/mail-trigger.md), который будет вызывать функцию, когда на электронную почту приходит письмо.

## Полезные ссылки {#see-also}

* [Пошаговые инструкции по созданию триггеров](../../operations/index.md#trigger-create)
* [Обзор триггеров в Cloud Functions](../../concepts/trigger/index.md)