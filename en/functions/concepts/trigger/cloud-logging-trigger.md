# Trigger for {{ cloud-logging-name }} that invokes a {{ sf-name }} function

A [trigger](../trigger/) for {{ cloud-logging-name }} runs a {{ sf-name }} [function](../function.md) when messages are received in a [log group](../../../logging/concepts/log-group.md).

A trigger for {{ cloud-logging-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to read messages from the log group and invoke a function.

For more information about creating a trigger for {{ cloud-logging-name }}, see [{#T}](../../operations/trigger/cloud-logging-trigger-create.md).

## Roles required for the proper operation of a trigger for {{ cloud-logging-name }} {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user) and [editor](../../../iam/concepts/access-control/roles#editor) roles and higher.
* To run a trigger, the service account needs the following roles:
   * `serverless.functions.invoker` for the function that the trigger invokes.
   * `logging.reader` for the log group which, when records are added, activates the trigger.

## Format of the message from the trigger for {{ cloud-logging-name }} {#format}

After the trigger is activated, it sends the following message to the function:

{% include [logging-format](../../../_includes/functions/logging-format.md) %}

## See also {#see-also}

* [Trigger for {{ cloud-logging-name }} that calls a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/cloud-logging-trigger.md).