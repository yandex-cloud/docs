---
title: "Инструкции по работе с {{ api-gw-full-name }}"
description: "Из статьи вы узнаете, как работать с {{ api-gw-full-name }} в {{ yandex-cloud }}. Вы научитесь создавать, изменять и удалять API-шлюзы, а также просматривать график мониторинга и журнал выполнения."
---

# Пошаговые инструкции для {{ api-gw-name }}

* [{#T}](api-gw-create.md)

## Управление API-шлюзом {#manage-api-gw}

* [{#T}](api-gw-update.md)
* [{#T}](api-gw-domains.md)
* [{#T}](api-gw-network-add.md)
* [{#T}](api-gw-vars.md)
* [{#T}](api-gw-canary.md)
* [Посмотреть графики мониторинга](api-gw-monitoring.md)
* [Посмотреть журнал выполнения](api-gw-logs.md)
* [Записать логи в журнал выполнения](api-gw-logs-write.md)
* [{#T}](api-gw-domain-detach.md)
* [{#T}](api-gw-migration.md)
* [{#T}](api-gw-delete.md)

## Получение информации о триггере {#trigger-info}

* [Получить список триггеров](trigger/trigger-list.md)
* [Получить информацию о триггере](trigger/trigger-info.md)

## Создание триггера {#trigger-create}

* [Создать таймер](trigger/timer-create.md)
* [Создать триггер для {{ message-queue-name }}](trigger/ymq-trigger-create.md)
* [Создать триггер для {{ objstorage-name }}](trigger/os-trigger-create.md)
* [Создать триггер для {{ container-registry-name }}](trigger/cr-trigger-create.md)
* [Создать триггер для {{ cloud-logging-name }}](trigger/cloud-logging-trigger-create.md)
* [Создать триггер для {{ iot-name }} (устройство)](trigger/iot-core-trigger-create.md)
* [Создать триггер для {{ iot-name }} (брокер)](trigger/iot-core-trigger-broker-create.md)
* [Создать триггер для бюджетов](trigger/budget-trigger-create.md)
* [Создать триггер для {{ yds-name }}](trigger/data-streams-trigger-create.md)
* [Создать триггер для почты](trigger/mail-trigger-create.md)

## Управление триггером {#trigger-manage}

* [Изменить триггер](trigger/trigger-update.md)
* [Посмотреть графики мониторинга](trigger/trigger-monitoring.md)
* [Удалить триггер](trigger/trigger-delete.md)

## Конструктор спецификаций {#spec-constructor}

* [{{ sf-name }}](spec-constructor/cloud-functions.md)
* [Статический ответ](spec-constructor/dummy.md)
* [{{ objstorage-name }}](spec-constructor/object-storage.md)
* [{{ serverless-containers-name }}](spec-constructor/containers.md)
* [Обращение по HTTP](spec-constructor/http.md)
* [{{ message-queue-name }}](spec-constructor/ymq.md)
* [{{ yds-name }}](spec-constructor/datastreams.md)
* [{{ ydb-name }}](spec-constructor/ydb.md)
* [{{ ml-platform-name }}](spec-constructor/datasphere.md)
