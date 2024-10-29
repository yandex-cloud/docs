# Trigger for {{ message-queue-short-name }} that sends messages to WebSocket connections

The [trigger](../trigger/) for {{ message-queue-short-name }} takes the load off the [message queue](../../../message-queue/concepts/queue.md). It collects messages from the queue and forwards them to [WebSocket connections](../extensions/websocket.md).

{% include [ymq-trigger-note.md](../../../_includes/functions/ymq-trigger-note.md) %}

When the trigger is running, requests to the message queue are free of charge.

A trigger for {{ message-queue-short-name }} requires [service accounts](../../../iam/concepts/users/service-accounts.md) to read messages from a message queue and send them to WebSocket connections. You can use the same service account for both operations.

For more information about creating a trigger for {{ message-queue-short-name }}, see [{#T}](../../operations/trigger/ymq-trigger-create.md).

## Roles required for the proper operation of a trigger for {{ message-queue-short-name }} {#roles}

* To create a trigger, you need:
   * `{{ roles-viewer }}` role for a folder with a message queue the trigger reads messages from.
   * `{{ roles-viewer }}` role for a folder containing the API gateway whose WebSocket connections the trigger sends messages to.
   * Permission for the service account under which the trigger executes the operations. This permission comes with the [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user) and [editor](../../../iam/roles-reference.md#editor) roles or higher.
* For the trigger to fire, service accounts need the following roles:
   * `{{ roles-editor }}` for the folder with the message queue that the trigger reads messages from.
   * `api-gateway.websocketBroadcaster` for the folder containing the API gateway.

Read more about [access management](../../security/index.md).

## {{ message-queue-short-name }} trigger message format {#format}

After the trigger collects a message from the queue, it will send it to WebSocket connections in the following format:

{% include [ymq-format](../../../_includes/functions/ymq-format.md) %}

## See also {#see-also}

* [Trigger for {{ message-queue-name }} that sends messages to a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/ymq-trigger.md)
* [Trigger for {{ message-queue-name }} that sends messages to a {{ sf-name }} function](../../../functions/concepts/trigger/ymq-trigger.md)
