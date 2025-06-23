---
title: Triggers in {{ sf-name }}. Overview
description: A trigger is a criterion that automatically starts a function when met. With triggers, you can automate your work with other {{ yandex-cloud }} services, e.g., Yandex Object Storage, Yandex Message Queue, and Yandex IoT Core.
---

# Triggers in {{ sf-name }}. Overview

_Triggers_ are criteria that automatically start a {{ sf-name }} [function](../function.md) when met. Triggers allow you to automate your work with other {{ yandex-cloud }} services, such as {{ objstorage-full-name }}, {{ message-queue-full-name }}, and {{ container-registry-full-name }}. 

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

{% include [trigger-intro-note](../../../_includes/functions/trigger-intro-note.md) %}

## Specifics of functions invoked by triggers {#invoke}

Triggers call functions based on preset [quotas and limits](../../../functions/concepts/limits.md).

When a function is called by a trigger, the following specifics apply:
- Functions are always called by triggers with the `?integration=raw` query string parameter. To learn more about function calls, see [this guide](../function-invoke.md).
- Before the trigger delivers messages to a function, it changes their format. Each trigger type uses a message format of its own. Read more about this in the relevant trigger description.
- The service account used to invoke the function needs the `{{ roles-functions-invoker }}` role. Other roles required for the trigger to operate correctly depend on trigger type. Read more about this in the relevant trigger description.
- If the trigger is suspended and then restarted by the user, it will not process any events that occurred during its idle time.

## Message batching {#batch-messages}

You can configure the following triggers to batch messages before calling a function:

* Trigger for {{ message-queue-name }}
* Trigger for {{ cloud-logging-name }}
* Trigger for {{ objstorage-name }}
* Trigger for {{ container-registry-name }}
* Trigger for {{ iot-name }}
* Trigger for {{ yds-name }}
* Email trigger

This way you can call a function for a whole batch of messages rather than each message separately. Specify the following in the trigger parameters:

* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cutoff }}**: Message batching time. The number of messages cannot exceed the specified batch size.
* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}**: Number of messages for batching.

For more information about message batching, see the guides for creating the relevant trigger.

## Function invocation retries {#invoke-retry}

You can configure invoking a function again if the current attempt fails. Specify the following in the trigger parameters:

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
* [{#T}](../../tutorials/video-converting-queue.md)

## See also {#see-also}

* [Triggers to run a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/index.md)
* [Triggers to send messages to WebSocket connections](../../../api-gateway/concepts/trigger/index.md)
