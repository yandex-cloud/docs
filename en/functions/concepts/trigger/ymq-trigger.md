# {{ message-queue-short-name }} trigger that passes messages to the {{ sf-name }} function

The [trigger](../trigger/) for {{ message-queue-short-name }} is used to process the [message queue](../../../message-queue/concepts/queue.md). It picks up messages from the queue and passes them to a {{ sf-name }} [function](../function.md) for processing. Once successfully processed, a trigger deletes messages from the queue, and if an error occurs, it places messages back in the queue and sets a [visibility timeout](../../../message-queue/concepts/visibility-timeout.md). If the queue does not have a [Dead Letter Queue](../../../message-queue/concepts/dlq.md) configured, a message will continue to be returned to a function until it is successfully processed or until its storage timeout expires.

You can only create a trigger for a standard message queue. The trigger must be in the same cloud with the queue it reads messages from. Only one trigger can be created for each message queue.

{{ message-queue-short-name }} triggers require [service accounts](../../../iam/concepts/users/service-accounts.md) to read messages from a message queue and call a function. You can use the same service account for both operations.

## Roles required for the proper operation of a trigger for {{ message-queue-short-name }} {#roles}

* To create a trigger, you need:
   * The `{{ roles-viewer }}` role for the folder with the message queue that the trigger reads messages from.
   * The `{{ roles-viewer }}` role for the folder with the function that the trigger invokes.
   * Permission to the service account on whose behalf the trigger executes the operations. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles and higher.
* To run a trigger, service accounts need the following roles:
   * `{{ roles-editor }}` for the folder with the message queue that the trigger reads messages from.
   * `{{ roles-functions-ivoker }}` for the folder with the function that the trigger invokes.

Read more about [access management](../../security/index.md).

## {{ message-queue-short-name }} trigger message format {#format}

After the trigger picks up a message from the queue, it passes it to the function in the following format:

{% include [ymq-format](../../../_includes/functions/ymq-format.md) %}

## See also {#see-also}

* [{{ message-queue-name }} trigger that passes messages to the {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/ymq-trigger.md).
