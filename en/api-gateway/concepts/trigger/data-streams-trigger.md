---
title: Trigger for {{ yds-full-name }} that sends messages to WebSocket connections
description: In this article, you will learn about the {{ yds-name }} trigger, the format of the messages it sends, and the roles required to work with the trigger.
---

# Trigger for {{ yds-name }} that sends messages to WebSocket connections

[A trigger](../trigger/) for {{ yds-name }} sends messages to [WebSocket connections](../extensions/websocket.md) when data is sent to a [stream](../../../data-streams/concepts/glossary.md#stream-concepts).

A trigger for {{ yds-name }} requires [service accounts](../../../iam/concepts/users/service-accounts.md) to manage the stream and send messages to WebSocket connections. You can use the same service account for both operations.

For more information about creating a trigger for {{ yds-name }}, see [{#T}](../../operations/trigger/data-streams-trigger-create.md).

## Roles required for the proper operation of a trigger for {{ yds-name }} {#roles}

* To create a trigger, you need a permission for the service account under which the trigger executes the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) roles or higher.
* For the trigger to fire, service accounts need the following roles:
    * `api-gateway.websocketBroadcaster` for the folder containing the API gateway.
    * `yds.admin` for the stream that invokes the trigger when data is sent to it.

## Format of the message from the trigger for {{ yds-name }} {#format}

{% include [trigger-message-format-note](../../../_includes/functions/trigger-message-format-note.md) %}

Once the trigger fires, it will send a message with the `messages` array to WebSocket connections:

{% include [yds-format](../../../_includes/functions/yds-format.md) %}

## See also {#see-also}

* [Trigger for {{ yds-name }} that runs a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/data-streams-trigger.md)
* [Trigger for {{ yds-name }} that runs a {{ sf-name }} function](../../../functions/concepts/trigger/data-streams-trigger.md)
