# Trigger for {{ message-queue-short-name }} that sends messages to the {{ serverless-containers-name }} container

The [trigger](../trigger/) for {{ message-queue-short-name }} takes the load off the [message queue](../../../message-queue/concepts/queue.md). It picks up messages from the queue and passes them to a {{ serverless-containers-name }} [container](../container.md) for processing. Once the messages are successfully processed, the trigger deletes them from the queue, and if an error occurs, it places the messages back in the queue and sets a [visibility timeout](../../../message-queue/concepts/visibility-timeout.md). If the queue does not have a [Dead Letter Queue](../../../message-queue/concepts/dlq.md) configured, a message will continue to be returned to a container until it is successfully processed or until its retention period expires.

{% include [ymq-trigger-note.md](../../../_includes/functions/ymq-trigger-note.md) %}

When the trigger is running, requests to the message queue are free of charge.

{{ message-queue-short-name }} triggers require [service accounts](../../../iam/concepts/users/service-accounts.md) to read messages from a message queue and invoke a container. You can use the same service account for both operations.

For more information about creating a trigger for {{ message-queue-short-name }}, see [{#T}](../../operations/ymq-trigger-create.md).

## Roles required for the proper operation of a trigger for {{ message-queue-short-name }} {#roles}

* To create a trigger, you need:
   * `{{ roles-viewer }}` role for a folder with a message queue the trigger reads messages from.
   * `{{ roles-viewer }}` role for the folder with the container that the trigger invokes.
   * Permission for the service account under which the trigger executes the operations. This permission comes with the [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user) and [editor](../../../iam/roles-reference.md#editor) roles or higher.
* For the trigger to fire, service accounts need the following roles:
   * `{{ roles-editor }}` for the folder with the message queue that the trigger reads messages from.
   * `serverless.containers.invoker` for the folder with the container that invokes the trigger.

Read more about [access management](../../security/index.md).

## {{ message-queue-short-name }} trigger message format {#format}

After the trigger picks up a message from the queue, it forwards it to the container in the following format:

{% include [ymq-format](../../../_includes/functions/ymq-format.md) %}


## See also {#see-also}

* [{#T}](../../../functions/concepts/trigger/ymq-trigger.md)
* [{#T}](../../../api-gateway/concepts/trigger/ymq-trigger.md)
