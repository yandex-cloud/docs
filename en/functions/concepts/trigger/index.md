---
title: Trigger. Overview
description: 'Trigger — a condition, when executed, a certain function is automatically launched. Triggers allow you to automate work with other Yandex.Cloud services, for example — Yandex Object Storage, Yandex Message Queue and Yandex IoT Core. '
---

# Trigger. Overview

_Triggers_ are the criteria that automatically launch a specific function when met. Triggers let you automate your work with other {{ yandex-cloud }} services, such as {{ objstorage-full-name }}, {{ message-queue-full-name }}, and {{ iot-full-name }}.

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

The following types of triggers are available in {{ sf-name }}:

* [Timer](timer.md).
* [Trigger for {{ message-queue-name }}](ymq-trigger.md).
* [Trigger for {{ objstorage-name }}](os-trigger.md).
* [Trigger for {{ iot-name }}](iot-core-trigger.md).
* [Trigger for {{ container-registry-name }}](cr-trigger.md).
* [Trigger for {{ cloud-logs-name }}](cloudlogs-trigger.md).

## Specifics of functions invoked by triggers {#invoke}

Triggers call functions based on the preset [quotas and limits](../../../functions/concepts/limits.md).

When a function is called by a trigger, the following specifics apply:

- Functions are always called by triggers with the `integration=raw` query string parameter. Read more about [function calls](../function-invoke.md).
- Before the trigger passes messages to a function, it changes their format. Each trigger has a specific message format. Read more about this in the trigger description.

