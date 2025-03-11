---
title: История изменений в {{ serverless-containers-full-name }}
description: В разделе представлена история изменений сервиса {{ serverless-containers-name }}.
---

# История изменений в {{ serverless-containers-full-name }}

## Февраль 2025 {#february-2025}

### Обновления {#updates}

* Добавлена поддержка [настройки параметров сервиса метаданных контейнера](operations/metadata-options.md).

## Декабрь 2024 {#december-2024}

### Обновления {#updates}

* Добавлена поддержка выбора [режима работы контейнера](operations/update-runtime.md#console_1) в консоли управления.

## Ноябрь 2024 {#november-2024}

### Обновления {#updates}

* Добавлена поддержка выбора [режима работы контейнера](operations/update-runtime.md) в CLI, API и {{ TF }}.

## Сентябрь — октябрь 2024 {#sept-oct-2024}

### Обновления {#updates}

* Добавлена поддержка [долгоживущих контейнеров](concepts/long-lived-containers.md).
* Добавлена поддержка отправки [уведомлений о завершении выполнения контейнера](concepts/termination-notifications.md).
* Добавлена поддержка [монтирования эфемерных дисков](concepts/mounting.md#mount-ephemeral-storage).

## Апрель 2024 {#april-2024}

### Исправления и улучшения {#fixes-improvements}

* Удалено требование для [пользовательской сети](concepts/networking#user-network) иметь подсеть в зоне доступности `ru-central1-c` в связи с [выводом этой зоны из эксплуатации](../overview/concepts/ru-central1-c-deprecation).

## Март 2024 {#march-2024}

### Обновления {#updates}

* Добавлена поддержка редактирования всех параметров триггеров в {{ TF }}.
* [Монтирование бакетов {{ objstorage-full-name }}](concepts/mounting.md) в контейнер перешло на [стадию General Availability](../overview/concepts/launch-stages.md).

### Исправления и улучшения {#fixes-improvements}

* Максимальный размер группы в [триггере для {{ message-queue-full-name }}](concepts/trigger/ymq-trigger.md) увеличен до 1000 сообщений.

## Январь — февраль 2024 {#jan-feb-2024}

### Обновления {#updates}

* Добавлена поддержка настроек логирования для контейнера в {{ TF }}.
* Добавлена поддержка [монтирования бакетов {{ objstorage-full-name }}](concepts/mounting.md) в контейнер в CLI и {{ TF }}.
