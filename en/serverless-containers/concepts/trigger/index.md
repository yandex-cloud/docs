---
title: "Triggers. Overview"
description: "Triggers are the criteria that automatically invoke a container when met. Triggers enable you to automate your work with other {{ yandex-cloud }} services, such as Yandex Object Storage, Yandex Message Queue, and Yandex IoT Core."
---

# Triggers in {{ serverless-containers-name }} Overview

_Triggers_ are the criteria that automatically launch a {{ serverless-containers-name }} [container](../container.md) when met. Triggers let you automate your work with other {{ yandex-cloud }} services, such as {{ objstorage-full-name }}, {{ message-queue-full-name }}, and {{ iot-full-name }}.

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

The following types of triggers are available in {{ serverless-containers-name }}:
* [Timer](timer.md).
* [Trigger for {{ message-queue-name }}](ymq-trigger.md).
* [Trigger for {{ objstorage-name }}](os-trigger.md).
* [Trigger for {{ container-registry-name }}](cr-trigger.md).
* [Trigger for {{ cloud-logging-name }}](cloud-logging-trigger.md).
* [Trigger for {{ iot-name }}](iot-core-trigger.md).
* [Trigger for budgets](budget-trigger.md).
* [Trigger for {{ yds-name }}](data-streams-trigger.md).
* [Email trigger](mail-trigger.md).

## Specifics of container invocations by triggers {#invoke}

Triggers invoke containers based on preset [quotas and limits](../limits.md).

Before the trigger passes messages to a container, it changes their format. Each trigger has a specific message format. Read more about this in the trigger description.

## See also {#see-also_}

* [Triggers that invoke a {{ sf-name }} function](../../../functions/concepts/trigger/index.md).