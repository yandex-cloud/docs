---
title: Triggers in {{ sf-name }}. Overview
description: A trigger is a condition which, when met, automatically starts a function. With triggers, you can automate your work with other {{ yandex-cloud }} services, e.g., Yandex Object Storage, Yandex Message Queue, and Yandex IoT Core.
---

# Triggers in {{ sf-name }}. Overview

A _trigger_ is a condition which, when met, automatically invokes a {{ sf-name }} [function](../function.md).

A single trigger can invoke several {{ sf-name }} functions and {{ serverless-containers-name }} containers at the same time and send messages to WebSocket connections of one or more {{ api-gw-full-name }} API gateways.

Triggers allow you to automate your work with other {{ yandex-cloud }} services, such as {{ objstorage-full-name }}, {{ message-queue-full-name }}, and {{ container-registry-full-name }}.

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
* [Trigger for Telegram](telegram-trigger.md)

{% include [trigger-intro-note](../../../_includes/functions/trigger-intro-note.md) %}

## Specifics of functions invoked by triggers {#invoke}

Triggers call functions based on preset [quotas and limits](../../../functions/concepts/limits.md).

When a function is called by a trigger, the following specifics apply:
- Functions are always called by triggers with the `?integration=raw` query string parameter. For more on function calls, see [{#T}](../function-invoke.md).
- Before the trigger delivers messages to a function, it changes their format. Each trigger type uses a message format of its own. For more details, see the relevant trigger description.
- The service account used to invoke the function needs the `{{ roles-functions-invoker }}` role. Other roles required for the trigger to operate correctly depend on trigger type. For more details, see the relevant trigger description.
- If the trigger is suspended and then restarted by the user, it will not process any events that occurred during its idle time.

{% include [trigger-filter-messages](../../../_includes/functions/trigger-filter-messages.md) %}

{% include [trigger-transform-messages](../../../_includes/functions/trigger-transform-messages.md) %}

{% include [batching-events](../../../_includes/functions/batching-events.md) %}

## Function invocation retries {#invoke-retry}

You can configure invoking a function again if the current attempt fails. To do this, in the trigger parameters, specify as follows:

* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-interval }}**: Invocation retry interval.
* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-attempts }}**: Number of invocation retries before the trigger sends a message to the [dead letter queue](../dlq.md).

This setting is available for all trigger types except the trigger for {{ message-queue-name }}.

For more information about invocation retries, see the guide for creating the relevant trigger.

## Use cases {#examples}

* [{#T}](../../tutorials/data-recording.md)
* [{#T}](../../tutorials/events-from-postbox-to-yds.md)
* [{#T}](../../tutorials/logging-functions.md)
* [{#T}](../../tutorials/logging.md)
* [{#T}](../../tutorials/regular-launch-datasphere.md)
* [{#T}](../../tutorials/serverless-trigger-budget-vm.md)
* [{#T}](../../tutorials/video-converting-queue/index.md)

## Useful links {#see-also}

* [Triggers to run a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/index.md)
* [Triggers to send messages to WebSocket connections](../../../api-gateway/concepts/trigger/index.md)
