# Overview

{% include [triggers-preview](../../../_includes/functions/triggers-preview-stage.md) %}

_Triggers_ are the criteria which automatically launch a specific function when met. Triggers let you automate your work with other Yandex.Cloud services, for example: {{ sf-full-name }}, {{message-queue-full-name}}, and {{ iot-full-name }}.

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

You can set up the following types of triggers at the Preview stage:

* [{#T}](timer.md).
* [{#T}](ymq-trigger.md).
* [{#T}](os-trigger.md).
* [{#T}](iot-core-trigger.md).
* [{#T}](cr-trigger.md).
* [{#T}](cloudlogs-trigger.md).


## Specifics of functions invoked by triggers {#invoke}

Triggers call functions based on the preset [quotas and limits](../../../functions/concepts/limits.md).

When a function is called by a trigger, the following specifics apply:

- Functions are always called by triggers with the `integration=raw` query string parameter. Read more about [function calls](../function-invoke.md).
- Before the trigger passes messages to a function it changes their format. Each trigger has a specific message format. Read more about this in the trigger description.

