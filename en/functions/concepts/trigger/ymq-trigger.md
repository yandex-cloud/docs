# Trigger for {{ message-queue-short-name }} that sends messages to the {{ sf-name }} function

The [trigger](../trigger/) for {{ message-queue-short-name }} is used to process the [message queue](../../../message-queue/concepts/queue.md). It picks up messages from the queue and forwards them to a {{ sf-name }} [function](../function.md) for processing. Once the messages are successfully processed, the trigger deletes them from the queue, and if an error occurs, it places the messages back in the queue and sets a [visibility timeout](../../../message-queue/concepts/visibility-timeout.md). If the queue does not have a [Dead Letter Queue](../../../message-queue/concepts/dlq.md) configured, a message will continue to be returned to a function until it is successfully processed or until its retention period expires.

{% include [ymq-trigger-note.md](../../../_includes/functions/ymq-trigger-note.md) %}

When the trigger is running, requests to the message queue are free of charge.

{{ message-queue-short-name }} triggers require [service accounts](../../../iam/concepts/users/service-accounts.md) to read messages from a message queue and call a function. You can use the same service account for both operations.

For more information about creating a trigger for {{ message-queue-short-name }}, see [{#T}](../../operations/trigger/ymq-trigger-create.md).

## Roles required for the proper operation of a trigger for {{ message-queue-short-name }} {#roles}

* To create a trigger, you need:
   * The `{{ roles-viewer }}` role for the folder with the message queue that the trigger reads messages from.
   * The `{{ roles-viewer }}` role for the folder with the function that the trigger invokes.
   * Permission to the service account on whose behalf the trigger executes the operations. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles and higher.
* For the trigger to fire, service accounts need the following roles:
   * `{{ roles-editor }}` for the folder with the message queue that the trigger reads messages from.
   * `{{ roles-functions-invoker }}` for the folder with the function that the trigger invokes.

Read more about [access management](../../security/index.md).

## Trigger for {{ message-queue-short-name }} message format {#format}

After the trigger picks up a message from the queue, it passes it to the function in the following format:

{% include [ymq-format](../../../_includes/functions/ymq-format.md) %}

## See also {#see-also}

* [Trigger for {{ message-queue-name }} that sends messages to the {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/ymq-trigger.md).