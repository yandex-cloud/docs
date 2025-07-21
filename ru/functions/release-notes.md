---
title: История изменений в {{ sf-full-name }}
description: В разделе представлена история изменений сервиса {{ sf-name }}.
---

# История изменений в {{ sf-full-name }}

## Июнь 2025 {#june-2025}

### Обновления {#updates}

* Добавлена поддержка Node.js 22 и Go 1.23.

## Февраль 2025 {#february-2025}

### Обновления {#updates}

* Добавлена поддержка [настройки параметров сервиса метаданных функции](operations/function/metadata-options.md).

## Сентябрь — октябрь 2024 {#sept-oct-2024}

### Обновления {#updates}

* Добавлена поддержка [долгоживущих функций](concepts/long-lived-functions.md).
* Добавлена поддержка отправки [уведомлений о завершении выполнения функции](concepts/termination-notifications.md).
* Добавлена поддержка [монтирования эфемерных дисков](concepts/mounting.md#mount-ephemeral-storage).
* Добавлена поддержка [одновременных вызовов одного экземпляра функции](concepts/function.md#concurrency).

## Август 2024 {#august-2024}

### Обновления {#updates}

* Добавлена поддержка среды выполнения [Kotlin](lang/kotlin/index.md).

## Май — июнь 2024 {#may-june-2024}

### Обновления {#updates}

* Добавлена поддержка параметра `concurrency` в CLI, API и {{ TF }}.

### Исправления и улучшения {#fixes-improvements}

* Исправлена ошибка, возникающая при создании версий функции со средой выполнения `golang`, которые используют пакет [opentracing-go](https://github.com/opentracing/opentracing-go).

## Апрель 2024 {#april-2024}

### Обновления {#updates}

* Добавлена поддержка [выделения оперативной памяти для директории /tmp](operations/function/allocate-memory-tmp.md) для версии функции, объем памяти которой не менее 1 ГБ.

### Исправления и улучшения {#fixes-improvements}

* Исправлена ошибка импорта `yandex_function_scaling_policy` в {{ TF }}.
* Удалено требование для [пользовательской сети](concepts/networking#user-network) иметь подсеть в зоне доступности `ru-central1-c` в связи с [выводом этой зоны из эксплуатации](../overview/concepts/region.md).

## Март 2024 {#march-2024}

### Обновления {#updates}

* Добавлена поддержка редактирования всех параметров триггеров в {{ TF }}.
* [Монтирование бакетов {{ objstorage-full-name }}](concepts/mounting.md) в функцию перешло на [стадию General Availability](../overview/concepts/launch-stages.md).

### Исправления и улучшения {#fixes-improvements}

* Максимальный размер группы в [триггере для {{ message-queue-full-name }}](concepts/trigger/ymq-trigger.md) увеличен до 1000 сообщений.

## Январь — февраль 2024 {#jan-feb-2024}

### Обновления {#updates}

* Добавлена поддержка [монтирования бакетов {{ objstorage-full-name }}](concepts/mounting.md) в функцию в CLI и {{ TF }}.
* Добавлена поддержка настроек логирования для функции в {{ TF }}.

### Исправления и улучшения {#fixes-improvements}

* Исправлена ошибка отображения квоты на количество тегов функции.
