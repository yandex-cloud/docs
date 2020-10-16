# Создание триггера для {{ container-registry-name }}

{% include [triggers-preview](../../../_includes/functions/triggers-preview-stage.md) %}

Создайте [триггер для {{ container-registry-name }}](../../concepts/trigger/cr-trigger.md), который будет вызывать вашу функцию при операциях с [Docker-образами](../../../container-registry/concepts/docker-image.md) {{ container-registry-full-name }}.

{% include [before-begin](../../../_includes/functions/os-timer-before-begin.md) %}

## Создайте триггер {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% include [cr-create](../../../_includes/functions/cr-create.md) %}