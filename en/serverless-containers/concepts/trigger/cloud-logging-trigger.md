# Trigger for {{ cloud-logging-name }} that invokes a {{ serverless-containers-name }} container

A [trigger](../trigger/) for {{ cloud-logging-name }} invokes a {{ serverless-containers-name }} [container](../container.md) when messages are received in a [log group](../../../logging/concepts/log-group.md).

A trigger for {{ cloud-logging-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to read messages from the log group and invoke a container.

For more information about creating a trigger for {{ cloud-logging-name }}, see [{#T}](../../operations/cloud-logging-trigger-create.md).

{% include [batching-messages](../../../_includes/serverless-containers/batching-messages.md) %}

## Roles required for the proper operation of a trigger for {{ cloud-logging-name }} {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user) and [editor](../../../iam/concepts/access-control/roles#editor) roles and higher.
* For a trigger to work, the service account needs the following roles:
   * `serverless.containers.invoker` for the container that the trigger invokes.
   * `logging.reader` for the log group that will activate the trigger when records are added to it.

## Format of the message from the trigger for {{ cloud-logging-name }} {#format}

After the trigger is activated, it sends the following message to the container:

{% include [logging-format](../../../_includes/functions/logging-format.md) %}

## See also {#see-also}

* [Trigger for {{ cloud-logging-name }} that invokes a {{ sf-name }} function](../../../functions/concepts/trigger/cloud-logging-trigger.md).
