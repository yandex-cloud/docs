---
title: Инструкции по работе с {{ sf-full-name }}
description: Из статьи вы узнаете, как работать с {{ sf-full-name }} в {{ yandex-cloud }}. Рассказываем, как управлять функцией (создание, изменение, вызов и удаление функции), как управлять триггером (создание таймера, создание триггера для {{ message-queue-name }}, {{ iot-full-name }}, {{ container-registry-name }}).
---

# Пошаговые инструкции для {{ sf-name }}

* [{#T}](function-sa.md)
* [{#T}](database-connection.md)

## Получение информации о функции {#function-info}

* [{#T}](function/function-list.md)
* [{#T}](function/version-list.md)
* [{#T}](function/function-info.md)
* [{#T}](function/version-info.md)
* [Настроить параметры сервиса метаданных](function/metadata-options.md)

## Управление правами доступа к функции {#function-access-rights}

* [{#T}](function/function-public.md)
* [{#T}](function/function-private.md)
* [{#T}](function/role-list.md)
* [{#T}](function/role-add.md)
* [{#T}](function/role-revoke.md)

## Создание функции {#create-function}

* [{#T}](function/function-create.md)
* [{#T}](function/version-manage.md)

## Вызов функции {#function-invoke}

* [{#T}](function/function-invoke.md)
* [{#T}](function/function-invoke-async.md)
* [{#T}](function/auth.md)

## Управление функцией {#function-manage}

* [Изменить имя](function/name-update.md)
* [Изменить описание](function/description-update.md)
* [Посмотреть настройки масштабирования](function/scaling-settings-list.md)
* [Добавить настройки масштабирования](function/scaling-settings-add.md)
* [Удалить настройки масштабирования](function/scaling-settings-delete.md)
* [Добавить переменные окружения](function/environment-variables-add.md)
* [{#T}](function/network-add.md)
* [{#T}](function/lockbox-secret-transmit.md)
* [Выделить память для директории /tmp](function/allocate-memory-tmp.md)
* [Смонтировать бакеты](function/mount-bucket.md)
* [Смонтировать эфемерный диск](function/mount-ephemeral-disk.md)
* [Добавить тег](function/tag-add.md)
* [Удалить тег](function/tag-delete.md)
* [Добавить метку](function/label-add.md)
* [Изменить метку](function/label-update.md)
* [Удалить метку](function/label-delete.md)
* [Посмотреть графики мониторинга](function/function-monitoring.md)
* [Посмотреть логи](function/function-logs.md)
* [Записать логи в журнал выполнения](function/logs-write.md)
* [{#T}](function/migration.md)
* [{#T}](function/function-delete.md)


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
* [Добавить метку](trigger/label-add.md)
* [Изменить метку](trigger/label-update.md)
* [Удалить метку](trigger/label-delete.md)
* [Посмотреть графики мониторинга](trigger/trigger-monitoring.md)
* [Удалить триггер](trigger/trigger-delete.md)
