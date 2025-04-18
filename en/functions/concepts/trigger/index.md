---
title: Triggers in {{ sf-name }}. Overview
description: Triggers are criteria that automatically launch a function when met. With triggers, you can automate your work with other {{ yandex-cloud }} services, e.g., Yandex Object Storage, Yandex Message Queue, and Yandex IoT Core.
---

# Triggers in {{ sf-name }}. Overview

_Triggers_ are criteria that automatically launch a {{ sf-name }} [function](../function.md) when met. Triggers allow you to automate your work with other {{ yandex-cloud }} services, such as {{ objstorage-full-name }}, {{ message-queue-full-name }}, and {{ container-registry-full-name }}. 

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

The following types of triggers are available in {{ sf-name }}: 
* [Timer](timer.md)
* [Trigger for {{ message-queue-name }}](ymq-trigger.md)
* [Trigger for {{ objstorage-name }}](os-trigger.md)
* [Trigger for {{ container-registry-name }}](cr-trigger.md)
* [Trigger for {{ cloud-logging-name }}](cloud-logging-trigger.md)
* [Trigger for {{ iot-name }}](iot-core-trigger.md)
* [Trigger for budgets](budget-trigger.md)
* [Trigger for {{ yds-name }}](data-streams-trigger.md)
* [Email trigger](mail-trigger.md)

## Specifics of functions invoked by triggers {#invoke}

Triggers call functions based on preset [quotas and limits](../../../functions/concepts/limits.md).

When a function is called by a trigger, the following specifics apply:
- Functions are always called by triggers with the `?integration=raw` query string parameter. More about [function calls](../function-invoke.md).
- Before the trigger delivers messages to a function, it changes their format. Each trigger type uses a message format of its own. Read more about this in the relevant trigger description.

## Use cases {#examples}

* [{#T}](../../tutorials/data-recording.md)
* [{#T}](../../tutorials/events-from-postbox-to-yds.md)
* [{#T}](../../tutorials/logging-functions.md)
* [{#T}](../../tutorials/logging.md)
* [{#T}](../../tutorials/regular-launch-datasphere.md)
* [{#T}](../../tutorials/serverless-trigger-budget-vm.md)
* [{#T}](../../tutorials/video-converting-queue.md)

## See also {#see-also}

* [Triggers that run a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/index.md).
