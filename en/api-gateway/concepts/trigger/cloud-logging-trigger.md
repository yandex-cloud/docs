# Trigger for {{ cloud-logging-name }} that sends messages to WebSocket connections

A [trigger](../trigger/) for {{ cloud-logging-name }} sends messages to [WebSocket connections](../extensions/websocket.md) when you add entries to a [log group](../../../logging/concepts/log-group.md).

A trigger for {{ cloud-logging-name }} requires a [service account](../../../iam/concepts/users/service-accounts.md) for reading from a log group and sending messages to WebSocket connections.

For more information about creating a trigger for {{ cloud-logging-name }}, see [{#T}](../../operations/trigger/cloud-logging-trigger-create.md).

{% include [batching-messages](../../../_includes/api-gateway/batching-messages.md) %}

## Roles required for the proper operation of a trigger for {{ cloud-logging-name }} {#roles}

* To create a trigger, you need a permission for the service account under which the trigger executes the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles or higher.
* For the trigger to fire, the service account needs the following roles:
   * `api-gateway.websocketBroadcaster` for the folder containing the API gateway.
   * `logging.reader` for the log group that will activate the trigger when records are added to it.

## Format of the message from the trigger for {{ cloud-logging-name }} {#format}

After the trigger fires, it will send the following message to WebSocket connections:

{% include [logging-format](../../../_includes/functions/logging-format.md) %}

## See also {#see-also}

* [Trigger for {{ cloud-logging-name }} that runs a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/cloud-logging-trigger.md)
* [Trigger for {{ cloud-logging-name }} that runs a {{ sf-name }} function](../../../functions/concepts/trigger/cloud-logging-trigger.md)
