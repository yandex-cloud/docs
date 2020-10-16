# Создание триггера для {{ container-registry-full-name }}

{% include [triggers-preview](../../_includes/functions/triggers-preview-stage.md) %}

Создайте [триггер для {{ container-registry-name }}](../concepts/trigger/cr-trigger.md), который запускает вашу функцию при операциях с [Docker-образами](../../container-registry/concepts/docker-image.md).

{% include [before-begin](../../_includes/functions/os-timer-before-begin.md) %}

## Создайте триггер {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% include [cr-create-ui](../../_includes/functions/cr-create.md) %}

## Что дальше {#what-is-next}

- Ознакомьтесь с [концепциями триггеров](../concepts/trigger/index.md).
- Прочитайте подробнее о [триггере для {{ container-registry-name }}](../concepts/trigger/cr-trigger.md).
- Посмотрите, что можно делать с триггерами в [пошаговых инструкциях](../operations/index.md).
