---
title: "Triggers. Overview"
description: "A trigger is a condition that, when met, causes a message to be automatically sent to WebSocket connections. Triggers enable you to automate your work with other {{ yandex-cloud }} services, such as Yandex Object Storage, Yandex Message Queue, and Yandex IoT Core."
---

# Triggers in {{ api-gw-full-name }} Overview

A _trigger_ is a condition that, when met, causes a message to be automatically sent to [WebSocket connections](../extensions/websocket.md). Triggers let you automate your work with other {{ yandex-cloud }} services, such as {{ objstorage-full-name }}, {{ message-queue-full-name }}, and {{ container-registry-full-name }}.

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

## Things to consider about trigger messages {#invoke}

Triggers send messages based on preset [quotas and limits](../limits.md).

Things to consider about trigger messages:
* The trigger reformats messages before sending them to WebSocket connections. Each trigger type uses a message format of its own. Read more about this in the trigger description.
* If sending fails or the path specified in the trigger settings has no clients connected, the message gets lost and resending is not possible.

## See also {#see-also}

* [Triggers that invoke a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/index.md)
* [Triggers that invoke a {{ sf-name }} function](../../../functions/concepts/trigger/index.md)
