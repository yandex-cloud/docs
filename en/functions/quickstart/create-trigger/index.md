---
title: Creating and enabling a trigger in {{ sf-full-name }}
description: In this tutorial, you will learn how to create and enable a trigger in {{ sf-name }}.
---

# Creating and enabling a trigger in {{ sf-name }}

Triggers allow you to invoke {{ sf-name }} functions at a specific event. For example, a [timer](../../concepts/trigger/timer.md) invokes a [function](../../concepts/function.md) on a custom schedule. [Here is an example of a timer invoking a {{ sf-name }} function every minute](./timer-quickstart.md).

In addition to timers, {{ sf-name }} features the following triggers:

* Trigger for {{ message-queue-short-name }}

   Create [a trigger](../../concepts/trigger/ymq-trigger.md) for a [message queue](../../../message-queue/concepts/queue.md) in {{ message-queue-short-name }} and process messages using a function.

* Trigger for {{ objstorage-short-name }}

   Create a [trigger for {{ objstorage-name }}](../../concepts/trigger/os-trigger.md) that invokes a function when you create, move, or delete an [object](../../../storage/concepts/object.md) in a bucket.

* Trigger for {{ container-registry-short-name }}

   Create a [trigger for {{ container-registry-name }}](../../concepts/trigger/cr-trigger.md) that invokes a function when you create or delete {{ container-registry-name }} [Docker images](../../../container-registry/concepts/docker-image.md) or Docker image [tags](../../../container-registry/concepts/docker-image.md#version).

* Trigger for {{ cloud-logging-short-name }}

   Create a [trigger for {{ cloud-logging-name }}](../../concepts/trigger/cloud-logging-trigger.md) that invokes a function when a record is added to a [log group](../../../logging/concepts/log-group.md).

* Trigger for {{ iot-full-name }}

   Create a [trigger](../../concepts/trigger/iot-core-trigger.md) for a {{ iot-name }} [device](../../../iot-core/concepts/index.md#device), [registry](../../../iot-core/concepts/index.md#registry), or [broker](../../../iot-core/concepts/index.md#broker) topic and process message copies using a function.

* Trigger for budgets

   Create a [trigger for budgets](../../concepts/trigger/budget-trigger.md) that invokes a function when threshold values are exceeded.

* Trigger for {{ yds-short-name }}

   Create a [trigger for {{ yds-name }}](../../concepts/trigger/data-streams-trigger.md) that invokes a function when data is sent to a [stream](../../../data-streams/concepts/glossary.md#stream-concepts).

* Email trigger

   Create an [email trigger](../../concepts/trigger/mail-trigger.md) that invokes a function when an email arrives.

## See also

* [Step-by-step guides on creating triggers](../../operations/index.md#trigger-create)
* [{{ sf-name }} trigger overview](../../concepts/trigger/index.md)
