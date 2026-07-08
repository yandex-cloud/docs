---
title: Creating and enabling a trigger in {{ serverless-containers-full-name }}
description: In this article, you will learn how to create and enable a trigger in {{ serverless-containers-full-name }}.
---

# Creating and enabling a trigger in {{ serverless-containers-name }}

Triggers allow you to invoke a container in {{ serverless-containers-name }} at a specific event. For example, a [timer](../../concepts/trigger/timer.md) invokes a [container](../../concepts/container.md) on a user-defined schedule. You can find an example of a timer invoking a container in {{ serverless-containers-name }} every minute [here](../timer.md).

In addition to timers, the following types of triggers are available in {{ serverless-containers-name }}:

* Trigger for {{ message-queue-short-name }}

    Create a [trigger](../../concepts/trigger/ymq-trigger.md) for a [{{ message-queue-short-name }}](../../../message-queue/concepts/queue.md) and process messages using a container.

* Trigger for {{ objstorage-short-name }}

    Create a [trigger for {{ objstorage-name }}](../../concepts/trigger/os-trigger.md) that invokes a container when you create, move, or delete a bucket [object](../../../storage/concepts/object.md).

* Trigger for {{ container-registry-short-name }}

    Create a [trigger for {{ container-registry-name }}](../../concepts/trigger/cr-trigger.md) that invokes a container when you create or delete {{ container-registry-name }} [Docker images](../../../container-registry/concepts/docker-image.md) or Docker image [tags](../../../container-registry/concepts/docker-image.md#version).

* Trigger for {{ cloud-logging-short-name }}

    Create a [trigger for {{ cloud-logging-name }}](../../concepts/trigger/cloud-logging-trigger.md) that invokes a container whenever entries are added to a [log group](../../../logging/concepts/log-group.md).

* Trigger for {{ iot-full-name }}

    Create a [trigger](../../concepts/trigger/iot-core-trigger.md) for a {{ iot-name }} [device](../../../iot-core/concepts/index.md#device), [registry](../../../iot-core/concepts/index.md#registry), or [broker](../../../iot-core/concepts/index.md#broker) topic and process message copies using a container.

* Trigger for budgets

    Create a [trigger for budgets](../../concepts/trigger/budget-trigger.md) that invokes a container when threshold values are exceeded.

* Trigger for {{ yds-short-name }}

    Create a [trigger for {{ yds-name }}](../../concepts/trigger/data-streams-trigger.md) that invokes a container when data is sent to a [stream](../../../data-streams/concepts/glossary.md#stream-concepts).

* Email trigger

    Create an [email trigger](../../concepts/trigger/mail-trigger.md) that invokes a container when an email arrives.

## Useful links {#see-also}

* [Step-by-step guides on how to create triggers](../../operations/index.md#trigger-create)
* [{{ serverless-containers-full-name }} trigger overview](../../concepts/trigger/index.md)
