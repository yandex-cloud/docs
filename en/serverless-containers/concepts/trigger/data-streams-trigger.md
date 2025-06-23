---
title: Trigger for {{ yds-full-name }} that invokes a {{ serverless-containers-full-name }} container
description: In this article, you will learn about the trigger for {{ yds-name }} that invokes a {{ serverless-containers-name }} container, the roles the trigger needs to operate correctly, and the trigger's message format.
---

# Trigger for {{ yds-name }} that invokes a {{ serverless-containers-name }} container

 [Trigger](../trigger/) for {{ yds-name }} calls a {{ serverless-containers-name }} [container](../container.md) when data is sent to a [stream](../../../data-streams/concepts/glossary.md#stream-concepts). 

A trigger for {{ yds-name }} needs [service accounts](../../../iam/concepts/users/service-accounts.md) to manage a stream and invoke a container. You can use the same service account for both operations.

For more information about creating a trigger for {{ yds-name }}, see [{#T}](../../operations/data-streams-trigger-create.md).

{% include [batching-messages](../../../_includes/serverless-containers/batching-messages.md) %}

## Roles required for the proper operation of a trigger for {{ yds-name }} {#roles}

* To create a trigger, you need a permission for the service account under which the trigger runs the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles or higher.
* For the trigger to fire, service accounts need the following roles:
    * `serverless.containers.invoker` for the container the trigger invokes.
    * `yds.admin` for the stream that invokes the trigger when data is sent there.

## Format of the message from the trigger for {{ yds-name }} {#format}

{% include [trigger-message-format-note](../../../_includes/functions/trigger-message-format-note.md) %}

Once the trigger fires, it will send a message with the `messages` array to the container:

{% include [yds-format](../../../_includes/functions/yds-format.md) %}


## See also {#see-also}

* [{#T}](../../../functions/concepts/trigger/data-streams-trigger.md)
* [{#T}](../../../api-gateway/concepts/trigger/data-streams-trigger.md)
