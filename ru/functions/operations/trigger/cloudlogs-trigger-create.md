# Создание триггера для {{ cloud-logs-name }}

{% include [triggers-preview](../../../_includes/functions/triggers-preview-stage.md) %}

Создайте [триггер для {{ cloud-logs-name }}](../../concepts/trigger/cloudlogs-trigger.md), который будет вызывать вашу функцию при поступлении сообщений в [лог-группу](../../../functions/concepts/log-group.md).

{% include [before-begin](../../../_includes/functions/os-timer-before-begin.md) %}

## Создайте триггер {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% include [cloudlogs-trigger-create](../../../_includes/functions/cloudlogs-trigger-create.md) %}