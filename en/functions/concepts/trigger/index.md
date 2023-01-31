---
title: "Triggers. Overview"
description: "Triggers are criteria that automatically launch a function when met. Triggers let you automate your work with other {{ yandex-cloud }} services, such as Yandex Object Storage, Yandex Message Queue, and Yandex IoT Core."
---

# Triggers in {{ sf-name }}. Overview

_Triggers_ are criteria that automatically launch a {{ sf-name }} [function](../function.md) when met. Triggers let you automate your work with other {{ yandex-cloud }} services, such as {{ objstorage-full-name }}, {{ message-queue-full-name }}, and {{ iot-full-name }}.

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

The following types of triggers are available in {{ sf-name }}:
* [Timer](timer.md).
* [Trigger for {{ message-queue-name }}](ymq-trigger.md).
* [Trigger for {{ objstorage-name }}](os-trigger.md).
* [Trigger for {{ iot-name }}](iot-core-trigger.md).
* [Trigger for {{ container-registry-name }}](cr-trigger.md).
* [Trigger for {{ cloud-logging-name }}](cloud-logging-trigger.md).
* [Trigger for budgets](budget-trigger.md).
* [Trigger for {{ yds-name }}](data-streams-trigger.md).
* [Email trigger](mail-trigger.md).

## Specifics of functions invoked by triggers {#invoke}

Triggers call functions based on preset [quotas and limits](../../../functions/concepts/limits.md).

When a function is called by a trigger, the following specifics apply:
- Functions are always called by triggers with the `integration=raw` query string parameter. More about [function calls](../function-invoke.md).
- Before the trigger passes messages to a function, it changes their format. Each trigger has a specific message format. Read more about this in the trigger description.

## See also {#see-also}

* [Triggers that call a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/index.md).
