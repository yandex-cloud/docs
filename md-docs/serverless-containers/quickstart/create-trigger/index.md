# Создание и запуск триггера в Serverless Containers

Триггеры позволяют вызывать контейнер Serverless Containers при наступлении определенных событий. Например, [таймер](../../concepts/trigger/timer.md) вызывает [контейнер](../../concepts/container.md) по заданному пользователем расписанию. [Пример создания таймера, который вызывает контейнер Serverless Containers каждую минуту](../timer.md).

Кроме таймера, в Serverless Containers доступны следующие триггеры:

* Триггер для Message Queue

    Создайте [триггер](../../concepts/trigger/ymq-trigger.md) для [очереди сообщений](../../../message-queue/concepts/queue.md) сервиса Message Queue и обрабатывайте их с помощью контейнера.

* Триггер для Object Storage

    Создайте [триггер для Object Storage](../../concepts/trigger/os-trigger.md), который будет вызывать контейнер при создании, перемещении или удалении [объекта](../../../storage/concepts/object.md) в бакете.

* Триггер для Container Registry

    Создайте [триггер для Container Registry](../../concepts/trigger/cr-trigger.md), который будет вызывать контейнер при создании и удалении [Docker-образов](../../../container-registry/concepts/docker-image.md) Container Registry или их [тегов](../../../container-registry/concepts/docker-image.md#version).

* Триггер для Cloud Logging

    Создайте [триггер для Cloud Logging](../../concepts/trigger/cloud-logging-trigger.md), который будет вызывать контейнер при добавлении записей в [лог-группу](../../../logging/concepts/log-group.md).

* Триггер для Yandex IoT Core

    Создайте [триггер](../../concepts/trigger/iot-core-trigger.md) для топика [устройства](../../../iot-core/concepts/index.md#device), [реестра](../../../iot-core/concepts/index.md#registry) или [брокера](../../../iot-core/concepts/index.md#broker) Yandex IoT Core и обрабатывайте копии сообщений с помощью контейнера.

* Триггер для бюджетов

    Создайте [триггер для бюджетов](../../concepts/trigger/budget-trigger.md), который будет вызывать контейнер при превышении пороговых значений.

* Триггер для Data Streams

    Создайте [триггер для Data Streams](../../concepts/trigger/data-streams-trigger.md), который будет вызывать контейнер при отправке данных в [поток](../../../data-streams/concepts/glossary.md#stream-concepts).

* Триггер для почты

    Создайте [триггер для почты](../../concepts/trigger/mail-trigger.md), который будет вызывать контейнер, когда на электронную почту приходит письмо.

## См. также

* [Пошаговые инструкции по созданию триггеров](../../operations/index.md#trigger-create)
* [Обзор триггеров в Yandex Serverless Containers](../../concepts/trigger/index.md)