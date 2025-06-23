---
title: Triggers in {{ api-gw-full-name }}. Overview
description: A trigger is a condition, upon meeting which an automatic message is sent to WebSocket connections. With triggers, you can automate your work with other {{ yandex-cloud }} services, e.g., Yandex Object Storage, Yandex Message Queue, and Yandex IoT Core.
---

# Triggers in {{ api-gw-full-name }}. Overview

A _trigger_ is a condition, upon meeting which an automatic message is sent to [WebSocket connections](../extensions/websocket.md) connected to the API gateway at the path specified by the user. The API gateway itself is not called.

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

{% include [trigger-intro-note](../../../_includes/functions/trigger-intro-note.md) %}


## Things to consider about trigger messages {#invoke}

Triggers send messages based on preset [quotas and limits](../limits.md).

You need to consider the following points:
* The trigger reformats messages before sending them to WebSocket connections. Each trigger type uses a message format of its own. Read more about this in the relevant trigger description.
* If sending fails or the path specified in the trigger settings has no clients connected, the message gets lost and resending is not possible.
* The service account you are going to use to send messages to WebSocket connections must have the `{{ roles-functions-invoker }}` role. Other roles required for the trigger to operate correctly depend on trigger type. Read more about this in the relevant trigger description.


## Message batching {#batch-messages}

You can configure the following triggers to batch messages before sending them to WebSocket connections:

* Trigger for {{ message-queue-name }}
* Trigger for {{ cloud-logging-name }}
* Trigger for {{ objstorage-name }}
* Trigger for {{ container-registry-name }}
* Trigger for {{ iot-name }}
* Trigger for {{ yds-name }}
* Email trigger

This will allow sending messages as a batch rather than one by one. Specify the following in the trigger parameters:

* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cutoff }}**: Message batching time. The number of messages cannot exceed the specified batch size.
* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}**: Number of messages for batching.

For more information about message batching, see the guides for creating the relevant trigger.


## See also {#see-also}

* [Triggers to run a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/index.md)
* [Triggers that run a {{ sf-name }} function](../../../functions/concepts/trigger/index.md)
