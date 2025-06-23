---
title: Triggers in {{ serverless-containers-name }}. Overview
description: Triggers are criteria that automatically invoke a container when met. Triggers allow you to automate your work with other {{ yandex-cloud }} services, such as {{ objstorage-full-name }}, {{ message-queue-full-name }}, and {{ iot-full-name }}.
---

# Triggers in {{ serverless-containers-name }}. Overview

_Triggers_ are criteria that automatically launch a {{ serverless-containers-name }} [container](../container.md) when met. Triggers allow you to automate your work with other {{ yandex-cloud }} services, such as {{ objstorage-full-name }}, {{ message-queue-full-name }}, and {{ container-registry-full-name }}. 

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

The following types of triggers are available in {{ serverless-containers-name }}: 
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

## Specifics of container invocations by triggers {#invoke}

Triggers invoke a container based on preset [quotas and limits](../limits.md).

When invoking a container with a trigger, the following considerations apply:

* You need to configure the container to return the `2xx` state code if invoked successfully. Other state codes will be interpreted as an invocation error followed by a retry attempt to invoke the container.
* Before delivering messages to the container, the trigger changes their format. Each trigger type uses a message format of its own. Read more about this in the relevant trigger description.
* The service account which will invoke the container must have the `{{ roles-serverless-containers-invoker }}` role. Other roles required for the trigger to operate correctly depend on trigger type. Read more about this in the relevant trigger description.
* If the trigger is suspended and then restarted by the user, it will not process any events that occurred during its idle time.

## Message batching {#batch-messages}

You can configure the following triggers to batch messages before invoking a container:

* Trigger for {{ message-queue-name }}
* Trigger for {{ cloud-logging-name }}
* Trigger for {{ objstorage-name }}
* Trigger for {{ container-registry-name }}
* Trigger for {{ iot-name }}
* Trigger for {{ yds-name }}
* Email trigger

This way you can invoke a container for a whole batch of messages rather than each message separately. Specify the following in the trigger parameters:

* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cutoff }}**: Message batching time. The number of messages cannot exceed the specified batch size.
* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}**: Number of messages for batching.

For more information about message batching, see the guides for creating the relevant trigger.

## Container invocation retries {#invoke-retry}

You can configure invoking a container again if the current attempt fails. Specify the following in the trigger parameters:

* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-interval }}**: Invocation retry interval.
* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-attempts }}**: Number of container invocation retries before the trigger moves a message to the [dead letter queue](../dlq.md).

This setting is available for all trigger types except the trigger for {{ message-queue-name }}.

For more information about invocation retries, see the guide for creating the relevant trigger.

## See also {#see-also_}

* [Triggers that run a {{ sf-name }}](../../../functions/concepts/trigger/index.md) function
* [Triggers to send messages to WebSocket connections](../../../api-gateway/concepts/trigger/index.md)
