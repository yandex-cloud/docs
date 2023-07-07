# Trigger for {{ message-queue-short-name }} that sends messages to the {{ serverless-containers-name }} container

The [trigger](../trigger/) for {{ message-queue-short-name }} is used to process the [message queue](../../../message-queue/concepts/queue.md). It picks up messages from the queue and passes them to a {{ serverless-containers-name }} [container](../container.md) for processing. Once successfully processed, a trigger deletes messages from the queue, and if an error occurs, it places messages back in the queue and sets a [visibility timeout](../../../message-queue/concepts/visibility-timeout.md). If the queue does not have a [Dead Letter Queue](../../../message-queue/concepts/dlq.md) configured, a message will continue to be returned to a container until it is successfully processed or until its storage timeout expires.

You can only create a trigger for a standard message queue. The trigger must be in the same cloud as the queue that messages are read from. Only one trigger can be created for each message queue.

{{ message-queue-short-name }} triggers require [service accounts](../../../iam/concepts/users/service-accounts.md) to read messages from a message queue and invoke a container. You can use the same service account for both operations.

For more information about creating a trigger for {{ message-queue-short-name }}, see [{#T}](../../operations/ymq-trigger-create.md).

## Roles required for the proper operation of a trigger for {{ message-queue-short-name }} {#roles}

* To create a trigger, you need:
   * The `{{ roles-viewer }}` role for the folder with the message queue that the trigger reads messages from.
   * The `{{ roles-viewer }}` role for the folder with the container that the trigger invokes.
   * Permission to the service account on whose behalf the trigger executes the operations. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles and higher.
* To run a trigger, service accounts need the following roles:
   * `{{ roles-editor }}`for the folder with the message queue that the trigger reads messages from.
   * `serverless.containers.invoker` for the folder with the container that invokes the trigger.

Read more about [access management](../../security/index.md).

## Trigger for {{ message-queue-short-name }} message format {#format}

After the trigger picks up a message from the queue, it passes it to the container in the following format:

{% include [ymq-format](../../../_includes/functions/ymq-format.md) %}

## See also {#see-also}

* [Trigger for {{ message-queue-name }} that sends messages to the {{ sf-name }} function](../../../functions/concepts/trigger/ymq-trigger.md).