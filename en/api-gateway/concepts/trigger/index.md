---
title: Triggers in {{ api-gw-full-name }}. Overview
description: A trigger is a condition, upon meeting which an automatic message is sent to WebSocket connections. With triggers, you can automate your work with other {{ yandex-cloud }} services, e.g., Yandex Object Storage, Yandex Message Queue, and Yandex IoT Core.
---

# Triggers in {{ api-gw-full-name }}. Overview

A _trigger_ is a condition, upon meeting which an automatic message is sent to [WebSocket connections](../extensions/websocket.md) connected to the API gateway at the path specified by the user. The API gateway itself is not called.

A single trigger can simultaneously send messages to WebSocket connections of multiple API gateways, as well as invoke {{ sf-name }} and {{ serverless-containers-name }}.

Triggers allow you to automate your work with other {{ yandex-cloud }} services, such as {{ objstorage-full-name }}, {{ message-queue-full-name }}, and {{ container-registry-full-name }}.

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

The following types of triggers are available in {{ api-gw-full-name }}: 
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


## Things to consider about trigger messages {#invoke}

Triggers send messages based on preset [quotas and limits](../limits.md).

You need to consider the following points:
* The trigger reformats messages before sending them to WebSocket connections. Each trigger type uses a message format of its own. Read more about this in the relevant trigger description.
* If sending fails or the path specified in the trigger settings has no clients connected, the message gets lost and resending is not possible.
* The service account you are going to use to send messages to WebSocket connections must have the `{{ roles-functions-invoker }}` role. Other roles required for the trigger to operate correctly depend on trigger type. For more details, see the relevant trigger description.

{% include [trigger-filter-messages](../../../_includes/functions/trigger-filter-messages.md) %}

{% include [trigger-transform-messages](../../../_includes/functions/trigger-transform-messages.md) %}

{% include [batching-events](../../../_includes/functions/batching-events.md) %}

## Useful links {#see-also}

* [Triggers to run a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/index.md)
* [Triggers that run a {{ sf-name }} function](../../../functions/concepts/trigger/index.md)
