---
title: "Резервное копирование в {{ sf-full-name }}"
description: "Данные в сервисе {{ sf-name }} надежно хранятся и реплицируются в инфраструктуре Yandex Cloud. Вы можете получить списки функций, списки версий функций, информацию о версиях функций, списки триггеров, информацию о триггерах."
---

# Резервное копирование в {{ sf-name }}

Данные в сервисе {{ sf-name }} надежно хранятся и реплицируются в инфраструктуре {{ yandex-cloud }}. Вы можете получить:
* [списки функций](#function-list);
* [списки версий функций](#version-list);
* [информацию о версиях функций](#version-get);
* [списки триггеров](#trigger-list);
* [информацию о триггерах](#trigger-get).

## Получить список функций {#function-list}

{% include [function-list](../../_includes/functions/function-list.md) %}

## Получить список версий функции {#version-list}

{% include [version-list](../../_includes/functions/version-list.md) %}

## Получить информацию о версии функции {#version-get}

{% note warning %}

Резервного копирования кода функции нет. Рекомендуем сохранять его самостоятельно.

{% endnote %}

{% include [version-list](../../_includes/functions/version-get.md) %}

## Получить список триггеров {#trigger-list}

{% include [version-list](../../_includes/functions/trigger-list.md) %}

## Получить информацию о триггере {#trigger-get}

{% include [version-list](../../_includes/functions/trigger-get.md) %}
