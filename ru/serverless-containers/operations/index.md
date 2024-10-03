---
title: Инструкции по работе с {{ serverless-containers-full-name }}
description: Из статьи вы узнаете, как работать с управляемым сервисом {{ serverless-containers-full-name }} в {{ yandex-cloud }}.
---

# Все инструкции для {{ serverless-containers-name }}

* [Получение IAM-токена сервисного аккаунта с помощью контейнера](./sa.md)

## Получение информации о контейнере {#get-container}

* [{#T}](./list.md)
* [{#T}](./revision-list.md)
* [{#T}](./container-info.md)
* [{#T}](./revision-info.md)

## Управление правами доступа к контейнеру {#manage-access-rights-container}

* [{#T}](./container-public.md)
* [{#T}](./container-private.md)
* [{#T}](./role-list.md)
* [{#T}](./role-add.md)
* [{#T}](./role-revoke.md)

## Создание контейнера {#create-container}

* [{#T}](./create.md)
* [{#T}](./manage-revision.md)

## Вызов контейнера {#invoke-container}

* [{#T}](./invoke.md)
* [{#T}](./invocation-link.md)

## Управление контейнером {#manage-container}

* [Изменить имя](./name-update.md)
* [Изменить описание](./description-update.md)
* [Сделать ревизию активной](./activate-revision.md)
* [Посмотреть настройки масштабирования](./scaling-settings-list.md)
* [Добавить настройки масштабирования](./scaling-settings-add.md)
* [Удалить настройки масштабирования](./scaling-settings-delete.md)
* [Добавить переменные окружения](./environment-variables-add.md)
* [{#T}](./network-add.md)
* [{#T}](./lockbox-secret-transmit.md)
* [Смонтировать бакеты](./mount-bucket.md)
* [Смонтировать эфемерный диск](./mount-ephemeral-disk.md)
* [Добавить метку](./label-add.md)
* [Изменить метку](./label-update.md)
* [Удалить метку](./label-delete.md)
* [Посмотреть графики мониторинга](./monitoring.md)
* [Посмотреть логи](./logs.md)
* [Записать логи в журнал выполнения](./logs-write.md)
* [{#T}](./migration.md)
* [{#T}](./delete.md)

## Получение информации о триггере {#get-trigger}

* [Получить список триггеров](./trigger-list.md)
* [Получить информацию о триггере](./trigger-info.md)

## Создание триггера {#create-trigger}

* [Создать таймер](./timer-create.md)
* [Создать триггер для {{ message-queue-name }}](./ymq-trigger-create.md)
* [Создать триггер для {{ objstorage-name }}](./os-trigger-create.md)
* [Создать триггер для {{ container-registry-name }}](./cr-trigger-create.md)
* [Создать триггер для {{ cloud-logging-name }}](./cloud-logging-trigger-create.md)
* [Создать триггер для {{ iot-name }} (устройство)](./iot-core-trigger-create.md)
* [Создать триггер для {{ iot-name }} (брокер)](./iot-core-trigger-broker-create.md)
* [Создать триггер для бюджетов](./budget-trigger-create.md)
* [Создать триггер для {{ yds-name }}](./data-streams-trigger-create.md)
* [Создать триггер для почты](./mail-trigger-create.md)

## Управление триггером {#manage-trigger}

* [Изменить триггер](./trigger-update.md)
* [Посмотреть графики мониторинга](./trigger-monitoring.md)
* [Удалить триггер](./trigger-delete.md)
