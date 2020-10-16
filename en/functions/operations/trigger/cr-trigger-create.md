# Creating a trigger for {{ container-registry-name }}

{% include [triggers-preview](../../../_includes/functions/triggers-preview-stage.md) %}

Create a [trigger for {{ container-registry-name }}](../../concepts/trigger/cr-trigger.md) to call your function when a certain event occurs with your {{ container-registry-full-name }} [docker-image](../../../container-registry/concepts/docker-image.md).

{% include [before-begin](../../../_includes/functions/os-timer-before-begin.md) %}

## Create a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% include [cr-create](../../../_includes/functions/cr-create.md) %}