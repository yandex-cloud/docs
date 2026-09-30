---
title: Triggers in {{ serverless-containers-name }}. Overview
description: A trigger is a condition which, when met, automatically starts a container. Triggers allow you to automate your work with other {{ yandex-cloud }} services, such as {{ objstorage-full-name }}, {{ message-queue-full-name }}, and {{ iot-full-name }}.
---

# Triggers in {{ serverless-containers-name }}. Overview

A _trigger_ is a condition which, when met, automatically invokes a {{ serverless-containers-name }} [container](../container.md). A single trigger can invoke several {{ serverless-containers-name }} containers and {{ sf-name }} functions at the same time and send messages to WebSocket connections of one or more {{ api-gw-full-name }} API gateways; the recipient types can be combined.

Triggers allow you to automate your work with other {{ yandex-cloud }} services, such as {{ objstorage-full-name }}, {{ message-queue-full-name }}, and {{ container-registry-full-name }}.

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
* [Trigger for Telegram](telegram-trigger.md)

{% include [trigger-intro-note](../../../_includes/functions/trigger-intro-note.md) %}

## Specifics of container invocations by triggers {#invoke}

Triggers invoke a container based on preset [quotas and limits](../limits.md).

When invoking a container with a trigger, the following considerations apply:

* You need to configure the container to return the `2xx` state code if invoked successfully. Other state codes will be interpreted as an invocation error followed by a retry attempt to invoke the container.
* Before delivering messages to the container, the trigger changes their format. Each trigger type uses a message format of its own. For more details, see the relevant trigger description.
* The service account which will invoke the container must have the `{{ roles-serverless-containers-invoker }}` role. Other roles required for the trigger to operate correctly depend on trigger type. For more details, see the relevant trigger description.
* If the trigger is suspended and then restarted by the user, it will not process any events that occurred during its idle time.

{% include [trigger-filter-messages](../../../_includes/functions/trigger-filter-messages.md) %}

{% include [trigger-transform-messages](../../../_includes/functions/trigger-transform-messages.md) %}

{% include [batching-events](../../../_includes/functions/batching-events.md) %}

## Container invocation retries {#invoke-retry}

You can configure invoking a container again if the current attempt fails. Specify the following in the trigger parameters:

* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-interval }}**: Invocation retry interval.
* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-attempts }}**: Number of container invocation retries before the trigger moves a message to the [dead letter queue](../dlq.md).

This setting is available for all trigger types except the one for {{ message-queue-name }}.

For more information about invocation retries, see the guide for creating the relevant trigger.

## Useful links {#see-also_}

* [Triggers that run a {{ sf-name }}](../../../functions/concepts/trigger/index.md) function
* [Triggers for sending messages to WebSocket connections](../../../api-gateway/concepts/trigger/index.md)
